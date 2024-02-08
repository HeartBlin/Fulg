_: {
  imports = [
    ./encryption.nix
    ./gpg.nix
  ];

  security.sudo.execWheelOnly = true;
}