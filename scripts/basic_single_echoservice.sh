serverIP="http://0.0.0.0"
ports=8888
path="Echo/echo"
addr="${serverIP}:${ports}/${path}"

# JSON payload for the POST request (replace with your data)
data='{"message": "my echo message"}'

# Send the POST request and store the response in a variable
response=$(curl -X POST -H "Content-Type: application/json" -d "$data" "$addr")

# Print the response
echo "$response"