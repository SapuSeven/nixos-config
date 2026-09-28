{...}: {
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "thunar.desktop";

        "text/plain" = "org.gnome.TextEditor.desktop";
        "text/markdown" = "org.gnome.TextEditor.desktop";
        "text/html" = "zen.desktop";
        "application/xml" = "org.gnome.TextEditor.desktop";
        "application/xhtml+xml" = "zen.desktop";
        "application/pdf" = "zen.desktop";

        "application/msword" = "libreoffice-writer.desktop";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "libreoffice-writer.desktop";
        "application/vnd.ms-excel" = "libreoffice-calc.desktop";
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "libreoffice-calc.desktop";
        "application/vnd.ms-powerpoint" = "libreoffice-impress.desktop";
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "libreoffice-impress.desktop";
        "application/zip" = "xarchiver.desktop";
        "application/x-tar" = "xarchiver.desktop";
        "application/x-7z-compressed" = "xarchiver.desktop";
      };
    };
  };
}
