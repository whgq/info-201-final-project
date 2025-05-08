{
  description = "INFO 201 final project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system}; in
    {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; with rPackages; [ R dplyr ggplot2 readxl stringr pandoc firefox languageserver purrr ];
        shellHook = ''
          function knit() {
            ${pkgs.R}/bin/R -e "rmarkdown::render('$1')"
            in_path=''${1}
            html_path="''${in_path%.*}.html"
            full_path="$(pwd)/$html_path"
            ${pkgs.firefox}/bin/firefox "file://$full_path"
          }
        '';
      };
    }
  );
}
