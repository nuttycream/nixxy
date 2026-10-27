{
  merge,
  configs,
  ...
}: let
  base = merge configs.universal configs.cli;
  metal = merge base configs.metal;
in {
  desky = merge metal configs.personal;
  lappy = merge metal configs.personal;
  wissy =  base;
}
