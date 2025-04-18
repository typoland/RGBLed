#!/bin/bash
set -e
echo "run this script as . ./repair.sh"
#idf.py fullclean 
export SWIFT_TOOLCHAIN="$HOME/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2025-03-25-a.xctoolchain"
export PATH="$SWIFT_TOOLCHAIN/usr/bin:$PATH"      
swiftc -target riscv32-none-none-eabi -print-target-info | grep triple
source ~/EmbeddedSwift/esp/esp-idf/export.sh
idf.py set-target esp32h2
idf.py build
