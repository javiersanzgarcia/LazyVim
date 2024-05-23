# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

And added personal (and so lazy) config, special check over keymaps and plugins,
This repository is a continuos WIP, Optimizing how works LazyVim for me.

Should be installed for a correct funcionality:

- ripgrep
- lazygit
- xclip
- gcc
- NVM && Node (more than 18) 

Curent version working for:

- Web development (HTML, CSS, Javascript, Typescript, React, Tailwind)
- Java (Is not necessary installation for the plugin)
- Lua

In this current version, these languages are deactivated (but is possible to activate in lua/config/lazy.lua)

- Docker
- go1.21
- Python (and virtual environment)
- Rust & Cargo
- Yaml

## Known Issues


If you see that kind of error:

```
    ● dashboard-nvim 0.53ms  VimEnter
        error: cannot update the ref 'refs/remotes/origin/master': unable to append to '.git/logs/refs/remotes/origin/master': Permiso denegado
        Desde https://github.com/nvimdev/dashboard-nvim
         ! 6813009..6d06924  master     -> origin/master  (no es posible actualizar el ref local)
```

You should go to ~/.local/share/nvim/lazy/ and look for the name of the plugin and remove .git directory from each plugin

## Reset IDE
If you need to reset to scratch the whole configuration, without edit LazyExtras:

```
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

and restart the editor

