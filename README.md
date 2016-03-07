Spark Examples for the Presentation
====================================

#Pre-requisites:

* java 8
* maven 3
* python 2.7
* ipython 3+

#Installing Apache Spark:

* Download Apache Spark version 1.6.0 pre-build with Hadoop 2.6.x from http://spark.apache.org/downloads.html
* Untar in desired location (SPARK_HOME) and add $SPARK_HOME/bin to your path

e.g in your `~/.bash_profile` :

	export SPARK_HOME=/opt/spark-1.6.0
	export PATH=$PATH:$SPARK_HOME/bin	


#Running iPython examples:

In `ipython` dir run:

	IPYTHON_OPTS="notebook" pyspark


#Running interactive shell examples:

For `pyspark` in shell dir run:

	pyspark	
	>>>  execfile("WordCount.py")

For `spark-shell` in shell dir run:

	spark-shell
	>>> :load WordCount.scala

#Runing java8 application

In `java8/wordcount` dir run: 

	mvn clean install  #to build the assembly jar
	./run-local.sh     #to run in local mode


#Running spark sql and spark ml example
In `ml` or `sql` dir run:

	IPYTHON_OPTS="notebook" pyspark --packages com.databricks:spark-csv_2.11:1.3.0


#More info:

Contact: piotr.szul@csiro.au


 
