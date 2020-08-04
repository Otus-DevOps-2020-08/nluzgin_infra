#!/usr/bin/env python
# coding: utf-8

import os
import subprocess

print('**** {} ****'.format(os.path.basename(__file__)))

# Предполагается, что скрипт запускается из корня репы

cur_dir = os.getcwd()
variables = 'variables.json.example'
main_task = 'packer validate -var-file={VARIABLES} {FILE}'.format
# Эти фалы предполагается вызывать "с корня"
check_from_root_configns = ['app.json', 'db.json']

for file_name in os.listdir('packer'):

    if not file_name.endswith('.json') or 'variables' in file_name:
        continue

    variables_path = os.path.join('packer', variables)
    packer_file = os.path.join('packer', file_name)
    if file_name not in check_from_root_configns:
        os.chdir('packer')
        variables_path = variables
        packer_file = file_name

    task = main_task(VARIABLES=variables_path, FILE=packer_file)
    executor = subprocess.Popen(args=task,
                                universal_newlines=True,
                                shell=True,
                                stdout=subprocess.PIPE,
                                stderr=subprocess.STDOUT)
    executor.wait()
    os.chdir(cur_dir)

    if executor.returncode != 0:
        print(executor.stdout.read())
        print('{TASK} -----> NOK!!!\n'.format(TASK=task))
    else:
        print('{TASK} -----> OK\n'.format(TASK=task))
