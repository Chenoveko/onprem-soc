# Start from the official Alpine base image
FROM alpine:latest

# Expose SSH port
EXPOSE 22

# Install packages, create user, configure SSH and set up .ssh in one layer
RUN apk update && apk add --no-cache openssh mariadb-client aws-cli nano \
    && adduser -D remote_user \
    && mkdir -p /home/remote_user/.ssh \
    && chmod 700 /home/remote_user/.ssh \
    && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && ssh-keygen -A

# Copy the public key and set correct ownership and permissions
COPY remote-key.pub /home/remote_user/.ssh/authorized_keys
RUN chown -R remote_user:remote_user /home/remote_user/.ssh \
    && chmod 600 /home/remote_user/.ssh/authorized_keys

# Start the SSH daemon in the foreground with verbose logging
CMD ["/usr/sbin/sshd", "-D", "-e"]

