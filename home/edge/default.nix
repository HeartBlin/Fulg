{ pkgs, ... }:

{
  # It's actually MS-Edge lmao
  programs.chromium = {
    enable = true;
    package = pkgs.microsoft-edge-dev;

    extensions = [
      { id = "faeadnfmdfamenfhaipofoffijhlnkif"; } # AMOLED Theme

      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # DarkReader
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock
      { id = "hjdoplcnndgiblooccencgcggcoihigg"; } # ToS;Dr
    ];
  };
}