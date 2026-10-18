{
  stdenv,
  aeroshell-kwin-repo,
  kdePackages,
  wayland-protocols,
  pkg-config,
  cmake,
  ninja,
  lib,
}:
stdenv.mkDerivation {
  pname = "aeroshell-aeroglassblur";
  version = "2026-08-08";
  src = aeroshell-kwin-repo;

  buildInputs = [ kdePackages.qttools wayland-protocols kdePackages.kwin ];
  nativeBuildInputs = [ cmake pkg-config ninja kdePackages.wrapQtAppsHook ];
  ninjaFlags = [ "aeroglassblur" ];
  installTargets = "effects_cpp/kde-effects-aeroglassblur/install";
}
