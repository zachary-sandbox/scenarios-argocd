#!/bin/bash
if ! command -v kind &> /dev/null
then
    echo "❌ kind binary not found in PATH"
    exit 1
fi
echo "✅ step1 passed: kind is installed"
exit 0
