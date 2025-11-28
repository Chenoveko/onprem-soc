FROM ubuntu:noble

# Install OpenSSH server
RUN apt update && \
    apt install -y openssh-server && \
    mkdir /var/run/sshd

# Create new user
RUN useradd -m -s /bin/bash remote_user && \
    echo "remote_user:1234" | chpasswd

# Set up SSH directory
RUN mkdir -p /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

# Copy public key
COPY remote-key.pub /home/remote_user/.ssh/authorized_keys

RUN chown -R remote_user:remote_user /home/remote_user/.ssh && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

# Generate host keys
RUN ssh-keygen -A

# Expose SSH port
EXPOSE 22

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D"]