<!-- vim: set et ai ts=4 sw=4 ai ft=markdown : -->

# Dotvim

This repository is for maintaining a shared config for Vim and Nvim.

## Setup

This section includes instructions for setting up the config with Vim and Nvim.
The configs are shared, so the Vim section is a prerequisite to the Nvim
section below.

Linux instructions are written for bash. Windows instructions are written for
the [Git SCM](https://git-scm.com/) shell (a.k.a. "git-bash").

### Vim

#### References:

[Synchronizing plugins with git submodules and pathogen](
http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/)

#### Instructions:

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

    For Windows, use call `mklink` from Windows Command Prompt instead:

    ```bash
    cmd //c mklink //j "$HOME/.vimrc" "$HOME/.vim/vimrc"
    cmd //c mklink //j "$HOME/.gvimrc" "$HOME/.vim/gvimrc"
    ```

3. Update submodules:

    ```bash
    cd ~/.vim
    git submodule init
    git submodule sync --recursive
    git submodule update --recursive
    ```

### Nvim

#### References:

[Transitioning from Vim](https://neovim.io/doc/user/nvim.html#nvim-from-vim)

#### Instructions:

Create an `init.vim` file for Nvim:

    ```bash
    cat << EOF > ~/.config/nvim/init.vim
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath=&runtimepath
    source ~/.vimrc
    EOF
    ```

For Windows, use `$HOME/AppData/Local/nvim/init.vim` for the above.
