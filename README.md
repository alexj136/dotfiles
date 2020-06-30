## AlexJ136's Dotfiles Repository
```
./init
stow all
```
will put the files in place.
```
stow -D all
```
will remove them.
Oh, and you might need to
```
sudo apt install stow
```
The files in `misc/` are not for stow, and should be handled on a per-file
basis.
