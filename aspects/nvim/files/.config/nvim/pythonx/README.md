# Snippet Dependencies

These python files are required to be able to use my custom UltiSnips snippets,
which can be found [here](https://github.com/SingularisArt/snippets).

Here's how you install it:

```bash
cd ~/.config/nvim;
git submodule add --name "pythonx" https://github.com/SingularisArt/snippet-dependencies pythonx
```

After that, this is how your nvim folder should look like:

```
├── init.lua
├── LICENSE
├── lua
│   └── SingularisArt
│       ├── vimtex.lua
│       └── ...
├── pythonx (This folder is this submodule)
├── README.md
└── UltiSnips
    ├── xml.snippets
    └── ...
```
