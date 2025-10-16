#!/bin/bash

# === Input Validation ===
if [ -z "$1" ]; then
  echo "Usage: ./recon.sh target.com"
  exit 1
fi

domain=$1
output_dir="recon_output/$domain"
temp_dir="$output_dir/tmp"

mkdir -p "$output_dir" "$temp_dir"
echo "[*] Recon started for: $domain"
echo "[*] Output will be saved in: $output_dir"
echo

#########################
# SUBDOMAIN ENUMERATION
#########################
subdomains_file="$output_dir/subdomains.txt"
> "$subdomains_file"

echo "[*] Starting subdomain enumeration..."

# Subfinder
echo "[+] Running subfinder..."
subfinder -d "$domain" -silent > "$temp_dir/subfinder.txt"

# Sublist3r
echo "[+] Running Sublist3r..."
sublist3r -d "$domain" -o "$temp_dir/sublist3r.txt" > /dev/null

# Gobuster DNS
echo "[+] Running gobuster dns..."
gobuster dns -d "$domain" -w /usr/share/wordlists/dns/subdomains-top1million-5000.txt -q -o "$temp_dir/gobuster_raw.txt" 2>/dev/null
cut -d ' ' -f1 "$temp_dir/gobuster_raw.txt" > "$temp_dir/gobuster_clean.txt"

# Combine and deduplicate
cat "$temp_dir"/subfinder.txt "$temp_dir"/sublist3r.txt "$temp_dir"/gobuster_clean.txt | sort -u > "$subdomains_file"
echo "[✔] Subdomains saved to: $subdomains_file"
echo

#########################
# DIRECTORY ENUMERATION
#########################
directories_file="$output_dir/directories.txt"
> "$directories_file"

echo "[*] Starting directory enumeration..."

# Gobuster dir
echo "[+] Running gobuster dir..."
gobuster dir -u "https://$domain" -w /usr/share/wordlists/dirb/common.txt -q -o "$temp_dir/gobuster_dirs_raw.txt" 2>/dev/null
grep 'Status:' "$temp_dir/gobuster_dirs_raw.txt" | cut -d ' ' -f1 > "$temp_dir/gobuster_dirs_clean.txt"

# Dirb
echo "[+] Running dirb..."
dirb "https://$domain" /usr/share/wordlists/dirb/common.txt -o "$temp_dir/dirb_raw.txt" > /dev/null
grep '+ https://' "$temp_dir/dirb_raw.txt" | awk '{print $2}' > "$temp_dir/dirb_clean.txt"

# Combine and deduplicate
cat "$temp_dir"/gobuster_dirs_clean.txt "$temp_dir"/dirb_clean.txt | sort -u > "$directories_file"
echo "[✔] Directories saved to: $directories_file"

#########################
# CLEANUP
#########################
rm -rf "$temp_dir"
echo
echo "[🎯] Recon complete for: $domain"
