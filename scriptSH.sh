#!/bin/bash

# Ask user to enter Spotify client ID and secret
read -p "Enter your Spotify client ID: " SPOTIFY_CLIENT_ID
read -p "Enter your Spotify client secret: " SPOTIFY_CLIENT_SECRET

# Navigate to authorization URL and retrieve code
open "https://accounts.spotify.com/authorize?client_id=${SPOTIFY_CLIENT_ID}&response_type=code&scope=user-read-currently-playing,user-read-recently-played&redirect_uri=http://localhost/callback/"
read -p "After logging in, please paste the code here: " CODE

# Create and encode base64 string
BASIC=$(echo -n "${SPOTIFY_CLIENT_ID}:${SPOTIFY_CLIENT_SECRET}" | base64)

# Send curl request to retrieve access token and refresh token
RESPONSE=$(curl -s -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Authorization: Basic ${BASIC}" -d "grant_type=authorization_code&redirect_uri=http://localhost/callback/&code=${CODE}" https://accounts.spotify.com/api/token)
ACCESS_TOKEN=$(echo "${RESPONSE}" | jq -r '.access_token')
REFRESH_TOKEN=$(echo "${RESPONSE}" | jq -r '.refresh_token')

# Print out refresh token
echo "Your Spotify refresh token is: ${REFRESH_TOKEN}"

# Create .env file with credentials
cat > .env <<EOF
CLIENT_ID=${SPOTIFY_CLIENT_ID}
CLIENT_SECRET=${SPOTIFY_CLIENT_SECRET}
REFRESH_TOKEN=${REFRESH_TOKEN}
EOF
