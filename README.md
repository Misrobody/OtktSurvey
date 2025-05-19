# OtktSurvey

## 1. Build the otkt compiler
```
cd OtktDSL/kieker.otel.translation.parent/
./mvnw -P generator
```

## 2. Generate the instrumenting probe and collector
```
 java -jar kieker.otel.translation.generator/target/kieker.otel.translation.generator-1.0.0-SNAPSHOT-jar-with-dependencies.jar ../../examples/demo.otkt  ../../otkt-bin/
cd ../..
```

## 3. Instrument anytree
1. Instrument all the target python files
```
cd anytree
./../tools/instrument-py.sh
cd ..
```
2. Instrument the entrypoint
```
sed -i '1 i\from otkt.otelinit import tracer' examples/anytree-test.py
```

## 4. Run the collector
In a separate terminal
```
java -jar ./otkt-bin/collector/target/Collector-0.0.1-SNAPSHOT-jar-with-dependencies.jar -c ./res/config.txt
```

## 5. Run the app
```
python3 examples/anytree-test.py
```

## 6. Run the analysis
In `bin` there should be kieker logs. If not, go back to 4.

### Aggregated Deployment Call Tree
```bash
# run analysis
./trace-analysis-2.0.2/bin/trace-analysis \
--inputdirs ./bin/kieker*                 \
--outputdir ./bin/adctree                 \
--plot-Aggregated-Deployment-Call-Tree

# plot graph
cd ./bin/adctree
dot aggregatedDeploymentCallTree.dot -T pdf -o output.pdf
cd ..
```

### Deployment Component Dependency Graph
```bash
# run analysis 
./trace-analysis-2.0.2/bin/trace-analysis \
--inputdirs ./bin/kieker*                 \
--outputdir ./bin/dcdgraph                \
--plot-Deployment-Component-Dependency-Graph none

# plot graph
cd ./bin/dcdgraph
dot deploymentComponentDependencyGraph.dot -T pdf -o output.pdf
cd ..
```

### Deployment Sequence Diagrams
```bash
# run analysis
./trace-analysis-2.0.2/bin/trace-analysis \
--inputdirs ./bin/kieker*                 \
--outputdir ./bin/dsdiagrams              \
--plot-Deployment-Sequence-Diagrams

# plot graphs
cd ./bin/dsdiagrams
../tools/process.sh
cd ..
```



