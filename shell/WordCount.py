import os
os.system("mkdir -p target")
os.system("rm -rf target/wordcount.txt")

wordcount = sc.textFile('../data/input.txt') \
    .flatMap(lambda s: s.split(' ')) \
    .filter(lambda w:len(w) > 0) \
    .map(lambda w:(w.lower(),1)) \
    .reduceByKey(lambda a,b: a + b) \
    .map(lambda (word,count):(count, word)) \
    .sortByKey(False).map(lambda (count,word):(word, count)) 
wordcount.saveAsTextFile("target/wordcount.txt")
