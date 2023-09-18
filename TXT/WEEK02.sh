#!/bin/bash

while IFS= read -r line; do
    grep -o '/[[:digit:]]{10}/g' inputSCRAP.txt >>outputSCRAP.txt
done < "inputSCRAP.txt"
