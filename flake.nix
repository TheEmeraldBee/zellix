{
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.zl = pkgs.writeTextFile {
          name = "zl";
          executable = true;
          destination = "/bin/zl";
          text =
            builtins.readFile ./run.nu;
        };
      }
    );
}
