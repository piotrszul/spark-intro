:sh mkdir -p target
:sh rm -rf target/wordcount.txt
{
  sc.textFile("../data/input.txt")
        .flatMap(_.split("[^\\w]"))
        .map(_.toLowerCase().trim())
        .filter(!_.isEmpty())
        .map(word => (word, 1))
        .reduceByKey(_ + _)
        .map(_.swap)
        .sortByKey()
        .saveAsTextFile("target/wordcount.txt")
}

