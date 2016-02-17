:sh rm -rf output.txt
{
  sc.textFile("../data/input.txt")
        .flatMap(_.split("[^\\w]"))
        .map(_.toLowerCase().trim())
        .filter(!_.isEmpty())
        .map(word => (word, 1))
        .reduceByKey(_ + _)
        .map(_.swap)
        .sortByKey()
        .saveAsTextFile("output.txt")
}

