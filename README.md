# RTSP Brute-Force Script

A Bash script to brute-force RTSP (Real-Time Streaming Protocol) credentials on IP cameras using common username, password, and RTSP path lists. It attempts to connect using VLC (cvlc) to verify valid credentials

Features
- Tries multiple usernames, passwords, and common RTSP paths
- Uses SecLists (cirt-default-usernames.txt) and rockyou.txt by default
- Stops immediately when valid credentials are found
- Works with cameras requiring IPv6 + interface binding (%INTERFACE)
- Simple to modify for custom wordlists

# Legal Disclaimer
This tool is for educational and authorized security testing only.
Do not use this on devices you do not own or have explicit permission to test. Unauthorized access is illegal.

