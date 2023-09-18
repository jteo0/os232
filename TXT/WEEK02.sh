#!/bin/bash

while IFS= read -r line; do
    grep '[0-9]{10}' inputSCRAP.txt >>outputSCRAP.txt
done < "inputSCRAP.txt"


