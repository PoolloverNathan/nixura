{ nixpkgs ? import <nixpkgs> {} }@args:
with {
  nixura = import ./nixura.nix args;
  force = a: builtins.deepSeq a a;
};
import ./mergedirs.nix {
  name = "nixura-everything";
  dirs = map (a: a { withPath = p: p; warnings = false; }) (import ./list.nix nixura);
}
