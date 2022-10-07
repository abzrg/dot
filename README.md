# dot (files)

## some notes

### keyboard repeat rate

```sh
# macos
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
defaults write -g InitialKeyRepeat -int 13
```

### update locate database

```sh
# macos
sudo /usr/libexec/locate.updatedb
```
