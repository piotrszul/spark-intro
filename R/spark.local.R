library(SparkR,lib.loc=file.path(Sys.getenv("SPARK_HOME"),"R","lib"))
sc <- sparkR.init(master="local[*]")
dc <- sparkRSQL.init(sc)
