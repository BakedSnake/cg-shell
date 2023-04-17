### CG Shell
A custom zsh shell with git, suggestions, history substrings and more.

#### Support
Currently this scripts works with Gentoo, Arch, Debian, OpenSuse and Ubuntu.

It downloads the required dependencies into **~/.clones**, and installs zsh plugins into **/usr/share/zsh/site-functions**. The **~/clones** directory can be deleted after the setup is done.

This script adds some aliases that may or may not mention programs that may not be installed in your system, ie. vim or nvim.

Other than that it will install zsh from your OS repo, and so all it's dependencies.

#### Usage
Run the script with sudo or doas:
```
$ doas ./cg-shell_setup.sh
```

When prompted type in user, and some env variables.
