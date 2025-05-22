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

## 1. Setup the probe and collector
### Generate
Otkt will generate the necessary code from an otkt quote.
```
java -jar tools/otkt-jar-with-dependencies.jar examples/demo.otkt
```

### Build
The generated code is comprised made of:
- The collector (java project)
- The probe (python module)
The following will build the collector and install the probe.
```
cd otkt-gen
make
cd ..
```
Note: you can clean the project with `make clean` if necessary. 

## 2. Instrument anytree

### 2.1 Instrument the target python files
```
tools/instrument.sh anytree
```

### 2.2 Instrument the entrypoint
```
echo "from otkt.kieker.otelinit import tracer" > examples/anytree-test.py
```

## 3. Run the collector
In a separate terminal
```
java -jar otkt-gen/collector/target/Collector-0.0.1-SNAPSHOT-jar-with-dependencies.jar -c res/config.txt
```

## 4. Run the app
```
python3 examples/anytree-test.py
```

## 5. Run the analysis
In `/tmp` there should be kieker logs.

### 5.1 Aggregated Deployment Call Tree
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

### 5.2 Deployment Component Dependency Graph
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

### 5.3 Deployment Sequence Diagrams
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

## 6. Open the graphs
Open any .pdf of your choice with the following:
```
gio open output.pdf
```


