#!/bin/bash

ansible-galaxy install -r requirements.yml 
# deploy AWS with secret data 
ansible-playbook -i inventory/hosts playbooks/rai-attack-servers.yml