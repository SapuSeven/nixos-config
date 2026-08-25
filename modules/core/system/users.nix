{
  config,
  host,
  ...
}: let
  usersecret = "users-${host.user}";
in {
  age.secrets.${usersecret}.file = ../../../secrets/${usersecret}.age;

  users.users.${host.user} = {
    uid = 1000;
    isNormalUser = true;
    description = host.user;
    hashedPasswordFile = config.age.secrets.${usersecret}.path;
    extraGroups = ["networkmanager" "wheel" "dialout"];
  };

  users.mutableUsers = false;
}
