{ lib, pkgs, ... }:

{
  systemd.user.services = {
    cliphist = {
      Install.WantedBy = [ "graphical-session.target" ];
      Unit = {
        Description = "Clipboard history";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getExe pkgs.cliphist} store";
        Restart = "always";
      };
    };

    wl-clip-persist = {
      Install.WantedBy = [ "graphical-session.target" ];
      Unit = {
        Description = "Persistent clipboard";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${lib.getExe pkgs.wl-clip-persist} --clipboard both";
        Restart = "always";
      };
    };
  };
}