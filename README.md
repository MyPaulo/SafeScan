#SafeScan

**SafeScan** is an intelligent, terminal-based web reconnaissance tool for ethical hackers, cybersecurity students, and professionals. It automates passive and active scanning using tools like WhatWeb and theHarvester, generating clean logs and summary reports.

---

## Features

- Domain validation and input handling
- Passive scanning (WHOIS, DNS)
- Active scanning (WhatWeb, theHarvester)
- Markdown summary report generation
- Optional manual tools (Firefox + Burp Suite)
- Organized log output per scan session

---

## Requirements

Make sure the following tools are installed:

```bash
figlet lolcat whois dig whatweb theHarvester firefox burpsuite
```

Install them on Kali Linux with:

```bash
sudo apt install figlet lolcat whois dnsutils whatweb
sudo snap install burpsuite
```

---

## Usage

```bash
git clone https://github.com/yourusername/safescan.git
cd safescan
chmod +x safescan.sh
./safescan.sh
```

---

## Output Structure

Each scan creates a timestamped folder in `~/safescan-logs/`:

```
safescan-logs/
└── 2025-06-30_17-33-50/
    ├── whatweb.txt
    ├── theharvester.txt
    └── summary.md
```

---

## Why SafeScan?

SafeScan is designed to be:

- **Simple:** One script, no clutter.
- **Professional:** Clean output, structured logs.
- **Extendable:** Add more tools or export formats easily.

---

## License

MIT License — see LICENSE file for details.

---

## Author
Built by Paul Osuji



## Demo

!SafeScan Terminal Demo
