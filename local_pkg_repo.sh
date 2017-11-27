#!/bin/bash
cd  ~/source/bin/targets/malta/le
python -m SimpleHTTPServer 8001 &
cd -
cd ~/source/bin/packages/mipsel_24kc
python -m SimpleHTTPServer 8000 &
cd -
