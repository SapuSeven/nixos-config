{...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.paul = {
    isNormalUser = true;
    description = "Paul";
    initialHashedPassword = "***REMOVED***";
    extraGroups = ["networkmanager" "wheel"];
  };

  users.mutableUsers = false;
}
