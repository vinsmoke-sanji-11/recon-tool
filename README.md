Here’s a **professional README** template for your recon Bash tool. You can customize it for GitHub:

---

# Recon Tool

A simple **Bash reconnaissance tool** for automated subdomain and directory enumeration of a target domain. This script combines multiple popular tools to quickly gather subdomains and directories for penetration testing or bug bounty purposes.

---

## Features

* Subdomain enumeration using:

  * **Subfinder**
  * **Sublist3r**
  * **Gobuster DNS**
* Directory enumeration using:

  * **Gobuster**
  * **Dirb**
* Combines results from all tools and removes duplicates.
* Saves output in organized folders.
* Temporary files are cleaned automatically.

---

## Requirements

Make sure the following tools are installed and available in your `$PATH`:

* [Subfinder](https://github.com/projectdiscovery/subfinder)
* [Sublist3r](https://github.com/aboul3la/Sublist3r)
* [Gobuster](https://github.com/OJ/gobuster)
* [Dirb](https://tools.kali.org/web-applications/dirb)
* Bash environment (Linux, macOS, or WSL on Windows)

Wordlists required:

* DNS: `/usr/share/wordlists/dns/subdomains-top1million-5000.txt`
* Directories: `/usr/share/wordlists/dirb/common.txt`

---

## Usage

```bash
chmod +x recon.sh
./recon.sh target.com
```

* **target.com**: Replace with the domain you want to scan.
* Output will be saved in `recon_output/<target>/`.

Example:

```bash
./recon.sh example.com
```

---

## Output

* `recon_output/<target>/subdomains.txt` → List of discovered subdomains
* `recon_output/<target>/directories.txt` → List of discovered directories

Temporary files are stored in `recon_output/<target>/tmp` during execution and deleted automatically.

---

## Notes

* Ensure you have **permission** to run recon on the target domain. Unauthorized scanning is illegal.
* Customize wordlists as needed for more comprehensive results.

---

#
