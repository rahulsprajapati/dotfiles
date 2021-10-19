#!/usr/bin/env bash

echo "Initializing the setup.."

arch_name="$(uname -m)"

echo "Looking for the OS specific setup to execute... "

if [ "${arch_name}" = "x86_64" ]; then
    if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
        echo "Running on Rosetta 2"
    else
        # Running on native Intel
		./macOS/intel.sh
    fi 
elif [ "${arch_name}" = "arm64" ]; then
    # Running on m1-ARM
	./macOS/m1-arm.sh
else
    echo "Unknown architecture: ${arch_name}"
fi
