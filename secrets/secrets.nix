let
  paul = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBjiY9ovrBpTulp+ChjrJXiNgPyU2of6sIICAj6xyfbG";
  users = [paul];
  #desktop = "ssh-ed25519 ";
  #laptop = "ssh-ed25519 ";
  #systems = [ desktop laptop ];
in {
  "samba.age".publicKeys = users; #++ systems;
  "restic-persist.age".publicKeys = users;
}
