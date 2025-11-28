# Start from the official Jenkins base image
FROM jenkins/jenkins:latest

# Switch to root user to install packages
USER root

# Update package lists and install pipx
RUN apt update && apt install pipx -y

# Use pipx to install Ansible along with its dependencies
RUN pipx install --include-deps ansible
ENV PATH="$PATH:/var/jenkins_home/.local/bin"

# Switch back to the default Jenkins user for security
USER jenkins