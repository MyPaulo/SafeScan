# Use a lightweight base image with GUI support
FROM kalilinux/kali-rolling

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    ruby \
    figlet \
    whois \
    dnsutils \
    whatweb \
    theharvester \
    firefox-esr \
    burpsuite \
    && gem install lolcat \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Create working directory
WORKDIR /opt/safescan

# Copy the SafeScan script into the container
COPY safescan.sh .

# Make the script executable
RUN chmod +x safescan.sh

ENV PATH="/usr/local/bin:${PATH}"


# Set the default command
ENTRYPOINT ["./safescan.sh"]
CMD []
