import os
os.system("rm -rf wordcount.txt")

sc.textFile('../data/input.txt') \
    .flatMap(lambda s: s.split(' ')) \
    .filter(lambda w:len(w) > 0) \
    .map(lambda w:(w.lower(),1)) \
    .reduceByKey(lambda a,b: a + b) \
    .map(lambda (word,count):(count, word)) \
    .sortByKey(False).map(lambda (count,word):(word, count)) \
    .saveAsTextFile("wordcount.txt")
