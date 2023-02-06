{ pkgs ? import <nixpkgs> { } }:
let
  hdlparse = pkgs.python3Packages.buildPythonPackage rec {
    pname = "hdlparse";
    version = "1.0.4";
    src = pkgs.fetchFromGitHub {
      owner = "hdl";
      repo = "pyHDLParser";
      rev = "e1153ace8ca1e25f9fb53350c41058ef8eb8dacf";
      sha256 = "sha256-XpOcQ801blKfQYLgZ4vDusZ8OkND0KmKxYUWzWKl/MM="; # TODO
    };
  };
in
with pkgs;
python3Packages.buildPythonPackage rec {
  name = "symbolator";
  version = "1.0.2";
  src = ./.;
  nativeBuildInputs = [ wrapGAppsHook gobject-introspection ];

  propagatedBuildInputs = [
    pango
    hdlparse
    python3Packages.pygobject3
    python3Packages.pycairo
    python3Packages.setuptools
    python3Packages.six
    python3Packages.docutils
    python3Packages.sphinx
  ];

  meta = with lib; {
    description = "A component diagramming tool for VHDL and Verilog";
    longDescription = ''
      Symbolator is a component diagramming tool for VHDL and Verilog. It will parse HDL source files, extract components or modules and render them as an image.
    '';
    homepage = "https://hdl.github.io/symbolator/";
    license = licenses.mit;
    platforms = lib.platforms.linux;
    mainProgram = "symbolator";
  };
}
