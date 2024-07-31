<!-- vim: set et ai ts=4 sw=4 ai ft=markdown : -->

# Dotvim

This repository is for maintaining a shared config for Vim and Nvim.

## Setup

This section includes instructions for setting up the config with Vim and Nvim.
The Vim section is a prerequisite to the Nvim section below because the configs
are shared.

Linux instructions are written for [GNU Bash][]. Windows instructions are
written for the [Git SCM][] shell (a.k.a. "Git Bash").

### Vim

1. Clone repository:

    1. Use HTTPS (preferred):

        ```bash
        git clone https://github.com/btauras/dotvim.git ~/.vim
        ```

    2. Use SSH (alternative):

        ```bash
        ssh -T git@github.com
        git clone git@github.com:btauras/dotvim.git ~/.vim
        ```

2. Set up symlinks:

    ```bash
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
    ```

    For Windows, use the [Windows command interpreter][]'s `mklink` command
    instead:

    ```bash
    cmd //c mklink //j "$HOME/.vimrc" "$HOME/.vim/vimrc"
    cmd //c mklink //j "$HOME/.gvimrc" "$HOME/.vim/gvimrc"
    ```

3. Update submodules:

    ```bash
    cd ~/.vim
    git submodule sync --recursive
    git submodule update --recursive --init
    git submodule foreach --recursive git pull
    ```

### Nvim

Create an `init.vim` file for Nvim:

```bash
mkdir -p ~/.config/nvim/
cat > ~/.config/nvim/init.vim << EOF
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
EOF
```

For Windows, use `$HOME/AppData/Local/nvim/init.vim` for the above.

## References

- [GNU Bash][]
- [Git SCM][]
- [Synchronizing plugins with git submodules and pathogen][]
- [Transitioning to Nvim from Vim][nvim from vim]

[GNU Bash]: https://www.gnu.org/software/bash/
[Git SCM]: https://git-scm.com/
[Windows command interpreter]: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/cmd
[Synchronizing plugins with git submodules and pathogen]: http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
[nvim from vim]: https://neovim.io/doc/user/nvim.html#nvim-from-vim
