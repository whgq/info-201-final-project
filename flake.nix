{
  description = "INFO 201 final project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        deps = with pkgs;
          with rPackages; [
            R
            dplyr
            ggplot2
            readxl
            readr
            stringr
            purrr
            tidyr
            ggmap
            fuzzyjoin
            maps
            mapproj
            scales
            FNN
            pracma
            numDeriv
            R
            rmarkdown
            dplyr
            ggplot2
            readr
            stringr
            purrr
            tidyr
          ];
        knit = path:
          pkgs.stdenv.mkDerivation {
            name = "knit";
            src = ./.;
            buildInputs = deps ++ (with pkgs; [ pandoc ]);
            # This produces ${name}.html
            buildPhase = ''
              ${pkgs.R}/bin/R -e "rmarkdown::render('./src/heat_maps/${path}.Rmd', output_format = 'html_document')"
            '';
            installPhase = ''
              mkdir $out
              mv ./src/heat_maps/${path}.html $out/
            '';
          };
        serve = path:
          pkgs.writeShellScriptBin "serve" ''
            ${pkgs.http-server}/bin/http-server ${knit path}/
          '';
        serve-live = pkgs.writeShellScriptBin "serve-live" ''
            fname=$(basename "$1")
            ${pkgs.watchexec}/bin/watchexec -w "$1" --restart -- nix run .#''${fname%.*}
          '';
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = deps ++ [ pkgs.rPackages.languageserver ];
        };
        apps = (with builtins;
          let
            rmds = (filter (fname: match ".*\\.Rmd$" fname != null)
              ((map (fname: "./src/heat_maps/${fname}")
                (attrNames (readDir ./src/heat_maps)))
                ++ (map (fname: "./src/data_exploration/${fname}")
                  (attrNames (readDir ./src/data_exploration)))));
          in listToAttrs (map (fname: let ftrunk = builtins.replaceStrings [".Rmd"] [""] (baseNameOf fname); in {
            name = ftrunk;
            value = {
              type = "app";
              program = "${serve ftrunk}/bin/serve";
            };
          }) rmds)) // {
            serve-live = {
              type = "app";
              program = "${serve-live}/bin/serve-live";
            };
          };
      });
}
