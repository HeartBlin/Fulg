{ pkgs, ... }:

{
  home.packages = [
    pkgs.vesktop
  ];

  home.file.".local/share/applications/VeskTop-Fixed.desktop".text = ''
    [Desktop Entry]
    Categories=Network;InstantMessaging;Chat
    Exec=vesktop --disable-gpu %U
    GenericName=Internet Messenger
    Icon=vesktop
    Keywords=discord;vencord;electron;chat
    Name=DS
    StartupWMClass=Vesktop
    Type=Application
    Version=1.4
  '';


}