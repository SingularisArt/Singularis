# "Man"agement, a framework to manage my dotfiles

I'm currently working on a framework that'll manage my dotfiles for me. Here're
some things I would like to accomplish with this framework:

- Automatically install everything of mine:
  * Crons
  * Configurations
  * GPG Key
  
I also have a security feature in mind.

## Security Feature

Each folder's going to have a sha256 hash associated with it. For example, the
[dotfiles](../config/dotfiles) is going to have its hash stored in the
`./sha256/dotfiles`. Everytime the framework will install the aspect (in this
example, dotfiles), it'll grab the current sha256 hash of the dotfiles folder
and compare it against the one found in the file (`./sha256/dotfiles`). If it
doesn't match, it'll give you an error and quit. But, you can always disable
this feature by using the `--no-secure` argument (which isn't recommended).
