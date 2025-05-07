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
        nativeBuildInputs = with pkgs; [ R rPackages.dplyr rPackages.ggplot2 rPackages.readxl rPackages.stringr ];
      };
    }
  );
}
