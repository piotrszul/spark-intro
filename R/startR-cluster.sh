#!/bin/bash
set -e

sparkR --master yarn-client --num-executors 64 --packages com.databricks:spark-csv_2.10:1.4.0
