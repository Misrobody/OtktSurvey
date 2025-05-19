#!/bin/bash

# Clean previous kieker logs
rm -rf /home/dl/kieker-otel-interoperability/bin/kieker*

# Run collector
java -jar ./otkt/otkt-gen/collector/target/Collector-0.0.1-SNAPSHOT-jar-with-dependencies.jar -c ./res/config.txt
