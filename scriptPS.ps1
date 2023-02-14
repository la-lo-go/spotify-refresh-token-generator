# Ask user to enter Spotify client ID and secret
$SPOTIFY_CLIENT_ID = Read-Host "Enter your Spotify client ID"
$SPOTIFY_CLIENT_SECRET = Read-Host "Enter your Spotify client secret"

# Navigate to authorization URL and retrieve code
$authUrl = "https://accounts.spotify.com/authorize?client_id=$SPOTIFY_CLIENT_ID&response_type=code&scope=user-read-currently-playing,user-read-recently-played&redirect_uri=http://localhost/callback/"
Start-Process $authUrl
$CODE = Read-Host "After logging in, please paste the code here"

# Create and encode base64 string
$BASIC = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$SPOTIFY_CLIENT_ID`:$SPOTIFY_CLIENT_SECRET"))

# Send curl request to retrieve access token and refresh token
$RESPONSE = Invoke-RestMethod -Method Post -Uri "https://accounts.spotify.com/api/token" -Headers @{Authorization = "Basic $BASIC" } -Body @{
    grant_type = "authorization_code"
    code = $CODE
    redirect_uri = "http://localhost/callback/"
}
$ACCESS_TOKEN = $RESPONSE.access_token
$REFRESH_TOKEN = $RESPONSE.refresh_token

# Print out refresh token
Write-Host "Your Spotify refresh token is: $REFRESH_TOKEN"

# Create .env file with credentials
@"
CLIENT_ID=$SPOTIFY_CLIENT_ID
CLIENT_SECRET=$SPOTIFY_CLIENT_SECRET
REFRESH_TOKEN=$REFRESH_TOKEN
"@ | Set-Content -Path ".env"


# Wait for user to press enter
Read-Host "Press enter to exit"