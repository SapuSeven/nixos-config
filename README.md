Great template for splitting up the config:
https://github.com/Frost-Phoenix/nixos-config

More inspiration:
https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles
-> cool volume change popup

# Installation

On a new machine, boot into the NixOS installer and fetch the repository:
```shell
git clone git@github.com:SapuSeven/nixos-config.git
cd nixos-config
```

To make sure enough space is available for the installation, set up a swap partition and increase the store size:
```shell
sudo swapon /dev/nvme0n1p2 # replace with swap partition
sudo mount -o remount,size=10G,noatime /nix/.rw-store
```

If the configuration contains disk definitions using disko, run the following command to set up and install (will remove all data from the target disk!):
```shell
sudo nix --extra-experimental-features "nix-command flakes" \
  run 'github:nix-community/disko/latest#disko-install' -- \
  --flake .#[host] # replace with host configuration name
  --disk main /dev/nvme0n1 # replace with main disk and/or supply more disks if configured
```

Afterward, copy the nixos configuration to the persistent location on the newly formatted disk:
```shell
sudo mount -o subvol=persistent /dev/nvme0n1p4 /mnt
sudo cp -r ./** /mnt/etc/nixos
```

# Maintenance

## Managing Secrets
Secrets are defined as encrypted files in `./secrets`.
Every secret has one or more public keys added to it in the configuration file.
To decrypt the secret, one of the corresponding private keys must be used.

The key pairs are split into two groups: user keys and system keys.
- The user key is mainly used for managing secrets when writing the configuration.
  A user is associated with a single person and can be shared across multiple systems.
  Every instance of the same user should also have the same keypair.
- System keys are unique per system and are used to decrypt secrets for the running system.

### Adding a new secret
Configure the allowed public keys for the new secret in `secrets/secrets.nix`:
```
"mysecret.age".publicKeys = users ++ systems;
```

Then edit the secret using the following command:
```sh
cd secrets
agenix -e mysecret.age
```

### Using secrets in .nix config
````nix
{
  age.secrets.mysecret.file = ../../secrets/mysecret.age;

  # Use .path to access the secret as a file
  secretfile = config.age.secrets.mysecret.path;
}
```

### Rekeying secrets
If any of the public keys change, you need to rekey the secrets:
```sh
cd secrets
agenix -r
```

## TODO - Most important
- Modularize main config
- Display dim and timeout (extra short when locked) including idle inhibitor
- Brightness control waybar
