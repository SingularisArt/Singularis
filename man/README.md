# "Man"agement, a framework to manage my dotfiles

## Overview of the directory structure

Here's how the basic directory structure for each aspect looks like (this is
the dotfiles structure):

```bash
.
├── aspect.json
├── files
│   ├── .config
│   │   ├── anki
│   │   └── ...
│   ├── .home
│   │   ├── .xprofile
│   │   └── ...
│   └── .local
│       ├── bin
│       │   ├── ani-cli
│       │   └── ...
│       └── share
│           ├── autojump
│           └── ...
├── index.py
└── templates
    └── .home
        ├── .gitconfig
        └── ...
```

### Content of the aspect.json file

Here's an example `aspect.json` file (from my dotfiles aspects):

```json
{
  "description": "All my dotfiles",
  "templates": {
    ".home/.gitconfig": [
      "user",
      "credential",
      "github",
      "commit"
    ]
  },
  "packages": []
}
```

### Content of the index.py file

Here's an example `index.py` file (from my dotfiles aspects):

```python
#!/usr/bin/python3.10

from man.operations.file import Files as Files
from man.operations.package import Packages as Packages
from man.operations.template import Templates as Templates


Files('dotfiles')
Templates('dotfiles')
Packages('dotfiles')
```

## Installing files

To install all the files in the `files` directory in each of my aspects, I
created two classes:

1. File
2. Files

The `File` class holds information on an individual file, which includes (but
not limited to) the file's location, destination, type (home, config, or local)
and hash.

The `Files` class is a list of `File` objects for each file in the given
aspect.

Now, I'm going to go in depth on how everything works. Be aware, this gets
really complicated, but if you can understand (which you can), it'll be very
COOL!

### A more in depth look at the File class

Here's the basic definition of the `File` class:

```python
class File(InitClass):
    def __init__(self, file_name, root_folder, type):
        InitClass.__init__(self)
```

The `InitClass` is a class that holds all the basic variables like the aspects
directory, config directory, etc.

This class takes a couple of parameters.

1. The file name
2. The root directory
3. The type, which can either be: `config`, `home`, or `local`.

The reason I need the `type` argument is because that's how I determine where
the file needs to be installed. As you can see in the above directory tree,
there are 3 different file locations.

1. `.config`
2. `.home`
3. `.local`

Everything in the `.config` directory is going to be symlink to the `~/.config`
directory.

Everything in the `.home` directory is going to be symlink to the `~/`
directory.

Everything in the `.local` directory is going to be symlink to the `~/.local`
directory.

I then created the `install` method, which just installs the file by symlinking
it to the appropriate location.

But, if the file is in the `.local` directory, things get a bit complicated.
Instead of symlinking the entire directory to `~/.local`, I need to symlink
everything in the file directory to the location. For example, I have the
following file: `aspects/dotfiles/files/.local/bin/`. I can't symlink that over
to `~/.local/bin` because it'll overwrite everything else, which isn't what we
want. So, I'll symlink `aspects/dotfiles/files/.local/bin/*` to `~/.local/bin`.

### A more in depth look at the Files class

The `Files` class is way simplier than the `File` class. Here's the class's
definition:

```python
class Files(InitClass, dict):
    def __init__(self, aspect):
        InitClass.__init__(self)
```

As you can see, the class just needs the aspect that you would like to install.
The class gets all the files within the directory and creates a list of `File`
objects with those files.

## Installing templates

Installing templates is almost like installing the files, except there's a
twist. The templates are stored just as the files are stored.

When installing the templates, I have snippets that I need to use, which are
stored in:

1. `man/templates/.home/`
2. `man/templates/.config/`
3. `man/templates/.local/`

This is where the `aspect.json` file comes into play. As you can see from
above, it lists all the templates with a bit more information. The extra info
is the snippets that are required to complete the template.

## Installing packages (beta)

This is still in its beta stage.

## Logging (beta)

This is still in its beta stage.

## Hash security feature (beta)

This is still in its beta stage.

## Arguments

### -h/--help

Display the help page.
