from man import variables as variables
from man.operations.template import Template as Template


Template(
    'dotfiles/templates/.gitconfig',
    '~/.gitconfig',
    values={
        "user": variables.USER,
        "credential": variables.CREDENTIAL,
        "github": variables.GITHUB,
        "commit": variables.COMMIT,
    }
).copy_to_destination()
