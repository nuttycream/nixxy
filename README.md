# nixxy

my attempt at a declarative and functional system config

<p align="center">
    <img src="https://i.imgur.com/5fsP1y0.jpeg" width=50%>
    <img src="https://i.imgur.com/skKOGsO.png" width=50%>
</p>

### configs

The basis/foundation was ripped straight from
[sodiboo/system](https://github.com/sodiboo/system) so special thanks to them.
Sodiboo's setup termed his machines as elements which is pretty cool imo, but I
went with something simpler.

There are two main setups that I run everyday desky, and lappy. I also plan to
also add a nix-darwin config for my mac mini - macky, later on. The idea is to
have all module in root, I want to avoid nesting as much as possible, not only
to reduce the amount of default.nix files I would need but also to reduce the
amount of directories I have to navigate through in oil.nvim.

### addtl stuff

g80sd 4k @ 240hz needs additional setup\
something about edid and displayid being blocked, idrk\
here's some details:\
[reddit](https://www.reddit.com/r/linux_gaming/comments/1gj5cdw/samsung_odyssey_g8_monitor_not_giving_240hz/)\
[arch forums](https://bbs.archlinux.org/viewtopic.php?id=297515)\
[relevant issue](https://gitlab.freedesktop.org/drm/amd/-/issues/3718)\
[arch wiki for edid](https://wiki.archlinux.org/title/Kernel_mode_setting#Forcing_modes_and_EDID)\
[nixos issue](https://discourse.nixos.org/t/copying-custom-edid/31593)\
[drm kernel commit](https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e79ce1639a865d93fa8c27b515e8165c60131c9b)

### helpful stuff

[sodiboo's setup](https://github.com/sodiboo/system)\
[nix builtins](https://nix.dev/manual/nix/2.24/language/builtins.html)\
[debug nix expressions](https://nixos-and-flakes.thiscute.world/best-practices/debugging)\
[eww config](https://elkowar.github.io/eww/configuration.html)\
[nix.dev](https://nix.dev/tutorials/nixos/)\
[greetd/tuigreet](https://ryjelsum.me/homelab/greetd-session-choose/)\
[uwu ascii](https://emojicombos.com/uwu-ascii-art)
