{ nixpkgs ? import <nixpkgs> {} }@args:
with import ./nixura.nix args;
with {
  force = a: builtins.deepSeq a a;
};
import ./mergedirs.nix {
  dirs = map (a: a { withPath = p: p; }) [
    circlemaniac.cmwublib
    grandpascout.gsanimblend
    grandpascout.gsanimblend.lite
    grandpascout.gsanimblend.tiny
    hetman_foko.companionsapi
    jimmyhelp.jimmyanims
    kitcat962.dynamiccrosshair
    manuel_2867.runlater
    mitchoftarcoola.moararmsapi
    mrsirsquishy.squapi
  ];
}
