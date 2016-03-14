library(SparkR,lib.loc=file.path(Sys.getenv("SPARK_HOME"),"R","lib"))
sc <- sparkR.init(master="local[*]", sparkPackages=c("com.databricks:spark-csv_2.10:1.4.0"))
dc <- sparkRSQL.init(sc)
