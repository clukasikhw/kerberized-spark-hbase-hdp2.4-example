#!/usr/bin/env bash

# Run this script as kinit'd hbase user. E.g.
# kinit -kt /etc/security/keytabs/hbase.service.keytab hbase/craig-a-1@EXAMPLE.COM

echo "create 'spark-example','temp','vibration','pressure'" | hbase shell
echo "grant 'ambari-qa', 'RWXCA', 'spark-example'" | hbase shell
