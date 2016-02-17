import java.util.Arrays;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;

import scala.Tuple2;

public class WordCount {

	public static void main(String[] args) {
		
	    JavaSparkContext sc = new JavaSparkContext(new SparkConf().setAppName("WordCount"));
	    JavaRDD<String> file = sc.textFile(args[0]);	    
	    file.flatMap(line -> Arrays.asList(line.split("[^\\w]")))
	    .map(arg0 ->arg0.toLowerCase().trim())
	    .filter(w->!w.isEmpty())
	    .mapToPair(w -> new Tuple2<String, Long>(w, 1L))
	    .reduceByKey((c1,c2) -> c1 + c2)
	    .coalesce(1,true)
	    .saveAsTextFile(args[1]);	
	
	    sc.stop();
	}

}
