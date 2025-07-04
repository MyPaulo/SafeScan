#!/bin/bash

# ─────────────────────────────────────────────
# SafeScan - Intelligent Web Scanner by Osuji
# ─────────────────────────────────────────────

#Required tools
dependencies=(figlet lolcat whois dig whatweb theHarvester firefox burpsuite)

#Check dependencies
check_dependencies() {
    missing=()

    for cmd in "${dependencies[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            missing+=("$cmd")
        fi
    done

    if [ ${#missing[@]} -ne 0 ]; then
        echo "The following dependencies are missing:" | lolcat 2>/dev/null || echo "The following dependencies are missing:"
        for m in "${missing[@]}"; do
            echo "   - $m"
        done
        echo -e "\nPlease install them and try again."
        exit 1
    fi
}

#Display banner
show_banner() {
    clear
    figlet -f slant "SafeScan" | lolcat
    echo "Intelligent Web Scanner | Built by Paul" | lolcat
    echo "Linux Environment Recommended" | lolcat
    echo
}

#Get and validate user input
get_user_input() {
    read -p "Enter target domain or URL: " target

    if [[ -z "$target" ]]; then
        echo -e "\nNo input provided. Exiting." | lolcat
        exit 1
    fi

    if ! [[ "$target" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo -e "\nInvalid domain format. Please enter a valid domain." | lolcat
        exit 1
    fi

    echo -e "\nTarget set to: $target\n" | lolcat
}

#Create log directory
prepare_logs() {
    log_dir="$HOME/safescan-logs/$(date +%Y-%m-%d_%H-%M-%S)"
    mkdir -p "$log_dir"
}


#Execute WhatWeb scan
execute_whatweb_scan(){

echo "[•] Running WhatWeb on $target..." | lolcat
    whatweb "$target" > "$log_dir/whatweb.txt"
    echo "[✓] WhatWeb results saved to: $log_dir/whatweb.txt" | lolcat
}


# Execute theHarvester scan

execute_harvester_scan() {
    echo "[•] Running theHarvester on $target..." | lolcat
    theHarvester -d "$target" -b bing > "$log_dir/theharvester.txt"
    echo "[✓] Harvester results saved to: $log_dir/theharvester.txt" | lolcat
}


generate_summary_report() {
    summary_file="$log_dir/summary.md"
    {
        echo "# SafeScan Summary Report"
        echo
        echo "**Target:** \`$target\`"
        echo
        echo "## Scan Results"
        echo
        echo "- WhatWeb Fingerprint"
        echo "- theHarvester Results"
        echo
        echo "---"
        echo
        echo "*Generated by SafeScan*"
    } > "$summary_file"

    echo "[✓] Summary report saved to: $summary_file" | lolcat
}

launch_optional_tools() {
    echo
    read -p "Do you want to launch Firefox and Burp Suite for manual analysis? (y/n): " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        echo "[•] Launching Firefox in private mode..." | lolcat
        firefox --private-window "$target" > /dev/null 2>&1 &

        echo "[•] Launching Burp Suite..." | lolcat
        nohup burpsuite > /dev/null 2>&1 &
    else
        echo "[i] Skipping manual tools." | lolcat
        echo "Scan complete! Happy Safescan 🕵️‍♂️" | lolcat
    fi
}




# Main
main() {
    check_dependencies
    show_banner
    get_user_input
    prepare_logs
    execute_whatweb_scan
    execute_harvester_scan
    generate_summary_report
    launch_optional_tools
}

main
