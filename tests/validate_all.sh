#!/bin/bash

python3 ./tests/packer_validate.py
python3 ./tests/terraform_validate.py
python3 ./tests/ansible_validate.py
