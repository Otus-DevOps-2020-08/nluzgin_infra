#!/usr/bin/env python
# coding: utf-8

import os
import subprocess

print('**** {} ****'.format(os.path.basename(__file__)))

# Предполагается, что скрипт запускается из корня репы

os.chdir('ansible/playbooks')
main_task = 'ansible-lint {FILE}'.format

for file_name in os.listdir():

    if not file_name.endswith('.yml'):
        continue

    task = main_task(FILE=file_name)
    executor = subprocess.Popen(args=task,
                                universal_newlines=True,
                                shell=True,
                                stdout=subprocess.PIPE,
                                stderr=subprocess.STDOUT)
    executor.wait()

    if executor.returncode != 0:
        print(executor.stdout.read())
        print('{TASK} -----> NOK!!!\n'.format(TASK=task))
    else:
        print('{TASK} -----> OK\n'.format(TASK=task))

