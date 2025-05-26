## 1. Set up the probe and collector

### 1.1 Generate
The Otkt generator will produce the necessary code from an otkt quote.

```bash
java -jar tools/otkt-jar-with-dependencies.jar examples/demo.otkt
```

### 1.2 Build
The generated code is comprised of:
- A collector (java project)
- A probe (python module)

The following will build the collector and install the probe.

```bash
cd otkt-gen
make
cd ..
```

Note: you can clean the project with `make clean` if necessary. 

## 2. Instrument anytree

### 2.1 Instrument the target python files

```bash
tools/instrument.sh anytree
```

### 2.2 Instrument the entrypoint

```bash
sed -i "1i from otkt.kieker.otelinit import tracer" examples/anytree-test.py
```

### 2.3 Install the instrumented app

```bash
cd anytree
pip install .
cd ..
```

## 3. Collect Data

### 3.1 Run the collector
In a separate terminal.

```bash
java -jar otkt-gen/collector/target/collector-jar-with-dependencies.jar -c otkt-gen/config.txt
```

## 3.2 Run the app
Back to the original terminal.

```bash
python3 examples/anytree-test.py
```

In `/tmp` there should be kieker logs. If so, you can stop the collector.

```bash
ll /tmp/kieker*
```

## 4. Run the analysis

### 4.1 Aggregated Deployment Call Tree
```bash
# run analysis
./tools/trace-analysis-2.0.2/bin/trace-analysis \
--inputdirs /tmp/kieker*                        \
--outputdir ./bin/adctree                       \
--plot-Aggregated-Deployment-Call-Tree          \
--short-labels

# plot graph
cd ./bin/adctree
dot aggregatedDeploymentCallTree.dot -T pdf -o output.pdf
cd ../..
```

### 4.2 Deployment Component Dependency Graph
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

### 4.3 Deployment Sequence Diagrams
```bash
# run analysis
./tools/trace-analysis-2.0.2/bin/trace-analysis \
--inputdirs /tmp/kieker*                        \
--outputdir ./bin/dsdiagrams                    \
--plot-Deployment-Sequence-Diagrams             \
--short-labels

# plot graphs
cd bin/dsdiagrams
../../tools/process.sh
cd ../..
```

## 5. Open the graphs
Open any .pdf of your choice with the following:

```bash
gio open output.pdf
```


