{ config, inputs, lib, ... }: let
  cfg = config.modules.impermanence;
  user = config.modules.users.userName;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  config = lib.mkIf cfg.enable {
    # Just in case, allow to mount btrfs
    # volumes in initrd
    boot.supportedFilesystems = [ "btrfs" ];

    # Do not allow mutable users
    users = {
      mutableUsers = false;
      users = {
        root.hashedPasswordFile = "/persist/passwords/root";
        ${user}.hashedPasswordFile = "/persist/passwords/${user}";
      };
    };

    # Persist critical files & folders
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        # Needed
        "/etc/nixos"
        "/etc/nix/"
        "/etc/NetworkManager/system-connections"
        "/etc/secureboot"
        "/var/db/sudo"
        "/var/lib/libvirt"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/pipewire"
        "/var/lib/systemd/coredump"
        "/var/lib/waydroid"
      ];

      files = [
        "/etc/machine-id"
      ];

      users.${user} = {
        directories = [
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Videos"
        ];
      };
    };

    # Fix NetworkManager
    systemd.tmpfiles.rules = [
      "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
      "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
      "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
    ];

    # Script that rollsback to a empty root
    boot.initrd.systemd.enable = lib.mkForce true; # Just in case
    boot.initrd.systemd.services.rollback = {
      description = "Rollback BTRFS root subvolume to a pristine state";
      wantedBy = [ "initrd.target" ];
      after = [ "systemd-cryptsetup@enc.service" ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /mnt
    
        mount -o subvol=/ /dev/mapper/enc /mnt
    
        btrfs subvolume list -o /mnt/root |
        cut -f9 -d' ' |
        while read subvolume; do
          echo "[!] Deleting /$subvolume subvolume..."
          btrfs subvolume delete "/mnt/$subvolume"
        done &&
      
        echo "[!] Deleting /root subvolume..." &&
        btrfs subvolume delete /mnt/root
    
        echo "[!] Restoring blank /root subvolume..."
        btrfs subvolume snapshot /mnt/root-blank /mnt/root
    
        umount /mnt
      '';
    };
  };
}