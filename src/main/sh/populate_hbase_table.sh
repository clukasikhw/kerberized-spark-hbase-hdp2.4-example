#!/usr/bin/env perl

# Run this script as kinit'd real end-user. E.g.
# kinit -kt /etc/security/keytabs/smokeuser.headless.keytab ambari-qa-CRAIG_A@EXAMPLE.COM

# It will populate HBase table with 1M rows

open(FH, "| hbase shell") || die "problem opening hbase shell";

$i = 0;
for ($i = 0; $i< 1000000; $i++) {
  print FH "put 'spark-example', '$i', 'temp:in', '$i'\n";
  print FH "put 'spark-example', '$i', 'temp:out', '$i'\n";
  print FH "put 'spark-example', '$i', 'vibration', '$i'\n";
  print FH "put 'spark-example', '$i', 'pressure:in', '$i'\n";
  print FH "put 'spark-example', '$i', 'pressure:out', '$i'\n";
}
