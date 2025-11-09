#!/bin/sh
PAK_DIR="$(dirname "$0")"
cd "$PAK_DIR" || exit 1

export LD_LIBRARY_PATH=$PAK_DIR/lib:$LD_LIBRARY_PATH
export PATH=/usr/trimui/bin:$PATH

./retroarch -c retroarch.cfg --menu -v >> retroarch.log