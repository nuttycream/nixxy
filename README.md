# nixxy

my attempt at a declarative and functional system config

<p align="center">
    <img src="https://i.imgur.com/5fsP1y0.jpeg" width=75%>
    <img src="https://i.imgur.com/skKOGsO.png" width=75%>
</p>

### overview

> [!NOTE]
> im still a noob with nix, so pardon my shitty code and explanations

The basis for flake.nix was straight up ripped from
[sodiboo/system](https://github.com/sodiboo/system) nix config so special thanks
to them. Sodiboo's setup named his machines as elements which is pretty cool
imo, but I went with something simpler. You should also visit their repo for a
better grasp of how this setup works.

From my understanding, the flake scans for `.mod.nix` files and loads them
through the `mapAttrsToList()` function where each module is loaded through
`import("${mod_file}")`, and saves me the trouble of explicitly specifying the
module. Each `.mod.nix` file can also define configs for different systems or
inherit different _layers_.

The key thing I definitely wanted is how inheritance is handled. Specifically
configurations found in `_inheritance.mod.nix` and what it exactly it is used
for. That's all handled by Sodiboo's merge function:

```nix
merge = prev: this: {
    modules = prev.modules or [] ++ this.modules or [];
    home_modules = prev.home_modules or [] ++ this.home_modules or [];
} // (optionalAttrs (prev ? system || this ? system) {
    system = prev.system or this.system;
});
```

Which then lets me use as a sort of 'layered' config setup where machines can
inherit the configs they would need, I can also specify a config on a per
machine level.\
Example:

```nix
desky = merge configs.universal configs.personal
lappy = merge configs.universal configs.personal
```

And declaring a new module is as simple as:

```nix
# some.mod.nix

{...} : {
    universal.modules = [
        ({pkgs, lib, ...} : {
            ...
        })
    ];
    
    # and/or
    personal.modules = [{
        ...
    }];
    
    # for specific hosts
    lappy.modules = [];
    desky.modules = [];
    
    # same goes for home_modules
    universal.home_modules = [];
    personal.home_modules = [];
    lappy.home_modules = [];
    ...
}
```

### configs

There are two main setups that I run everyday desky, and lappy - which is just
desktop and laptop respectively. I also plan to also add a nix-darwin config for
my mac mini - macky, later on. They both currently inherit personal, and
universal, ideally when I setup more machines, like macky for instance, it
wouldn't need.

All modules are in root, I want to avoid nesting as much as possible, to reduce
both the amount of default.nix files I would need but also the amount of
directories I have to navigate through. Aside from hardware there is very little
difference between them.

They both share:

- [niri](https://github.com/YaLTeR/niri)
  [niri-flake](https://github.com/sodiboo/niri-flake) - my window manager, lappy
  and desky needs specific config for their monitors.
- [greetd](https://git.sr.ht/~kennylevinsen/greetd) - my login manager,
  previously I used ly but I got skill-issued so hard and gave up.
- [foot](https://codeberg.org/dnkl/foot) - my terminal emulator, it's
  responsive, and is relatively lightweight. I don't need no gpu acceleration
  and fancy shader support!
- [nushell](https://github.com/nushell/nushell) - my shell, it gives me good
  looking output, that's all.
- [nvf](https://github.com/NotAShelf/nvf) - neovim flake that abstracts a lot of
  the setup out, it keeps my entire config in nix.
- [eww](https://github.com/elkowar/eww) - widgets, the system information panel
  that sits as a overlay on the center of the screen. This replaces waybar for
  me and it will also soon replace dunst as my notification daemon.
- [dunst](https://github.com/dunst-project/dunst) - my notification daemon, its
  lightweight and pretty easy to config.
- [tofi](https://github.com/philj56/tofi) - my app launcher, apparently it's
  wicked fast, and yes i can attest to it, even with my minimal optimizations
  (no direct path to font) it still launches super quick.

In terms of hardware:

| component | lappy     | desky   |
| --------- | --------- | ------- |
| CPU       | 7640U     | 9700X   |
| GPU       | 700M      | 7900XTX |
| RAM       | 32GB      | 32GB    |
| DISPLAY   | 13' 1080p | 32' 4K  |

desky currently has a dual boot setup with shitdows on two separate nvme drives,
and it's why I need `grub` instead of `systemd` - makes it easier to setup a
dual boot system using `os-prober` without having to manually specify disks.

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
