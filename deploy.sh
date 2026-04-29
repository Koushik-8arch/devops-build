#!/bin/bash
docker stop app || true
docker rm app || true
docker run -d -p 80:80 --name app devops-app
