#!/bin/zsh

# API documentation here: https://web.archive.org/web/20240517194654/https://mycscgo.com/api/v1/docs/static/index.html#/Student%20Cards/CommandsController_startMachineAnonStudentCard

# Define the base URL and headers
BASE_URL='https://mycscgo.com/api/v1/machine/number/'
LOCATION_ID='19c2583c-1b94-4a24-b617-f7fbb255893a'
ROOM_ID='4427062-001'
HEADERS=(
  '-H' 'accept: application/json'
  '-H' 'User-Agent: CSCGo/1.0.0/2020100101 (iOS; 14.0; iPhone 12 Pro Max)'
  '-H' 'Accept-Language: en-US'
)

# Function to send request and extract gas prices
send_request() {
  local machineNum=$1
  response=$(curl -s -G \
    --url "${BASE_URL}${machineNum}" \
    --data-urlencode "locationId=${LOCATION_ID}" \
    --data-urlencode "roomId=${ROOM_ID}" \
    "${HEADERS[@]}")

  # Parse the JSON response
  #json_body=$(echo "$response" | /opt/homebrew/bin/jq '.')
  #lawn_data=$(echo "$json_body" | /opt/homebrew/bin/jq '.[0:]')
  lawn_data=$(echo "$response" | /opt/homebrew/bin/jq '.')

  # Extract and display the gasPrices data
  machineType=$(echo "$lawn_data" | /opt/homebrew/bin/jq '.type')
  stickerNumber=$(echo "$lawn_data" | /opt/homebrew/bin/jq '.stickerNumber')
  machineAvailable=$(echo "$lawn_data" | /opt/homebrew/bin/jq '.available')
  echo "$TIMESTAMP $machineType $stickerNumber $machineAvailable"
}

for MACHINENUM in {1..8}; do
  #echo "Checking status for machine $MACHINENUM"
  send_request "$MACHINENUM"
done

echo "DONE!"

