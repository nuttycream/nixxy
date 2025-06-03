# nixxy

my attempt at a declarative and functional system config

<p align="center">
    <img src="https://i.imgur.com/5fsP1y0.jpeg" width=75%>
    <img src="https://i.imgur.com/skKOGsO.png" width=75%>
</p>

## overview

> [!NOTE]
> im still a noob with nix, so pardon my shitty code

The basis for my flake.nix was straight up ripped from
[sodiboo's](https://github.com/sodiboo/system) config so special thanks to them.
You should also visit their repo for a better grasp of how this setup works.

From my understanding, the flake scans for `.mod.nix` files and loads them
through the `mapAttrsToList()` function where each module is loaded through
`import("${mod_file}")`, and saves me the trouble of explicitly specifying the
module. Each `.mod.nix` file can also define configs for different systems or
inherit different _layers_.

The key thing I definitely wanted is how inheritance is handled. Specifically
configurations found in `_inheritance.mod.nix` and what it exactly its being
used for. That's all handled by Sodiboo's merge function:

```nix
merge = prev: this: {
    modules = prev.modules or [] ++ this.modules or [];
    home_modules = prev.home_modules or [] ++ this.home_modules or [];
} // (optionalAttrs (prev ? system || this ? system) {
    system = prev.system or this.system;
});
```

Too be clear, I'm pretty sure this sort of combines configs rather than create
inheritance. And when they are merged, the `modules` and `home_modules` arrays
are concatted as well as the system specific config, I believe this is what
`optionalAttrs` handles.

The setup also uses `zipAttrsWith` to automatically combine all modules by
machine name. So if multiple .mod.nix files define configs for the same machine
like _desky_, they get automatically combined using the merge function through
folding.

This all sort of lets me use a _layered_ config setup where machines can inherit
the configs they would need, I can also specify a config on a per machine level.

In practice, this is what it would look like:

```nix
desky = merge configs.universal configs.personal
lappy = merge configs.universal configs.personal
```

This automatically creates and combines configs as like so:

- modules -> `universal.modules ++ personal.modules`
- home_modules -> `universal.home_modules ++ personal.home_modules`

To put it all together, declaring a new module is as simple as:

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

## configs

There are two main setups that are configured here: _desky_, and _lappy_ - my
desktop and laptop respectively. I also plan to add a nix-darwin config for my
mac mini - _macky_, later on. They both currently inherit personal, and
universal, ideally when I setup more machines, like macky for instance, it
wouldn't need to inherit both.

All modules are in root, I want to avoid nesting as much as possible, to reduce
both the amount of default.nix files I would need but also the amount of
directories I have to navigate through. Aside from hardware there is very little
difference between them.

They both share:

- [niri](https://github.com/YaLTeR/niri)
  [niri-flake](https://github.com/sodiboo/niri-flake) - scrolling window
  manager.
- [greetd](https://git.sr.ht/~kennylevinsen/greetd) - login manager, previously
  I used ly but I got skill-issued so hard and gave that up.
- [foot](https://codeberg.org/dnkl/foot) - my terminal emulator, it's
  responsive, and is relatively lightweight. I don't need gpu acceleration and
  fancy shader support!
- [nushell](https://github.com/nushell/nushell) - current shell, it gives me
  good looking output, that's all.
- [nvf](https://github.com/NotAShelf/nvf) - neovim flake that abstracts a lot of
  neovim setup and lua out, it keeps my entire config in nix.
- [eww](https://github.com/elkowar/eww) - widgets, the system information panel
  that sits as a overlay on the center of the screen. This replaces waybar for
  me and it will also soon replace dunst as my notification daemon.
- [dunst](https://github.com/dunst-project/dunst) - notification daemon, its
  lightweight and pretty easy to config.
- [tofi](https://github.com/philj56/tofi) - app launcher, it's wicked fast, even
  with my minimal optimizations (no direct path to fonts) it still launches
  super quick.

Aesthetically I wanted to keep them relatively _simple_, _functional_ and _high
contrast_. Not only to compliment my OLED monitor but also because it helps me
concentrate without overly annoying colors or any other on-screen distractions.
For this I went with very tiny gaps (0 vertical gaps), a tiny focus-ring, and no
bar - system info like volume, brightness, etc are all handled on the sys_info
panel that I can toggle on/off.

In terms of hardware:

| component | lappy     | desky   |
| --------- | --------- | ------- |
| CPU       | 7640U     | 9700X   |
| GPU       | 700M      | 7900XTX |
| RAM       | 32GB      | 32GB    |
| DISPLAY   | 13' 1080p | 32' 4K  |

_desky_ currently has a dual boot setup with shitdows on two separate nvme
drives, and it's why I need `grub` instead of `systemd` - makes it easier to
setup a dual boot system using `os-prober` without having to manually specify
disks.

## addtl stuff

g80sd 4k @ 240hz needs additional setup\
something about edid and displayid being blocked, idrk\
here's some details:\
[reddit](https://www.reddit.com/r/linux_gaming/comments/1gj5cdw/samsung_odyssey_g8_monitor_not_giving_240hz/)\
[arch forums](https://bbs.archlinux.org/viewtopic.php?id=297515)\
[relevant issue](https://gitlab.freedesktop.org/drm/amd/-/issues/3718)\
[arch wiki for edid](https://wiki.archlinux.org/title/Kernel_mode_setting#Forcing_modes_and_EDID)\
[nixos issue](https://discourse.nixos.org/t/copying-custom-edid/31593)\
[drm kernel commit](https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e79ce1639a865d93fa8c27b515e8165c60131c9b)

## helpful stuff

[sodiboo's setup](https://github.com/sodiboo/system)\
[nix builtins](https://nix.dev/manual/nix/2.24/language/builtins.html)\
[debug nix expressions](https://nixos-and-flakes.thiscute.world/best-practices/debugging)\
[eww config](https://elkowar.github.io/eww/configuration.html)\
[nix.dev](https://nix.dev/tutorials/nixos/)\
[greetd/tuigreet](https://ryjelsum.me/homelab/greetd-session-choose/)\
[uwu ascii](https://emojicombos.com/uwu-ascii-art)
