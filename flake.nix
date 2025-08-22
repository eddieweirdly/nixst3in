{
 description = "My First Flake!";

 inputs = {
   nixpkgs.url = "nixpkgs/nixos-unstable";
   home-manager.url = "github:nix-community/home-manager/master";
   home-manager.inputs.nixpkgs.follows = "nixpkgs";
   nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
 };

 outputs = { self, nixpkgs, home-manager, nixpkgs-xr, ...}:
   let
     lib = nixpkgs.lib;
     system = "x86_64-linux";
     pkgs = nixpkgs.legacyPackages.${system};

   in {
   nixosConfigurations = {
     NixSt3in = lib.nixosSystem {
       inherit system;
       modules = [ ./configuration.nix ]; 
        nixpkgs.overlays = [ 
           nixpkgs-xr.overlays.default ];
     };

   };

   homeConfigurations = {
     drfrankenstein = home-manager.lib.homeManagerConfiguration {
       inherit pkgs;
       modules = [./home.nix ];

     };

   }; 
     
 };

}
