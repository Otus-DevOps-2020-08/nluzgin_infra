#!/bin/bash

gcloud compute instances create reddit-full-instance\
  --image-family=reddit-full \
  --tags=puma-server
