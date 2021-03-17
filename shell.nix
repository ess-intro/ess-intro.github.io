# To enable this shell run nix-shell from the command line and you will be
# dropped into a shell with the necessary packages installed to compile this
# site.
#
# NOTE If you encounter errors with the stringi library, the stackoverflow
# answer https://stackoverflow.com/a/35094828/15291819 provides a solution that
# seems to work, you just need to install stringi with the following command
#
# > install.packages("stringi",
#                    repos="http://cran.rstudio.com/",
#                    dependencies=TRUE)
#

let
  commitHash = "78dc359abf8217da2499a6da0fcf624b139d7ac3";
  tarballUrl = "https://github.com/NixOS/nixpkgs/archive/${commitHash}.tar.gz";
  pkgs = import (fetchTarball tarballUrl) {};
  stdenv = pkgs.stdenv;
in with pkgs; {
  myProject = stdenv.mkDerivation {
    name = "example-r-env";
    version = "1";
    src = if pkgs.lib.inNixShell then null else nix;

    buildInputs = with rPackages; [
      R
      dplyr
      purrr
      magrittr
      ggplot2
      stringr
      pandoc
    ];
   shellHook = ''
             printf "\n\nWelcome to a reproducible R shell :)\n\n"
      '';
  };
}
