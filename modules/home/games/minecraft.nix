{pkgs, host, ...}: let
  jdk = pkgs.openjdk17;
  dataDir = if host == "desktop"
        then "/run/media/paul/Thicc/Games/Minecraft/MultiMC"
        else "/home/paul/Files/Games/Minecraft";
in {
  home = {
    packages = with pkgs; [
      prismlauncher
    ];

    persistence."/nix/persist/home/paul" = {
      directories = [
        ".local/share/PrismLauncher/assets"
        ".local/share/PrismLauncher/icons"
        ".local/share/PrismLauncher/libraries"
        ".local/share/PrismLauncher/meta"
        ".local/share/PrismLauncher/mods"
      ];
      files = [
        ".local/share/PrismLauncher/accounts.json"
      ];
    };

    file.".local/share/PrismLauncher/prismlauncher.cfg".text = ''
      [General]
      ConfigVersion=1.2
      Language=en_US
      UseSystemLocale=true
      LastHostname=nixos

      ; Theme and layout
      ApplicationTheme=system
      BackgroundCat=kitteh
      IconTheme=pe_colored
      ToolbarsLocked=false
      MenuBarInsteadOfToolBar=false

      ; Memory
      MinMemAlloc=512
      MaxMemAlloc=6142

      ; Paths
      JavaPath=${jdk}/bin/java
      InstanceDir=${dataDir}/instances
      CentralModsDir=mods
      IconsDir=icons
      DownloadsDir=/home/paul/Downloads
      DownloadsDirWatchRecursive=false

      ; Console
      ConsoleFont=JetBrains Mono
      ConsoleFontSize=11
      ConsoleMaxLines=100000
      ConsoleOverflowStop=true
      ShowConsole=false
      ShowConsoleOnError=true

      ; Launcher
      AutoCloseConsole=false
      CloseAfterLaunch=false
      LaunchMaximized=false
      QuitAfterGameStop=false
      RecordGameTime=true
      ShowGameTime=true
      ShowGameTimeWithoutDays=false
      ShowGlobalGameTime=true

      ; Network
      ProxyAddr=127.0.0.1
      ProxyPass=
      ProxyPort=8080
      ProxyType=None
      ProxyUser=

      ; Misc

      CustomGLFWPath=
      CustomOpenALPath=
      UseNativeGLFW=false
      UseNativeOpenAL=false
      WrapperCommand=

      JProfilerPath=
      JVisualVMPath=
      JsonEditor=
      JvmArgs=
      OnlineFixes=false

      EnableFeralGamemode=false
      EnableMangoHud=false
      FlameKeyOverride=
      MSAClientIDOverride=
      PreLaunchCommand=
      PostExitCommand=
      UserAgentOverride=

      PermGen=128
      NumberOfConcurrentDownloads=6
      NumberOfConcurrentTasks=10

      MCEditPath=
      ModrinthToken=
      PastebinCustomAPIBase=
      PastebinType=3

      IgnoreJavaCompatibility=false
      IgnoreJavaWizard=false
      InstSortMode=Name
      MetaURLOverride=
      MinecraftWinHeight=480
      MinecraftWinWidth=854
      ModDependenciesDisabled=false
      ModMetadataDisabled=false
      UseDiscreteGpu=false
      UseSystemLocale=true
    '';
  };
}
