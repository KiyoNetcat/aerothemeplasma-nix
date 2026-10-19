{
  stdenv,
  lib,
  aerothemeplasma-repo,
  xdg,
  qt6,
  kdePackages,
  cmake,
  nyakisato
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-login-session";
  version = "2026-03-14";
  src = aerothemeplasma-repo;

  preConfigure = ''
    head -n 16 CMakeLists.txt | cat - plasma/sddm/login-sessions/CMakeLists.txt > temp
    mv temp plasma/sddm/login-sessions/CMakeLists.txt
    cd plasma/sddm/login-sessions
  '';
  nativeBuildInputs = [ cmake ];
  buildInputs = [ kdePackages.extra-cmake-modules qt6.qtbase ];
  # ECM throws an error about not finding QT,
  # but we don't actually need it for this package
  dontWrapQtApps = true;

  postFixup = ''
    substituteInPlace $out/bin/startatp-wayland \
      --replace-fail "$out/libexec/plasma-dbus-run-session-if-needed" "${kdePackages.plasma-workspace}/libexec/plasma-dbus-run-session-if-needed" \
      --replace-fail "$out/bin/startplasma-wayland" "${kdePackages.plasma-workspace}/bin/startplasma-wayland" \
      --replace-fail "/etc/xdg/aerothemeplasma:/etc/xdg:" "${xdg}/etc/xdg:"
  '';

  passthru = {
    providedSessions = [ "aerothemeplasma" ];
    updateScript = nyakisato {
      subpaths = [ "plasma/sddm/login-sessions" ];
    };
  };
}
