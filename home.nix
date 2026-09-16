{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.mango.hmModules.mango
  ];

  wayland.windowManager.mango = {
    enable = true;
    settings = {
      animations = 1;
      bordercolor = "0x595959aa";
      border_radius = 6;
      focused_opacity = 1.0;

      bind = [
        "SUPER,r,reload_config"
        "SUPER,space,spawn,fuzzel"
        "SUPER,Return,spawn,foot"
      ];
    };
  };

  home.stateVersion = "24.05"; # match your nixos-version, don't bump blindly
}
