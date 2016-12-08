## AlexJ136's Dotfiles Repository

I keep my configuration files here.

Configs are organised by category, where each category has its own directory. For example, config files relating specifically to command-line stuff are in `console`, and ones relating to the i3 window manager are in `i3`.

The directory for each category mimics the folder structure of `~`. So for a config file that goes in `~`, the file is placed directly within the category directory. For example, a config file in the `stuff` category called `thing.rc` that goes in `~/.config/thing/`, the file will be at `stuff/.config/thing/thing.rc` relative to the root of the repo.

This organisation scheme allows easy management using GNU stow.

#### Setup

- Clone this repository from `~`.
- `cd` into it
- 'stow' all the desired categories. You will almost certainly want to do this for the `bin` and `console` categories. For machines running a X, you will want to do it for `xorg-common` and just one of the window manager categories (`i3`, `openbox` or `xmonad`):

    stow console
    stow bin
    stow xorg-common
    stow i3

- To 'unstow' a category, use the `-D` flag:

    stow -D i3
