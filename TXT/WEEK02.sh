#!/bin/bash

while IFS= read -r line; do
    grep -o '[[:digit:]]{10}' inputSCRAP.txt >>outputSCRAP.txt
done < "inputSCRAP.txt"
