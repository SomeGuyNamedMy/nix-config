{ pkgs, config, lib, ... }:

{
    boot.loader = {
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot/efi";
        };
        grub = {
            efiSupport = true;
            device = "nodev";
        };
    };
    boot.plymouth.enable = true;
}
