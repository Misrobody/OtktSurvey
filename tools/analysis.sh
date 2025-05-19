#!/bin/bash

#
# * Performs a given kieker analysis on existing kieker logs
#

# Check params
if [ "$#" -eq 2 ]; then
    outdir="bin/$1"
else
    echo "Wrong number of params: <output-dir> <component|sequence>"
    exit 1
fi

# Create output directory and clean if exists
rm -f $outdir/*
mkdir -p $outdir

if [ "$2" == "component" ]; then

    # Run analysis
    ./trace-analysis-2.0.2/bin/trace-analysis \
    --inputdirs ./bin/kieker*                 \
    --outputdir $outdir                       \
    --plot-Deployment-Component-Dependency-Graph none

    # Plot pdf
    cd $outdir;
    dot deploymentComponentDependencyGraph.dot -T pdf -o output.pdf
    cd ..;
    
    exit 0

elif [ "$2" == "sequence" ]; then

    # Run analysis
    ./trace-analysis-2.0.2/bin/trace-analysis \
    --inputdirs ./bin/kieker*                 \
    --outputdir $outdir                       \
    --plot-Deployment-Sequence-Diagrams

    # Retrieve the number of generated pic files
    highest_num=$(ls $outdir/deploymentSequenceDiagram-*.pic | grep -o '[0-9]\+' | sort -nr | head -n1)

    # Process all the .pic files
    for i in $(seq 1 $highest_num);
    do 
        pic2plot -T ps $outdir/deploymentSequenceDiagram-$i.pic > $outdir/output-$i.ps
        ps2pdf $outdir/output-$i.ps $outdir/output-$i.pdf
    done  

    exit 0

elif [ "$2" == "calltree" ]; then

    # Run analysis                         
    ./trace-analysis-2.0.2/bin/trace-analysis \
    --inputdirs ./bin/kieker*                 \
    --outputdir $outdir                       \
    --plot-Aggregated-Deployment-Call-Tree

    # Plot pdf
    cd $outdir;
    dot aggregatedDeploymentCallTree.dot -T pdf -o output.pdf
    cd ..;

    exit 0


elif [ "$2" == "dar" ]; then

    # Run analysis                         
    ./trace-analysis-2.0.2/bin/trace-analysis \
    --inputdirs ./bin/kieker*                 \
    --outputdir $outdir                       \
    --plot-Aggregated-Deployment-Call-Tree

    ./dar-2.0.3-SNAPSHOT/bin/dar -i ./bin/kieker* -o ./bin/out -l dynamic -E demo-project -s java -m java-class-long-mode

    ./dar-2.0.3-SNAPSHOT/bin/dar -i ./input-data/operation-execution-log -o ./bin/ -l dynamic -E demo-project -s java -m java-class-long-mode

    ./dar-2.0.3-SNAPSHOT/bin/dar -i ./input-data/test-log -o ./bin/ -l dynamic -E demo-project -s java -m java-class-mode

    # dar -i ./bin/kieker* -o ./bin/out -l dynamic -E demo-project -s java -m java-class-long-mode `

    # Plot pdf
    #cd $outdir;
    #dot aggregatedDeploymentCallTree.dot -T pdf -o output.pdf
    #cd ..;

    exit 0

else
    echo "No diagram type found."
    exit 1
fi


