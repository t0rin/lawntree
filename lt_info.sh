#!/bin/zsh

# API documentation here: https://web.archive.org/web/20240517194654/https://mycscgo.com/api/v1/docs/static/index.html#/Student%20Cards/CommandsController_startMachineAnonStudentCard

# Get the script's filename without the extension
SCRIPT_NAME="${0:t:r}"

# Get the current timestamp in YYMMDD_HH:MM format
TIMESTAMP=$(date '+%Y%m%d_%H%M')

# Construct the output filename
OUTPUT_FILE="${SCRIPT_NAME}_${TIMESTAMP}.txt"

# Debugging: Print the output file name
echo "Output file will be: $OUTPUT_FILE"

# Check if the directory is writable
if [ ! -w "$(pwd)" ]; then
  echo "Error: Current directory is not writable."
  exit 1
fi

# Initialize or clear the output file using a different approach
: > "$OUTPUT_FILE" || { echo "Failed to initialize $OUTPUT_FILE"; exit 1; }

# Debugging: Confirm the file has been initialized
if [ -f "$OUTPUT_FILE" ]; then
  echo "$OUTPUT_FILE initialized successfully."
else
  echo "Failed to create $OUTPUT_FILE."
  exit 1
fi

# Define the base URL and headers
BASE_URL='https://mycscgo.com/api/v1/machine/number/'
LOCATION_ID='19c2583c-1b94-4a24-b617-f7fbb255893a'
ROOM_ID='4427062-001'
HEADERS=(
  '-H' 'accept: application/json'
  '-H' 'User-Agent: CSCGo/1.0.0/2020100101 (iOS; 14.0; iPhone 12 Pro Max)'
  '-H' 'Accept-Language: en-US'
)

# Iterate through machine IDs from 1 to 8
for MACHINENUM in {1..8}; do
  curl -X 'GET' \
    "${BASE_URL}${MACHINENUM}?locationId=${LOCATION_ID}&roomId=${ROOM_ID}" \
    "${HEADERS[@]}" >> "$OUTPUT_FILE"
  
  # Add a newline after each entry
  echo "\n" >> "$OUTPUT_FILE"
done

echo "Output written to $OUTPUT_FILE"

