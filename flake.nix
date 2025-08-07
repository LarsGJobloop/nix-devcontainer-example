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
            # Infrastructure tools
            terraform # Commonly used
            opentofu # Open source alternative to terraform

            # Development Tools
            openssh # SSH client
            sops # Secrets management
            age # Encryption tool
          ];
        };
      });
    };
}
