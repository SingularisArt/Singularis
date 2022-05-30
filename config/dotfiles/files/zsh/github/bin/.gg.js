const child_process = require('child_process');
const fs = require('fs');
const path = require('path');
const {createInterface} = require('readline');

const TOOL_NAME = 'gg';

function log(...messages) {
  console.log(...messages);
}

function error(...messages) {
  log('error: ', ...messages);
}

function die(...messages) {
  if (messages.length) {
    log(...messages);
  }
  process.exit(1);
}

async function confirm(prompt) {
  const readline = createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  return new Promise((resolve) => {
    readline.question(`${prompt} [y/n] `, resolve);

    readline.write('y');
  })
    .then((result) => {
      return /^\s*y(es?)?\s*$/i.test(result);
    })
    .finally(() => {
      readline.close();
    });
}

// The lowest signal number (via `man 3 signal`).
const SIGHUP = 1;

// The highest signal number (via `man 3 signal`).
const SIGUSR2 = 31;

function run(command, ...args) {
  return new Promise((resolve, reject) => {
    let resolved = false;
    const child = child_process.spawn(command, args, {stdio: 'inherit'});

    process.on('SIGINT', () => {
      child.kill('SIGINT');
    });

    child.on('error', (err) => {
      if (!resolved) {
        resolved = true;
        reject(err);
      }
    });

    child.on('exit', (code) => {
      if (!resolved) {
        resolved = true;
        if (code) {
          let err;
          const description = `\`${[command, ...args].join(' ')}\``;
          if (code >= 128 + SIGHUP && code <= 128 + SIGUSR2) {
            err = new Error(
              `${description} exited due to signal ${code - 128}`
            );
          } else {
            err = new Error(`${description} exited with status ${code}`);
          }
          reject(err);
        } else {
          resolve();
        }
      }
    });
  });
}

async function getHelper(command) {
  if (command.match(/^\w+$/)) {
    const dir = path.join(__dirname, `${TOOL_NAME}-helpers`);
    const helper = path.join(dir, command);

    try {
      fs.accessSync(helper, fs.constants.X_OK);

      if (fs.statSync(helper).isFile()) {
        return helper;
      }
    } catch (error) {
      if (error.code === 'ENOENT') {
        // Check for a possible match.
        const candidates = fs
          .readdirSync(dir)
          .filter((entry) => /^[a-z]/.test(entry));

        const prefixMatches = candidates.filter((entry) =>
          entry.startsWith(command)
        );

        if (prefixMatches.length === 1) {
          // Unambiguous prefix match.
          return getHelper(prefixMatches[0]);
        } else if (prefixMatches.length > 1) {
          // Multiple possible prefix matches.
          log(
            `Ambiguous command ${JSON.stringify(
              command
            )} - did you mean one of?\n` +
              '\n' +
              prefixMatches.map((prefix) => `  ${prefix}`).join('\n') +
              '\n'
          );
        } else {
          // Prompt for confirmation of best fuzzy match guess.
          const fuzzyMatches = candidates
            .map((candidate) => ({
              candidate,
              score: jaroWinkler(candidate, command),
            }))
            .filter(({score}) => score)
            .sort((a, b) => {
              if (a.score < b.score) {
                return -1;
              } else if (a.score > b.score) {
                return 1;
              } else {
                return 0;
              }
            })
            .reverse();

          const proposed = fuzzyMatches[0];

          if (proposed) {
            log(
              `Command ${JSON.stringify(
                command
              )} invoked, which does not exist.\n`
            );

            const proceed = await confirm(
              `Do you want to run ${JSON.stringify(
                proposed.candidate
              )} instead?`
            );

            if (proceed) {
              return getHelper(proposed.candidate);
            }
          }
        }
      }
    }
  }
}

/**
 * Compute Jaro-Winkler similarity index (0 to 1).
 *
 * See: https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance
 *
 * Original C implementation: https://web.archive.org/web/19990822155334/http://www.census.gov/geo/msb/stand/strcmp.c
 *
 * Based on: https://github.com/jordanthomas/jaro-winkler/blob/fd14e7a65e10e63d/index.js
 *
 * The MIT License (MIT)
 * Copyright (c) 2015 Jordan Thomas
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */
function jaroWinkler(a, b) {
  if (!a.length || !b.length) {
    // Empty strings match nothing, not even each other.
    return 0;
  }

  const s1 = a.toLowerCase();
  const s2 = b.toLowerCase();

  if (s1 === s2) {
    // Exact match.
    return 1;
  }

  let m = 0;

  const range = Math.floor(Math.max(s1.length, s2.length) / 2) - 1;
  const s1Matches = new Array(s1.length);
  const s2Matches = new Array(s2.length);

  for (let i = 0; i < s1.length; i++) {
    const low = i >= range ? i - range : 0;
    const high = i + range <= s2.length - 1 ? i + range : s2.length - 1;

    for (let j = low; j <= high; j++) {
      if (s1Matches[i] !== true && s2Matches[j] !== true && s1[i] === s2[j]) {
        ++m;

        s1Matches[i] = s2Matches[j] = true;

        break;
      }
    }
  }

  if (m === 0) {
    // No matching letters.
    return 0;
  }

  // Count transpositions.
  let k = 0;
  let transpositions = 0;

  for (let i = 0; i < s1.length; i++) {
    if (s1Matches[i] === true) {
      let j;

      for (j = k; j < s2.length; j++) {
        if (s2Matches[j] === true) {
          k = j + 1;
          break;
        }
      }

      if (s1[i] !== s2[j]) {
        ++transpositions;
      }
    }
  }

  // "sim" is the Jaro similarity ("sim[j]").
  let sim = (m / s1.length + m / s2.length + (m - transpositions / 2) / m) / 3;

  // Apply prefix scaling to obtain Jaro-Winkler similarity ("sim[w]").

  // Length of common prefix (up to a maximum of 4 characters).
  let l = 0;

  // Scaling factor. 0.1 is standard, 0.25 is upper limit to prevent similarity
  // from exceeding 1.
  const p = 0.1;

  if (sim > 0.7) {
    while (s1[l] === s2[l] && l < 4) {
      ++l;
    }

    sim = sim + l * p * (1 - sim);
  }

  return sim;
}

const HELP = `run \`${TOOL_NAME} help\` to see available commands`;

async function main(_node, _script, command, ...args) {
  if (!command) {
    die(`must supply command: ${HELP}`);
  }
  const helper = await getHelper(command);
  if (!helper) {
    die(`no such command: ${command} - ${HELP}`);
  }

  await run(helper, ...args);
}

main(...process.argv).catch((err) => {
  error(err);
  process.exit(1);
});

// vim: ft=javascript
