{
  description = "This is a nix with flakes package";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    podman-rootless.url = "github:ES-Nix/podman-rootless/from-nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, podman-rootless }:
    flake-utils.lib.eachDefaultSystem (system:
      let

        pkgsAllowUnfree = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };
      in
      {

        devShell = pkgsAllowUnfree.mkShell {
          buildInputs = with pkgsAllowUnfree; [
            bashInteractive
            gnumake
            podman-rootless.packages.${system}.podman
          ];

          shellHook = ''
            export TMPDIR=/tmp

            echo "Entering the nix devShell"
          '';
        };
      });
}
