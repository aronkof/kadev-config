# KADEV CONFIG 2022
### Setup created based on Ubuntu 20.04

1. upgrade/update Ubuntu package manager apt
  + `sudo apt-get upgrade && sudo apt-get update`

2. install initial dependencies
  + `sudo apt install curl git xclip maim parcellite pavucontrol`

3. create a parcellite systemd service
  + `touch /home/aron/.config/systemd/user/parcellite.service`
  + <pre><code>
    [Unit]
    Description=Parcellite clipboard manager

    [Service]
    Type=forking
    ExecStart=parcellite -n
    Restart=on-failure
    RestartSec=3

    [Install]
    WantedBy=default.target
    </pre></code>

  + `systemctl --user daemon-reload`
  + `systemctl --user enable parcellite.service`
  + `systemctl --user start parcellite.service`

4. install neovim latest version with app image and make it executable(requires `sudo`)
  + `curl -Lo ~/usr/bin/nvim https://github.com/neovim/neovim/releases/latest/download/nvim.appimage`
  + `chmod u+x ~/usr/bin/nvim`

5. install vimplug for neovim
  + `sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'`

6. clone kadevrc and create the symlink
  + `git clone https://github.com/aronkof/kadevrc.git`
  + `ln -s ~/kadevrc ~/projects/kadevrc/kadevrc`
  + `source ~/.bashrc`

7. install c++ deps
  + `sudo apt install gcc clang g++`

8. install i3, logout and log in using i3 instead of Ubuntu
  + `sudo apt install i3`
  + after doing the first i3 login choose to build a config file using the `Win` key instead of `alt`

9. update i3 settings from kadevrc
  + lets copy to both possible config locations
    + `mkdir $HOME/.i3 && mkdir $HOME/.config/i3`
    + `cp ~/projects/kadevrc/dot-config/i3/config $HOME/.i3/`
    + `cp ~/projects/kadevrc/dot-config/i3/config $HOME/.config/i3/`

10. install exa to replace `ls`
  + `curl https://sh.rustup.rs -sSf | sh`
  + `source $HOME/.cargo/env`
  + `cargo install exa`

11. install bat to replace `cat`
  + `sudo apt install bat`

12. install **chrome** and **zoom** from their official website

13. install gnome terminal themes
  + `bash -c "$(wget -qO- https://git.io/vQgMr)"`
  + gruvbox dark id at the time: **72**

14. install Caskaydia Cove Nerd Font from [nerdfonts](https://www.nerdfonts.com/font-downloads)
  + `mkdir ~/.local/share/fonts`
  + copy the extracted fonts to the local fonts folder

15. create the 80_xmodmap file to enable 60% keyboards(if using one, like ck62)
  + sudo touch /etc/X11/Xsession.d/80_xmodmap
  + <pre><code>
    #!/bin/sh
    if [ -x /usr/bin/xmodmap ]; then
      /usr/bin/xmodmap /home/aron/projects/kadevrc/kadevrc/keyboard-mappers/ck62.Xmodmap || true
    fi
    </pre></code>

16. update/install nvidia drivers if needed
  + run `nvidia-detector` to find which driver needs to be installed then use `apt` to do so
  + `sudo apt install nvidia-driver-<version-from-detector>`

17. language support
  + install [Go](https://go.dev/doc/install) from the official website to get the latest version
  + install [NVM](https://github.com/nvm-sh/nvm) from the official repo, since the script changes from time to time
  + download **clojure-lsp** from the [official releases](https://github.com/clojure-lsp/clojure-lsp/releases) to the
  `~/projects/bin` folder

18. SSH and GPG setup(machine side setup)
  + `ssh-keygen -t ed25519 -C <your_email>`
  + `eval "$(ssh-agent -s)"`
  + `ssh-add ~/.ssh/id_ed25519`
  + use the public key(id_ed25519.pub) content to set it on your VCS of choice
  + `gpg --full-generate-key`
  + select 4096 size
  + list your GPG keys and look for the key ID(it a format similar to this example: 3AA5C34371567BD2)
  + `gpg --list-secret-keys --keyid-format=long`
  + use the this command `gpg --armor --export <your_gpg_key_id>` to print the GPG key and set it on your VCS of choice

19. git settings
  + add this to your `.gitconfig` file
    - <pre><code>
      [url "ssh://git@github.com/"]
        insteadOf = https://github.com/
      [core]
        editor = nvim
      [commit]
        gpgsign = true
      </pre></code>

20. extra - setup **x11vnc** to enable ipad as an external monitor
  + `sudo apt install x11vnc`
  + if your current machine has an intel processor, you can install **virtscreen**
  + if you're working with NVIDIA graphics you'll need a dummy hdmi monitor dongle
  + configure the desired resolution(recommended 1280x1024 or similar) on **nvidia-settings**
  + create a new systemd service
  + `touch /home/aron/.config/systemd/user/vnc.service`
  + <pre><code>
    [Unit]
    Description=x11vnc service to enable dual monitor with dummy hdmi dongle

    [Service]
    Type=simple
    ExecStart=x11vnc -cursor -clip xinerama1
    Restart=on-failure
    RestartSec=3

    [Install]
    WantedBy=default.target
    </pre></code>

### useful information
  * nvidia-settings screen settings file path is "/etc/X11/xorg.conf"
  * enable bluetooth support:
    + `sudo apt install blueman`
    + add `ControllerMode="bredr"` at "/etc/bluetooth/main.conf"
  * the install script under development
