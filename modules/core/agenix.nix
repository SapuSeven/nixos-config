{inputs, ...}: {
  # TODO: Don't hard-code system
  environment.systemPackages = [inputs.agenix.packages."x86_64-linux".default];
}
