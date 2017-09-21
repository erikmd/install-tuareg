#!/bin/bash
# Version 1

set -euo pipefail

mkdir -p ~/.emacs.d/lisp && cd ~/.emacs.d/lisp
wget https://github.com/ocaml/tuareg/releases/download/2.0.10/tuareg-2.0.10.tar.gz
tar xf tuareg-2.0.10.tar.gz

echo '
(load "~/.emacs.d/lisp/tuareg-2.0.10/tuareg-site-file")
' >> ~/.emacs
