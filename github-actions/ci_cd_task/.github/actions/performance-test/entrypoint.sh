#!/bin/bash
# add here your code for performance testing script
set -e

# Define the performance test command
JMX_FILE=${JMX_FILE:-/tests/performance_tests.jmx} # Default path to JMeter test file
RESULTS_FILE=${RESULTS_FILE:-/tests/results.jtl}  # Path to save test results

# Check if performance tests should be run
if [ "$RUN_TESTS" = "true" ]; then
  echo "Running performance tests with JMeter..."
  
  # Run the JMeter performance tests
  jmeter -n -t "$JMX_FILE" -l "$RESULTS_FILE"
  
  echo "Performance tests completed. Results saved to $RESULTS_FILE."
else
  echo "Skipping performance tests. Starting application..."
  
  # Start the application
  exec "$@"
fi