#!/usr/bin/env python
# coding: utf-8

import os
import subprocess

print('**** {} ****'.format(os.path.basename(__file__)))

# Предполагается, что скрипт запускается из корня репы

os.chdir('terraform')
main_task = ['terraform validate', 'tflint']
environments = ['prod', 'test']

for env in environments:

    for task in main_task:
        executor = subprocess.Popen(args=task,
                                    universal_newlines=True,
                                    shell=True,
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT)
        executor.wait()

        if executor.returncode != 0:
            print(executor.stdout.read())
            print('{TASK} for "{ENV}" environment -----> NOK!!!\n'.format(TASK=task, ENV=env))
        else:
            print('{TASK} for "{ENV}" environment -----> OK\n'.format(TASK=task, ENV=env))
