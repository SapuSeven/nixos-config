let
  alina = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBjiY9ovrBpTulp+ChjrJXiNgPyU2of6sIICAj6xyfbG";
  users = [alina];
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINiJRQ+BvWXHmZKSorfy37hWo1UF8JPnKgZ9tXc567B1";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGaCfMS3v7tDxKg11ZRZHhxh5sujnUtleeuPJH1F+PpL";
  systems = [desktop laptop];
in {
  # Services
  "samba.age".publicKeys = users ++ systems;
  "restic-persist.age".publicKeys = users ++ systems;
  "nixbuild.age".publicKeys = users ++ systems;
  "keepass-default.age".publicKeys = users ++ systems;

  # Users
  "users-alina.age".publicKeys = [alina] ++ systems; # Login Password
}
