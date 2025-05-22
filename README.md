# OtktSurvey

This repository has submodules.
Either clone it with:
```
git clone --recurse-submodules <url>
```
Or run:
```
git submodule update --remote --recursive
```

## 1. Build Otkt
The following will build the Otkt code generator.
This will take a minute.
```
cd OtktDSL/kieker.otel.translation.parent/
./mvnw -P generator
cd ../..
```
Then copy the jar into the right place.
```
tools/copy.sh
```

Note: you can clean the project with `./mvnw clean` if necessary. 

## 2. Setup the probe and collector

### 2.1 Generate
The Otkt generator will produce the necessary code from an otkt quote.
```
java -jar tools/otkt-jar-with-dependencies.jar examples/demo.otkt
```

### 2.2 Build
The generated code is comprised of:
- A collector (java project)
- A probe (python module)

The following will build the collector and install the probe.
```
cd otkt-gen
make
cd ..
```
Note: you can clean the project with `make clean` if necessary. 

## 3. Instrument anytree

### 3.1 Instrument the target python files
```
tools/instrument.sh anytree
```

### 3.2 Instrument the entrypoint
```
sed -i "1i from otkt.kieker.otelinit import tracer" examples/anytree-test.py
```

## 4. Collect Data

### 4.1 Run the collector
In a separate terminal.
```
java -jar otkt-gen/collector/target/collector-jar-with-dependencies.jar -c res/config.txt
```

## 4.2 Run the app
Back to the original terminal.
```
python3 examples/anytree-test.py
```
In `/tmp` there should be kieker logs. If so, you can stop the collector.
```
ll /tmp/kieker*
```

## 6. Run the analysis

### 6.1 Aggregated Deployment Call Tree
```bash
# run analysis
./tools/trace-analysis-2.0.2/bin/trace-analysis \
--inputdirs /tmp/kieker*                        \
--outputdir ./bin/adctree                       \
--plot-Aggregated-Deployment-Call-Tree

# plot graph
cd ./bin/adctree
dot aggregatedDeploymentCallTree.dot -T pdf -o output.pdf
cd ../..
```

### 6.2 Deployment Component Dependency Graph
```bash
# run analysis 
./tools/trace-analysis-2.0.2/bin/trace-analysis \
--inputdirs /tmp/kieker*                        \
--outputdir ./bin/dcdgraph                      \
--plot-Deployment-Component-Dependency-Graph none

# plot graph
cd ./bin/dcdgraph
dot deploymentComponentDependencyGraph.dot -T pdf -o output.pdf
cd ../..
```

### 6.3 Deployment Sequence Diagrams
```bash
# run analysis
./tools/trace-analysis-2.0.2/bin/trace-analysis \
--inputdirs /tmp/kieker*                        \
--outputdir ./bin/dsdiagrams                    \
--plot-Deployment-Sequence-Diagrams

# plot graphs
cd bin/dsdiagrams
../../tools/process.sh
cd ../..
```

## 7. Open the graphs
Open any .pdf of your choice with the following:
```
gio open output.pdf
```


