{
  stdenv,
  aeroshell-smod-repo,
  kdePackages,
  pkg-config,
  smod,
  cmake,
  lib,
}:
stdenv.mkDerivation {
  pname = "aeroshell-smodglow";
  version = "2026-08-22";
  src = aeroshell-smod-repo;

  buildInputs = [ smod kdePackages.kwin ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
  cmakeFlags = [ (lib.cmakeBool "BUILD_EFFECT" true) ];
}
