{ configHM, inputs, lib, pkgs, ... }: let
  user = configHM.modules.users;
  wallpapers = {
    Win = "/home/${user.userName}/Pictures/Win11-light.jpg";
    HyprChan = "/home/${user.userName}/Pictures/HyprChan.png";
    HM-gruv = "/home/${user.userName}/Pictures/HM-gruv.jpg";
    HM-oxocarbon = "/home/${user.userName}/Pictures/HM-oxocarbon.jpg";
  };
in{
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpapers.Win}
    preload = ${wallpapers.HyprChan}
    preload = ${wallpapers.HM-gruv}
    preload = ${wallpapers.HM-oxocarbon}

    wallpaper =, ${wallpapers.HM-gruv}
  '';

  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprland wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${lib.getExe inputs.hyprpaper.packages.${pkgs.system}.default}";
      Restart = "on-failure";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
