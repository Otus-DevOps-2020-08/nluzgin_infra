#!/usr/bin/env python
# coding: utf-8

import json
import argparse

import googleapiclient.discovery

appname = 'reddit-app'
dbname = 'reddit-db'
project = 'infra-280913'
zone = 'europe-west1-b'


def get_instances_info(compute_engines):
    """
    Получение списка инстансов в гугле и информацию по ним
    :return:
    """
    result = compute_engines.instances().list(project=project, zone=zone).execute() or {}
    return result.get('items')


def get_instance_ip_by_name(name, instances):
    """
    Поиск всех ip инстанса по имени
    :param name:
    :param instances:
    :return:
    """
    ip_list = [access_config.get('natIP') for instance in instances
               if instance.get('name') == name
               for network_interface in instance.get('networkInterfaces', [])
               for access_config in network_interface.get('accessConfigs', [])
               if access_config.get('natIP')]
    return ip_list


def get_args():
    """
    Получение входных параметров
    :return: 
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('--list', required=False, action='store_true')
    args = parser.parse_args()
    return args


def main():
    """
    Получаем ip и струячим в файлы
    :return:
    """
    args = get_args()
    if args.list:

        compute_engines = googleapiclient.discovery.build('compute', 'v1')
        instances_info = get_instances_info(compute_engines)
        reddit_app_ip_list = get_instance_ip_by_name(name=appname, instances=instances_info)
        reddit_db_ip_list = get_instance_ip_by_name(name=dbname, instances=instances_info)

        inventory = {
            'app': {
                'hosts': [
                    appname
                ]
            },
            'db': {
                'hosts': [
                    dbname
                ]
            },

            '_meta': {
                'hostvars': {
                    appname: {
                        'ansible_host': reddit_app_ip_list[0]  # костыль, ноооо
                    },
                    dbname: {
                        'ansible_host': reddit_db_ip_list[0]
                    }

                }
            }
        }

        with open('inventory.json', mode='w', encoding='utf-8') as inventory_file:
            inventory_string = json.dumps(inventory)
            # именно этого ждёт ansible
            print(inventory_string)
            # Для потомков
            json.dump(inventory, inventory_file, sort_keys=True, indent=3)


if __name__ == '__main__':
    main()
