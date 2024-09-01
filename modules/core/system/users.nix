{config, ...}: {
  age.secrets.users-paul.file = ../../../secrets/users-paul.age;

  users.users.paul = {
    isNormalUser = true;
    description = "Paul";
    hashedPasswordFile = config.age.secrets.users-paul.path;
    extraGroups = ["networkmanager" "wheel"];
  };

  users.mutableUsers = false;
}
