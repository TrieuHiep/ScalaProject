#!/bin/bash
source /etc/profile
result=$(curl "http://10.3.34.23:8088/ws/v1/cluster/apps?state=RUNNING,ACCEPTED")
statusApp211=`echo $result | grep 'ViewPerformance' | grep -v grep`
result=$(curl "http://10.3.34.30:8088/ws/v1/cluster/apps?state=RUNNING,ACCEPTED")
statusApp65=`echo $result | grep 'ViewPerformance' | grep -v grep`
if [ -z $statusApp211 ] && [ -z $statusApp65 ]; then
cd /home/tatsuya/IdeaProjects/ScalaProject
$SPARK_HOME/bin/spark-submit \
--class viewperformance.ViewPerformance \
--master yarn-client \
--executor-memory 1500M \
--num-executors 10 \
--driver-memory 1500M \
--conf spark.storage.memoryFraction=0.1 \
/home/tatsuya/IdeaProjects/ScalaProject/ViewPerformance.jar \
1500 &
else
echo "running..."
fi
