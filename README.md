# Spotify Refresh Token Generator
Script that generates a refresh token for the Spotify Web API


## Prerequisites
To use this script, you'll need to have the following:
1. A Spotify account
2. The Spotify client ID and Secret Key (you can create an app in the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard/login))

## How to use
1. Clone or download this repository to your computer.
2. Navigate to the directory where you cloned or downloaded this repository.
3. Run the corresponding script:
   - Linux and Mac (Bash): `scriptSH.sh`
   - Windows (PowerShell): `scriptPS.ps1`
4. Follow the instructions in the terminal to enter your Spotify client ID and secret, and to log in to your Spotify account.
5. Once you have logged in, paste the authorization code into the terminal window as prompted.
6. At the end the script will generate a `.env` file with the following information:
   ```
    CLIENT_ID=<your-client-id>
    CLIENT_SECRET=<your-client-secret>
    REFRESH_TOKEN=<your-refresh-token>
   ```

## License
This script is licensed under the MIT License, which means you can use, modify, and distribute it freely as long as you include the license file and give credit to the original author
