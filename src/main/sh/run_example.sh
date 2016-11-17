#!/usr/bin/env bash

# Run this script as kinit'd real end-user. E.g.
# kinit -kt /etc/security/keytabs/smokeuser.headless.keytab ambari-qa-CRAIG_A@EXAMPLE.COM


hbase_jars=$(find /usr/hdp/current/hbase-client/lib/ -type f -name "*.jar" | tr -s '\n' ',')

export SPARK_CLASSPATH=/etc/hbase/conf:$(find /usr/hdp/current/hbase-client/lib/ -type f -name "*.jar" | tr -s '\n' ':')

spark-submit \
  --master yarn-cluster \
  --num-executors 2 \
  --class com.hortonworks.examples.HbaseExample \
  --jars /usr/hdp/current/spark-client/lib/datanucleus-api-jdo-3.2.6.jar,/usr/hdp/current/spark-client/lib/datanucleus-core-3.2.10.jar,/usr/hdp/current/spark-client/lib/datanucleus-rdbms-3.2.9.jar,$hbase_jars \
  --files /etc/hbase/conf/hbase-site.xml \
  ../lib/spark-hbase-test-0.0.1-SNAPSHOT.jar spark-example 1