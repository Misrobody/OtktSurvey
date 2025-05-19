#/bin/bash

# * Plots the multiple pic files given by the sequence diagram analysis.
#
# $1 : start number
# 
# $2 : end number

for i in $(seq $1 $2);
do 
    pic2plot -T ps deploymentSequenceDiagram-$i.pic > output-$i.ps

    ps2pdf output-$i.ps output-$i.pdf
done