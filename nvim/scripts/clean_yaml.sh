#!/bin/bash

# Use yamlfmt to format the YAML
yamlfmt $1 >/tmp/yamlfmt_output.yaml

# Post-process the output to clean up for Helm and Kubernetes
sed 's/{? {.Values./{{ .Values./g' /tmp/yamlfmt_output.yaml | sed 's/ : ''} : ''}}/}}/g' >$1
