# Dotfiles

## Update all MacOS software

```sh
softwareupdate --install --all
```

## Keyboard repeat rate

```sh
# macos
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
defaults write -g InitialKeyRepeat -int 13
```

## Update locate database

```sh
# macos
sudo /usr/libexec/locate.updatedb
# if you've insatlled coreutils then you have to use the macos utilities
PATH=/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin  sudo /usr/libexec/locate.updatedb
```
finally to use locate you should use the macos version of locate, located in `/usr/bin/locate`

## Disable font smoothing (make alacritty less bold)

Run the following

```sh
defaults -currentHost write -g AppleFontSmoothing -int 0
```

and then restart the machine.


## Android file transfer

```sh
brew install whoozle-android-file-transfer
# privacy > allow
```

## Conflict between moreutils and parallel

```sh
# src: https://superuser.com/a/1537888

brew unlink parallel
brew install moreutils
brew unlink moreutils
brew install parallel
brew link --overwrite moreutils
brew unlink parallel
brew link --overwrite parallel
```
