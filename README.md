# nixxy

my attempt at a declarative and functional system config

### hardware

| component | lappy     | desky   |
| --------- | --------- | ------- |
| CPU       | 7640U     | 9700X   |
| GPU       | 700M      | 7900XTX |
| RAM       | 32GB      | 32GB    |
| DISPLAY   | 13' 1080p | 32' 4K  |

### addtl config

g80sd 4k @ 240hz needs additional setup\
something about edid and displayid being blocked, idrk\
here's some details:\
[reddit](https://www.reddit.com/r/linux_gaming/comments/1gj5cdw/samsung_odyssey_g8_monitor_not_giving_240hz/)\
[arch forums](https://bbs.archlinux.org/viewtopic.php?id=297515)\
[relevant issue](https://gitlab.freedesktop.org/drm/amd/-/issues/3718)\
[arch wiki for edid](https://wiki.archlinux.org/title/Kernel_mode_setting#Forcing_modes_and_EDID)\
[nixos issue](https://discourse.nixos.org/t/copying-custom-edid/31593)

## todo

- [ ] [harper-ls](https://writewithharper.com/docs/integrations/neovim)
      integrate harper-ls
- [ ] might revert to simplified lua config for neovim, nvf might be too
      abstracted
- [ ] [stylix](https://github.com/danth/stylix) integration
- [x] get rid of gnome + gdm -> for ly
- [ ] use dynamic mod loading similar to
      [sodiboos setup](https://github.com/sodiboo/system/blob/b63c7b27f49043e8701b3ff5e1441cd27d5a2fff/flake.nix#L92C6-L97C9)

```nix
read_all_modules = flip pipe [
    read_dir_recursively
    (filterAttrs (flip (const (hasSuffix ".mod.nix"))))
    (mapAttrs (const import))
    (mapAttrs (const (flip toFunction params)))
];
```
