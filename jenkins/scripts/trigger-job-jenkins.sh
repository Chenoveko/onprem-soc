#!/bin/bash

USER="admin"
API_TOKEN="111b561da83b28fc5051c442d3409c3391"
JENKINS_URL="192.168.43.110:8080"
JOB_NAME="remote-task"
curl \
-u $USER:$API_TOKEN \
-X POST "http://$JENKINS_URL/job/$JOB_NAME/build"