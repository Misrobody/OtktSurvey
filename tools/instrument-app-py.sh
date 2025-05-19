#!/bin/bash

# Instrument all UXsim Python files
cd apps/$1
../../tools/instrument-py.sh
cd ../..

# Instrument entrypoint
sed -i '1 i\from otkt.otelinit import tracer' src/$1-test.py