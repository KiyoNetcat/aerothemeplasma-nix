{
  stdenv,
  aerothemeplasma-repo,
  kdePackages,
  pkg-config,
  cmake,
  ninja
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-desktopcontainment";
  version = "2026-06-27";
  src = aerothemeplasma-repo;

  buildInputs = with kdePackages; [
    plasma-workspace
    knotifyconfig
    plasma5support
  ];
  nativeBuildInputs = [ cmake pkg-config ninja kdePackages.wrapQtAppsHook ];
  ninjaFlags = [ "folderplugin" ];
  installTargets = "plasma/plasmoids/src/desktopcontainment/install";
  postInstall = ''
    mkdir -p $out/share/plasma/plasmoids
    cp -r $src/plasma/plasmoids/io.gitgud.wackyideas.desktopcontainment $out/share/plasma/plasmoids
  '';
}
