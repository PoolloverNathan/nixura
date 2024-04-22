{ nixpkgs ? import <nixpkgs> {} }:
let
  inherit (builtins)
    baseNameOf
    removeAttrs
    toString;
  inherit (nixpkgs)
    fetchFromGitHub
    runCommand;
  inherit (nixpkgs.lib)
    attrsets
    warn;
  inherit (attrsets)
    mapAttrs;
  bareLibrary =
    {
      github ? null,
      path,
      path2 ? path,
      hash ? null,
    }:
    { withPath ? (t: "") }:
    let
      hash'  = if hash == null && github != null then warn "No hash specified when fetching from GitHub (${github.owner}/${github.repo}). This build will fail." sha256:AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA= else hash;
      source = if github != null then "${fetchFromGitHub (github // { hash = hash'; })}/${toString path}" else ./. + path;
      path'  = withPath path2;
      dest   = if baseNameOf path' == "" then "" else "/" + baseNameOf path';
      name   = baseNameOf path2;
      result = runCommand name {} ''
        set -euo pipefail
        install ${source} -D ${"$"}{out}${dest}
      '';
    in result;
  library = {
    variants ? {},
    ...
  }@args:
  mapAttrs (k: v: library (removeAttrs args ["variants"] // v)) variants // {
    __functor = _: bareLibrary (removeAttrs args ["variants"]);
  };
in rec {
  grandpascout.gsanimblend = library {
    github = {
      owner = "GrandpaScout";
      repo = "GSAnimBlend";
      rev = "b56359131c252265902db3d7667169aa38571a7c";
    };
    path = /script/default/GSAnimBlend.lua;
    hash = sha256:xXniyK8mlwZBhi0bMBiyjbZgrNuj7oOsL79lT9LUztc=;
    variants = {
      lite = {
        path = /script/lite/GSAnimBlend.lua;
        path2 = /GSAnimBlend-lite.lua;
        hash = sha256:xXniyK8mlwZBhi0bMBiyjbZgrNuj7oOsL79lT9LUztc=;
      };
      tiny = {
        path = /script/lite/GSAnimBlend.lua;
        path2 = /GSAnimBlend-tiny.lua;
        hash = sha256:xXniyK8mlwZBhi0bMBiyjbZgrNuj7oOsL79lT9LUztc=;
      };
    };
  };
  hetman_foko.companionsapi = library {
    github = {
      owner = "FokoHetman";
      repo = "Companions";
      rev = "2ebdc5f89c73eb3f1c72e4359c717947e9c2ebcb";
    };
    path = /companionsapi.lua;
    hash = sha256:YkezHJYeVcYadaPBwpuHdbMDaASzM90DuwYHfBhDufM=;
  };
  jimmyhelp.jimmyanims = library {
    github = {
      owner = "JimmyHelp";
      repo = "JimmyAnims";
      rev = "8009440acc625b5ba175019e81b4bd100e1685e1";
    };
    path = /JimmyAnims.lua;
    hash = sha256:CPkvZHjU7fpPe9nudLJ8+mC6usa5pgGOWns8cUzFQ3E=;
  };
  kitcat962.dynamiccrosshair = library {
    github = {
      owner = "KitCat962";
      repo = "Figura-DynamicCrosshair";
      rev = "216da7a5dbfd6d5c802937f6c562934fe3c0050b";
    };
    path = /KattDynamicCrosshairSrc.lua;
    hash = sha256:YGs8Q9LGqBPNteVIcJR+NZ56JQtj6EDYcBKr+oewqvk=;
  };
  # manuel_2867.figura-scripts = library {
  #   github = {
  #     owner = "Manuel-3";
  #     repo = "figura-scripts";
  #     rev = "a0bac544045d6327907a27314faa56f24e0d023f";
  #   };
  #   path = /src;
  #   hash = sha256:LdSRdakaX76H1KvTrDHG3iFTHnJV9Dib6Xbpz1LsTig=;
  # };
  manuel_2867.runlater = library {
    github = {
      owner = "Manuel-3";
      repo = "figura-scripts";
      rev = "a0bac544045d6327907a27314faa56f24e0d023f";
    };
    path = /src/runLater/runLater.lua;
    hash = sha256:LdSRdakaX76H1KvTrDHG3iFTHnJV9Dib6Xbpz1LsTig=;
  };
  mitchoftarcoola.moararmsapi = library {
    github = {
      owner = "MitchOfTarcoola";
      repo = "MOARArmsAPI";
      rev = "99611909e004e38937983766e6a0c0463b9119ed";
    };
    path = /MOARArmsAPI.lua;
    hash = sha256:5G3DJjx7yb2l9PcDwoDO9vNlzOJrb2euOUDhijC2OOo=;
  };
  mrsirsquishy.squapi = library {
    github = {
      owner = "MrSirSquishy";
      repo = "SquishyAPI";
      rev = "36d3873ce270a47e417ff21c3b7f049f2a47b3cd";
    };
    path = /SquAPI.lua;
    hash = sha256:al95uCbf6ufNT3X/LC5XFO44Ernsh6n0ZdQ1vDWP+g0=;
  };
}
