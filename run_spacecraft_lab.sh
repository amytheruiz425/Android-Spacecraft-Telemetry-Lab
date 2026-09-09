#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "BUILDING COBOL VALIDATOR"
cobc -x -free spacecraft_validator.cob

echo "BUILDING FORTRAN ANALYZER"
lfortran spacecraft_analyzer.f90 -o spacecraft_analyzer

echo "RUNNING COBOL VALIDATION"
./spacecraft_validator

echo "RUNNING FORTRAN ANALYSIS"
./spacecraft_analyzer

echo "RUNNING PYTHON JSON BRIDGE"
python spacecraft_to_json.py

echo "SPACECRAFT TELEMETRY PIPELINE COMPLETE"
cat mission_status.json
