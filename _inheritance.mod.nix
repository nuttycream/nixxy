{
  merge,
  configs,
  ...
}: {
  desky = merge configs.universal configs.personal;
  lappy = merge configs.universal configs.personal;
}
