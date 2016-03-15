df <- read.df(sqlContext, '/var/examples/HIGGS/HIGGS.csv', "csv", header='false', inferschema='true')
print(df)
print(head(df))
