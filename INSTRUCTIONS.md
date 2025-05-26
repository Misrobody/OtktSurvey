## 0. Getting started

In this survey, we will need to install two custom python packages using pip. In order to not mess with your current setup, we will be using a virtual environment.

Activate the environment.

```bash
source .venv/bin/activate
```

At the end of the survey, you can desactivate the environment.

```bash
deactivate
```

## 1. Build Otkt
The following will build the Otkt code generator.
This will take a minute.

```bash
cd OtktDSL/kieker.otel.translation.parent/
./mvnw -P generator
cd ../..
```

Then copy the jar into the right place.

```bash
tools/copy.sh
```

Note: you can clean the project with `./mvnw clean` if necessary. 

## 2. Set up the probe and collector

### 2.1 Generate
The Otkt generator will produce the necessary code from an otkt quote.

```bash
java -jar tools/otkt-jar-with-dependencies.jar examples/demo.otkt
```

### 2.2 Build
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

## 3. Instrument anytree

### 3.1 Instrument the target python files

```bash
tools/instrument.sh anytree
```

### 3.2 Instrument the entrypoint

```bash
sed -i "1i from otkt.kieker.otelinit import tracer" examples/anytree-test.py
```

### 3.3 Install the instrumented app

```bash
pip install anytree
```

## 4. Collect Data

### 4.1 Run the collector
In a separate terminal.

```bash
java -jar otkt-gen/collector/target/collector-jar-with-dependencies.jar -c otkt-gen/config.txt
```

## 4.2 Run the app
Back to the original terminal.

```bash
python3 examples/anytree-test.py
```

In `/tmp` there should be kieker logs. If so, you can stop the collector.

```bash
ll /tmp/kieker*
```

## 6. Run the analysis

### 6.1 Aggregated Deployment Call Tree
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
--plot-Deployment-Sequence-Diagrams             \
--short-labels

# plot graphs
cd bin/dsdiagrams
../../tools/process.sh
cd ../..
```

## 7. Open the graphs
Open any .pdf of your choice with the following:

```bash
gio open output.pdf
```


