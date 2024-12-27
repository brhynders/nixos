{
  description = "NixOS Configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05"; 

  outputs = { self, nixpkgs }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix # Reference your configuration.nix
      ];
    };
  };
}