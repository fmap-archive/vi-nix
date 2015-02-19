let
  inherit (builtins) length head tail elemAt attrNames;
in rec {
  mapAttrsToList = f: attrs:
    map (name: f name attrs.${name}) (attrNames attrs);
  intersperse = separator: list:
    if list == [] || length list == 1
    then list
    else [(head list) separator]
         ++ (intersperse separator (tail list));
  fold = op: nul: list:
    let
      len = length list;
      fold' = n:
        if n == len
        then nul
        else op (elemAt list n) (fold' (n + 1));
    in fold' 0;
  concatStrings = fold (x: y: x + y) "";
  concatStringsSep = separator: list: concatStrings (intersperse separator list);
  mapcats = f: x: concatStringsSep "\n" (mapAttrsToList f x);
}
