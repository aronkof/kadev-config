# This is a guid to do a full, step-by-step i3 manjaro installation for software development

* install distro with proprietary drivers if using nvidia GPUs this is a MUST
* nvidia-settings: persist to correct path "/etc/X11/mhwd.d/nvidia.conf"
* add `ControllerMode="bredr"` @/etc/bluetooth/main.conf
* upgrade AUR packages
* `$ pacman -S gcc neovim unzip the_silver_searcher ripgrep yay`
* `$ pacman -Syu sof-firmware pulseaudio pulseaudio-bluetooth blueman`
* `$ sudo systemctl enable bluetooth`
* install vimplug and languages support: nvm, go, clojure
* install *kadevrc*
---
* **install docker**
  + `$ pacman -S docker`
  + `$ systemctl start docker.service`
  + `$ systemctl enable docker.service`
  + `$ docker info`
  + `$ groupadd docker`
  + `$ gpasswd -a <your_user> docker`
  + `$ sudo pacman -S docker-compose`

* **cedilla fix**
  + create a `.XCompose` file at your home folder with the content below:
    - <code>include "%L"<br><dead_acute> <C> : "Ç" Ccedilla # LATIN CAPITAL LETTER C WITH CEDILLA<br><dead_acute> <c> : "ç" ccedilla # LATIN SMALL LETTER C WITH CEDILLA</code>
  + create a `environment` file at your `/etc/` folder with the content below:
    - <code>GTK_IM_MODULE=cedilla<br>QT_IM_MODULE=cedilla</code>
