#!/bin/bash

# Launch a given app

if [ "$#" -eq 1 ]; then
    # Run the app
    echo "Application running...";
    cd apps/$1;
    python3 ../../src/$1-test.py
    cd ../..;
else
    echo "Wrong number of params: provide app name."
fi





