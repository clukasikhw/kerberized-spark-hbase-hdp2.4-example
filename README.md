# kerberized-spark-hbase-hdp2.4-example
An example application that demonstrates how to use Spark to interact with HBase via both the HBase API for a Get op and via an RDD that leverages the HBase InputFormat.

# How to run:
```
# first build the package on your computer (mvn package)
# transfer the tar.gz file to the edge node
# login to edge node

# Login to the edge node and expand the tar
tar xvfz spark-hbase-test-0.0.1-SNAPSHOT-bin.tar.gz
# go to the sh dir inside
cd spark-hbase-test-0.0.1-SNAPSHOT/sh
# clear your kerberos ticket cache
kdestroy
# kinit with the hbase user (adjust as necessary)
kinit -kt /etc/security/keytabs/hbase.service.keytab hbase/craig-a-1@EXAMPLE.COM
# run this script to create the table
./create_hbase_table.sh
# clear your kerberos ticket cache
kdestroy
# kinit with the end-user (adjust as necessary)
kinit -kt /etc/security/keytabs/smokeuser.headless.keytab ambari-qa-CRAIG_A@EXAMPLE.COM
# populate the table with 1M records. Grab a cup of Joe. This might take some time.
./populate_hbase_table.sh

# run the test
./run_example.sh

# You can see the results in yarn logs (e.g. "yarn logs -applicationId application_1479315902463_0034"
# you will see something like this:
#
# hbase table: spark-example
# row key to get: 1
# Hbase table connection established
# 'spark-example', {NAME => 'pressure', BLOOMFILTER => 'ROW', VERSIONS => '1', IN_MEMORY => 'false', KEEP_DELETED_CELLS => 'FALSE', DATA_BLOCK_ENCODING => 'NONE', TTL => 'FOREVER', COMPRESSION => 'NONE', MIN_VERSIONS => '0', BLOCKCACHE => 'true', BLOCKSIZE => '65536', REPLICATION_SCOPE => '0'}, {NAME => 'temp', BLOOMFILTER => 'ROW', VERSIONS => '1', IN_MEMORY => 'false', KEEP_DELETED_CELLS => 'FALSE', DATA_BLOCK_ENCODING => 'NONE', TTL => 'FOREVER', COMPRESSION => 'NONE', MIN_VERSIONS => '0', BLOCKCACHE => 'true', BLOCKSIZE => '65536', REPLICATION_SCOPE => '0'}, {NAME => 'vibration', BLOOMFILTER => 'ROW', VERSIONS => '1', IN_MEMORY => 'false', KEEP_DELETED_CELLS => 'FALSE', DATA_BLOCK_ENCODING => 'NONE', TTL => 'FOREVER', COMPRESSION => 'NONE', MIN_VERSIONS => '0', BLOCKCACHE => 'true', BLOCKSIZE => '65536', REPLICATION_SCOPE => '0'}
# {[B@60c82222={[B@2fc4d286={1479409828905=[B@b28f213}, [B@20cd7920={1479409828923=[B@1358629}}, [B@8ec246b={[B@4498f70f={1479409828858=[B@f5792c5}, [B@227e59c8={1479409828874=[B@4bd8ee90}}, [B@48fb486b={[B@7b893a0b={1479409828890=[B@2be98cab}}}
# Getting count of records in table now...
# 1000000
# Done!
#

```
