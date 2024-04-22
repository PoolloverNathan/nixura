{
  name ? "merged",
  dirs ? [],
  args ? {},
  pkgs ? import <nixpkgs> {},
}:
derivation (args// {
  name    = name;
  system  = "x86_64-linux";
  builder = pkgs.bash + /bin/bash;
  args    = [./mergedirs.sh] ++ dirs;
  mkdir   = pkgs.coreutils + /bin/mkdir;
  ln      = pkgs.coreutils + /bin/ln;
  outputHashMode = "recursive";
})