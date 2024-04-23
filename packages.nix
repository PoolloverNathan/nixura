# derives PACKAGES.md
{
  nixpkgs ? import <nixpkgs> {},
  nixura ? import ./nixura.nix { inherit nixpkgs; },
  listMkr ? import ./list.nix,
  list ? listMkr nixura,
  nameList ? listMkr { path = []; __functor = { path, __functor }: { inherit __functor; path = path; }; }
}: let
  inherit (nixpkgs)
    writeText;
  inherit (nixpkgs.lib.strings)
    concatStringsSep;
  inherit (builtins)
    toString;
  row = { name, github ? null, path, ... }: "* [${name}](${if github != null then with github; "https://github.com/${owner}/${repo}/tree/${rev}${toString path}" else toString path})";
in writeText "packages.md" (concatStringsSep "\n" (map row list))