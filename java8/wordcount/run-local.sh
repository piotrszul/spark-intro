#!/bin/bash
set -e

rm -rf target/output
spark-submit --master local --class WordCount target/wordcount-java8-1.0-SNAPSHOT-all.jar ../../data/input.txt target/output
