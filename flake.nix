{
  description = "Nix flake for the Tsjirp website using Jekyll";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    devshell = {
      url = "github:numtide/devshell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    devshell,
  }: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ] (system:
        function (import nixpkgs {
          inherit system;
          overlays = [
            devshell.overlays.default
          ];
        }));
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    devShells = forAllSystems (pkgs: {
      default = pkgs.devshell.mkShell {
        name = "tsjirp-website";
        packages = let
          gems = pkgs.bundlerEnv rec {
            name = "tsjirp-website-gems";
            ruby = pkgs.ruby_3_3;
            gemdir = ./.;
          };
        in [
          gems
          (pkgs.lowPrio gems.wrappedRuby)
          pkgs.rsync
        ];

        env = [
          {
            name = "BUNDLE_FORCE_RUBY_PLATFORM";
            eval = "1";
          }
        ];
        commands = [
          {
            name = "update:gems";
            category = "Dependencies";
            help = "Update `Gemfile.lock` and `gemset.nix`";
            command = ''
              ${pkgs.ruby_3_3}/bin/bundle lock
              ${pkgs.bundix}/bin/bundix
            '';
          }
          {
            name = "upgrade:gems";
            category = "Dependencies";
            help = "Update `Gemfile.lock` and `gemset.nix`";
            command = ''
              ${pkgs.ruby_3_3}/bin/bundle lock --update
              ${pkgs.bundix}/bin/bundix
            '';
          }
          {
            name = "serve";
            help = "Run a server hosting the website locally";
            command = ''
              jekyll server --livereload
            '';
          }
        ];
      };
    });
  };
}
