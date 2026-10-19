{
  stdenv,
  aerothemeplasma-repo,
  kdePackages,
  pkg-config,
  cmake,
  ninja
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-notifications";
  version = "2026-03-02";
  src = aerothemeplasma-repo;

  buildInputs = with kdePackages; [
    plasma-workspace
    knotifyconfig
    plasma5support
  ];
  nativeBuildInputs = [ cmake pkg-config ninja kdePackages.wrapQtAppsHook ];
  ninjaFlags = [ "io.gitgud.wackyideas.notifications" ];
  installTargets = "plasma/plasmoids/src/notifications_src/install";
}
