# OtktSurvey

## 1. Generate the instrumenting probe and collector
```
java -jar tools/otkt-jar-with-dependencies.jar examples/demo.otkt  otkt-bin/
```

## 2. Instrument anytree

### 2.1 Instrument the target python files
```
cd anytree
./../tools/instrument-py.sh
cd ..
```

### 2.2 Instrument the entrypoint
```
sed -i '1 i\from otkt.otelinit import tracer' examples/anytree-test.py
```

## 3. Set up the collector

### 3.1 Build
```
cd otkt-bin/collector
mvn clean package
cd ../..
```

### 3.2 Run
In a separate terminal
```
java -jar ./otkt-bin/collector/target/Collector-0.0.1-SNAPSHOT-jar-with-dependencies.jar -c ./res/config.txt
```

## 4. Run the app
```
python3 examples/anytree-test.py
```

## 5. Run the analysis
In `/tmp` there should be kieker logs. If not, go back to 4.

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
