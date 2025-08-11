{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs =
    { self, nixpkgs }:
    let
      # Supported systems
      systems = [
        "x86_64-linux" # Verified
        "aarch64-linux" # !TODO: Verify
        "x86_64-darwin" # !TODO: Verify
        "aarch64-darwin" # Verified
      ];

      # Helper functions
      withSystem = nixpkgs.lib.genAttrs systems;
      withPkgs =
        callback:
        withSystem (
          system:
          callback (
            import nixpkgs {
              config.allowUnfree = true; # Terraform is licensed bsl11
              inherit system;
            }
          )
        );
    in
    {
      # Development environments
      devShells = withPkgs (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # The tools available in this project
            # See the Nix package registry for what's available
            # https://search.nixos.org/packages

            # Application toolchain
            dotnetCorePackages.sdk_9_0 # .NET 9.0 SDK

            # Infrastructure tools
            # !TODO: Figure out if initial setup time can be reduced, and that the devcontainer caches these across projects
            # Currently both IaC takes minutes to compile on clean setups
            # It should be a one time cost across the machine's lifetime
            terraform # Commonly used
            opentofu # Open source alternative to terraform

            # Development Tools
            openssh # SSH client
            sops # Secrets management
            age # Encryption tool
          ];

          env = {
            # The C# extension for VSCode requires this to be set to find the binaries
            DOTNET_ROOT = builtins.toString pkgs.dotnetCorePackages.sdk_9_0;
          };
        };
      });
    };
}
