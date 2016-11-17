package com.hortonworks.examples

import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.hbase.client.{Get, HBaseAdmin, HTable}
import org.apache.hadoop.hbase.mapreduce.{TableInputFormat, TableOutputFormat}
import org.apache.hadoop.hbase.util.Bytes
import org.apache.spark.{SparkConf, SparkContext}

object HbaseExample {

  def main(arg: Array[String]) {

    if (arg.length < 2) {
      System.err.println("Usage: HbaseExample Hbase-Table RowKey")
      System.exit(1)
    }

    val jobName = "SparkHBaseTest"
    val conf = new SparkConf().setAppName(jobName)
    val sc = new SparkContext(conf)

    val hbaseTable = arg(0)
    val rowKey = arg(1)

    println("hbase table: " + hbaseTable)
    println("row key to get: " + rowKey)

    runTest(hbaseTable, rowKey, sc)
  }

  def runTest(hbaseTable: String, rowKey: String, sc: SparkContext): Null = {
    val hconf = HBaseConfiguration.create()

    hconf.set(TableOutputFormat.OUTPUT_TABLE, hbaseTable)
    hconf.set(TableInputFormat.INPUT_TABLE, hbaseTable)
    HBaseAdmin.checkHBaseAvailable(hconf)
    val htable = new HTable(hconf, hbaseTable)
    println("Hbase table connection established")
    println(htable.getTableDescriptor)
    println(htable.get(new Get(Bytes.toBytes(rowKey))).getMap)
    println("Getting count of records in table now...")
    val hBaseRDD = sc.newAPIHadoopRDD(hconf, classOf[TableInputFormat],
      classOf[org.apache.hadoop.hbase.io.ImmutableBytesWritable],
      classOf[org.apache.hadoop.hbase.client.Result])
    println(hBaseRDD.count())
    println("Done!")
    null
  }
}