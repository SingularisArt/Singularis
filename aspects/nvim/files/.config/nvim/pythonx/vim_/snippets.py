# vim:set et fileencoding=utf8 sts=0 sw=4 ts=4:

"""Helper methods used in UltiSnips snippets."""

import string
import vim
import re


def complete(tab, opts):
    el = [x for x in tab]
    pat = "".join(list(map(lambda x: x + r"\w*" if re.match(r"\w", x) else x,
                           el)))
    try:
        opts = [x for x in opts if re.search(pat, x, re.IGNORECASE)]
    except Exception:
        opts = [x for x in opts if x.startswith(tab)]
    if not len(opts) or str.lower(tab) in list(map(str.lower, opts)):
        return ""
    cads = "|".join(opts[:5])
    if len(opts) > 5:
        cads += "|..."
    return "({0})".format(cads)


def _parse_comments(s):
    i = iter(s.split(","))

    rv = []
    try:
        while True:
            # get the flags and text of a comment part
            flags, text = next(i).split(':', 1)

            if len(flags) == 0:
                rv.append(('OTHER', text, text, text, ""))
            # parse 3-part comment, but ignore those with O flag
            elif 's' in flags and 'O' not in flags:
                ctriple = ["TRIPLE"]
                indent = ""

                if flags[-1] in string.digits:
                    indent = " " * int(flags[-1])
                ctriple.append(text)

                flags, text = next(i).split(':', 1)
                assert flags[0] == 'm'
                ctriple.append(text)

                flags, text = next(i).split(':', 1)
                assert flags[0] == 'e'
                ctriple.append(text)
                ctriple.append(indent)

                rv.append(ctriple)
            elif 'b' in flags:
                if len(text) == 1:
                    rv.insert(0, ("SINGLE_CHAR", text, text, text, ""))
    except StopIteration:
        return rv


def get_comment_format():
    commentstring = vim.eval("&commentstring")
    if commentstring.endswith("%s"):
        c = commentstring[:-2]
        return (c.rstrip(), c.rstrip(), c.rstrip(), "")
    comments = _parse_comments(vim.eval("&comments"))
    for c in comments:
        if c[0] == "SINGLE_CHAR":
            return c[1:]
    return comments[0][1:]


def make_box(twidth, bwidth=None):
    b, m, e, i = (s.strip() for s in get_comment_format())
    m0 = m[0] if m else ''
    bwidth_inner = bwidth - 3 - \
        max(len(b), len(i + e)) if bwidth else twidth + 2
    sline = b + m + bwidth_inner * m0 + 2 * m0
    nspaces = (bwidth_inner - twidth) // 2
    mlines = i + m + " " + " " * nspaces
    mlinee = " " + " "*(bwidth_inner - twidth - nspaces) + m
    eline = i + m + bwidth_inner * m0 + 2 * m0 + e
    return sline, mlines, mlinee, eline


def foldmarker():
    return vim.eval("&foldmarker").split(",")


def display_width(str):
    try:
        # Respect &ambiwidth and &tabstop, but old vim may not support this
        return vim.strdisplaywidth(str)
    except AttributeError:
        # Fallback
        from unicodedata import east_asian_width
        result = 0
        for c in str:
            result += 2 if east_asian_width(c) in ('W', 'F') else 1
        return result


def has_cjk(s):
    cjk_re = re.compile(u'[⺀-⺙⺛-⻳⼀-⿕々〇〡-〩〸-〺〻㐀-䶵一-鿃豈-鶴侮-頻並-龎]', re.UNICODE)

    return cjk_re.search(s) is not None


LOREM = """Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam
nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam
voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita
kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
"""
