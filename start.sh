#!/bin/bash

# Set AWS credentials and configuration for local DynamoDB
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_REGION=us-east-1
export DYNAMODB_ENDPOINT=http://localhost:4566

# Function to run main with INIT_DB variable set
run_main() {
  export INIT_DB=$1
  echo "Running with INIT_DB=$INIT_DB..."
  ./main
}

# Build the project
echo "Building the project..."
make build

# Check if script got a parameter
if [ "$1" == "true" ]; then
  run_main true
elif [ "$1" == "false" ]; then
  run_main false
else
  # No parameter: run both sequentially
  run_main true
  echo "First run (INIT_DB=true) finished. Starting second run (INIT_DB=false)..."
  run_main false
fi
