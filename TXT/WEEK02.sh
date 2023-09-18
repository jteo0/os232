#!/bin/bash

while IFS= read -r line; do
    grep '[:digit:]{10}' inputSCRAP.txt >>outputSCRAP.txt
done < "inputSCRAP.txt"


