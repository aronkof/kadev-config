# KADEV CONFIG 2022
### Setup created based on Ubuntu 20.04

1. upgrade/update Ubuntu package manager apt
  + `sudo apt-get upgrade && sudo apt-get update`

2. install initial dependencies
  + `sudo apt install curl git xclip maim parcellite pavucontrol stow gcc clang g++ i3 blueman`

3. execute the install script to create dotfiles symlinks
  + `./install.sh`

4. install neovim latest version with app image and make it executable(requires `sudo`)
  + `curl -Lo ~/usr/bin/nvim https://github.com/neovim/neovim/releases/latest/download/nvim.appimage`
  + `chmod u+x ~/usr/bin/nvim`

5. install vimplug for neovim
  + `sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'`

6. logout and log in using i3 instead of Ubuntu

7. install exa to replace `ls`
  + `curl https://sh.rustup.rs -sSf | sh`
  + `source $HOME/.cargo/env`
  + `cargo install exa`

8. install bat to replace `cat`
  + `sudo apt install bat`

9. install **chrome** and **zoom** from their official website

10. install gnome terminal themes
  + `bash -c "$(wget -qO- https://git.io/vQgMr)"`
  + gruvbox dark id at the time: **72**

11. install Caskaydia Cove Nerd Font from [nerdfonts](https://www.nerdfonts.com/font-downloads)
  + `mkdir ~/.local/share/fonts`
  + copy the extracted fonts to the local fonts folder

12. create the 80_xmodmap file to enable 60% keyboards(if using one, like ck62)
  + sudo touch /etc/X11/Xsession.d/80_xmodmap
  + <pre><code>
    #!/bin/sh
    if [ -x /usr/bin/xmodmap ]; then
      /usr/bin/xmodmap /home/aron/projects/kadevrc/kadevrc/keyboard-mappers/ck62.Xmodmap || true
    fi
    </pre></code>

13. update/install nvidia drivers if needed
  + run `nvidia-detector` to find which driver needs to be installed then use `apt` to do so
  + `sudo apt install nvidia-driver-<version-from-detector>`

14. language support
  + install [Go](https://go.dev/doc/install) from the official website to get the latest version
  + install [NVM](https://github.com/nvm-sh/nvm) from the official repo, since the script changes from time to time
  + download **clojure-lsp** from the [official releases](https://github.com/clojure-lsp/clojure-lsp/releases) to the
  `~/projects/bin` folder

15. SSH and GPG setup(machine side setup)
  + `ssh-keygen -t ed25519 -C <your_email>`
  + `eval "$(ssh-agent -s)"`
  + `ssh-add ~/.ssh/id_ed25519`
  + use the public key(id_ed25519.pub) content to set it on your VCS of choice
  + `gpg --full-generate-key`
  + select 4096 size
  + list your GPG keys and look for the key ID(it a format similar to this example: 3AA5C34371567BD2)
  + `gpg --list-secret-keys --keyid-format=long`
  + add your signing key to git `git config --global user.signingkey <your_gpg_key>`
  + use the this command `gpg --armor --export <your_gpg_key_id>` to print the GPG key and set it on your VCS of choice

16. git settings
  + add this to your `.gitconfig` file
    - <pre><code>
      [url "ssh://git@github.com/"]
        insteadOf = https://github.com/
      [core]
        editor = nvim
      [commit]
        gpgsign = true
      </pre></code>

### useful information
  * nvidia-settings screen settings file path is "/etc/X11/xorg.conf"
  * enable bluetooth support for TWS headphones:
    + add `ControllerMode="bredr"` at "/etc/bluetooth/main.conf"
