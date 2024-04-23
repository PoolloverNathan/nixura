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
    warn
    warnIf;
  inherit (attrsets)
    mapAttrs;
  bareLibrary =
    {
      name,
      github ? null,
      path,
      path2 ? path,
      warn ? null,
      ...
    } @args:
    let
      root'  = if github != null then fetchFromGitHub github else ./.;
      source = root' + path;
    in args // {
      __functor = self: { warnings ? true, withPath ? (t: "") }: let
        path'  = withPath path2;
        dest   = if baseNameOf path' == "" then "" else "/" + baseNameOf path';
        bname  = baseNameOf path2;
        result = runCommand bname {} ''
          set -euo pipefail
          mkdir        -p  ${"$"}{out}${dest}
          rmdir            ${"$"}{out}${dest}
          ln ${source} -vs ${"$"}{out}${dest}
        '';
      in args // warnIf (warnings && warn != null) warn result;
      root = runCommand (baseNameOf path2 + "-source") {} ''
        set -euo pipefail
        ln -vs ${root'} $out
      '';
    };
  library = {
    variants ? {},
    ...
  }@args:
  let
    args' = removeAttrs args ["variants"];
    blib  = bareLibrary args';
  in blib // mapAttrs (k: v: library (args' // v)) variants;
in rec {
  auriafoxgirl.panels = library {
    name = "Auria Panels";
    github = {
      owner = "lua-gods";
      repo = "auria-panels";
      rev = "3c98c879ef6bb948710d9a25644f9f28f46dc7a6";
      hash = sha256:IUUN84C6PnwoQ2gUnEzIsl0AoVBD+nryfvkyph0L+BE=;
    };
    path = /panels;
  };
  circlemaniac.cmwublib = library {
    name = "CM's Wobble Value™ API";
    path = /embed/circlemaniac/CMwubLib.lua;
  };
  grandpascout.gsanimblend = library {
    name = "GSAnimBlend";
    github = {
      owner = "GrandpaScout";
      repo = "GSAnimBlend";
      rev = "b56359131c252265902db3d7667169aa38571a7c";
      hash = sha256:xXniyK8mlwZBhi0bMBiyjbZgrNuj7oOsL79lT9LUztc=;
    };
    path = /script/default/GSAnimBlend.lua;
    variants = {
      lite = {
        path = /script/lite/GSAnimBlend.lua;
        path2 = /liteGSAnimBlend.lua;
      };
      tiny = {
        path = /script/lite/GSAnimBlend.lua;
        path2 = /tinyGSAnimBlend.lua;
      };
    };
  };
  hetman_foko.companionsapi = library {
    name = "Companion API";
    github = {
      owner = "FokoHetman";
      repo = "Companions";
      rev = "2ebdc5f89c73eb3f1c72e4359c717947e9c2ebcb";
      hash = sha256:YkezHJYeVcYadaPBwpuHdbMDaASzM90DuwYHfBhDufM=;
    };
    path = /companionsapi.lua;
  };
  jimmyhelp.jimmyanims = library {
    name = "Jimmy's Animation Handler";
    github = {
      owner = "JimmyHelp";
      repo = "JimmyAnims";
      rev = "8009440acc625b5ba175019e81b4bd100e1685e1";
      hash = sha256:CPkvZHjU7fpPe9nudLJ8+mC6usa5pgGOWns8cUzFQ3E=;
    };
    path = /JimmyAnims.lua;
  };
  kitcat962.dynamiccrosshair = library {
    name = "Katt Dynamic Crosshair";
    github = {
      owner = "KitCat962";
      repo = "Figura-DynamicCrosshair";
      rev = "216da7a5dbfd6d5c802937f6c562934fe3c0050b";
      hash = sha256:YGs8Q9LGqBPNteVIcJR+NZ56JQtj6EDYcBKr+oewqvk=;
    };
    path = /KattDynamicCrosshairSrc.lua;
  };
  manuel_2867.confetti = library {
    name = "Confetti";
    github = {
      owner = "Manuel-3";
      repo = "figura-scripts";
      rev = "7cc66b3436e62bdfda51074da71183d8684f9d5a";
      hash = sha256:XyI7e4sTBpI2diWAj+AaiXE6IhIdDxpMG5HrJMUm/8E=;
    };
    path = /src/confetti/confetti.lua;
  };
  manuel_2867.hotbarsync = library {
    name = "Hotbar Sync";
    github = manuel_2867.confetti.github;
    path = /src/hotbarsync/hotbarsync.lua;
  };
  manuel_2867.quickoutline = library {
    name = "Quick Outline";
    github = manuel_2867.confetti.github;
    path = /src/quickoutline/quickoutline.lua;
  };
  manuel_2867.rainbownametag = library {
    name = "Rainbow Nametag";
    github = manuel_2867.confetti.github;
    path = /src/rainbownametag/script.lua;
    path2 = "rainbownametag.lua";
  };
  manuel_2867.runlater = library {
    name = "Run Later";
    warn = "manuel_2867.runlater: superseded by manuel_2867.sleepable";
    github = manuel_2867.confetti.github;
    path = /src/runLater/runLater.lua;
  };
  manuel_2867.sleepable = library {
    name = "Sleepable";
    github = manuel_2867.confetti.github;
    path = /src/sleepable/sleepable.lua;
  };
  manuel_2867.swingingphysics = library {
    name = "Swinging Physics";
    github = manuel_2867.confetti.github;
    path = /src/swingingphysics/swinging_physics.lua;
  };
  mitchoftarcoola.moararmsapi = library {
    name = "MOAR Arms API";
    github = {
      owner = "MitchOfTarcoola";
      repo = "MOARArmsAPI";
      rev = "99611909e004e38937983766e6a0c0463b9119ed";
      hash = sha256:5G3DJjx7yb2l9PcDwoDO9vNlzOJrb2euOUDhijC2OOo=;
    };
    path = /MOARArmsAPI.lua;
  };
  mrsirsquishy.squapi = library {
    name = "Squishy API";
    github = {
      owner = "MrSirSquishy";
      repo = "SquishyAPI";
      rev = "36d3873ce270a47e417ff21c3b7f049f2a47b3cd";
      hash = sha256:al95uCbf6ufNT3X/LC5XFO44Ernsh6n0ZdQ1vDWP+g0=;
    };
    path = /SquAPI.lua;
  };
}
