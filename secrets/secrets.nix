let
  paul = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBjiY9ovrBpTulp+ChjrJXiNgPyU2of6sIICAj6xyfbG";
  users = [paul];
  #desktop = "ssh-ed25519 ";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGaCfMS3v7tDxKg11ZRZHhxh5sujnUtleeuPJH1F+PpL";
  systems = [ laptop ];
in {
  "samba.age".publicKeys = users ++ systems;
  "restic-persist.age".publicKeys = users ++ systems;
  "users-paul.age".publicKeys = users ++ systems;
}
