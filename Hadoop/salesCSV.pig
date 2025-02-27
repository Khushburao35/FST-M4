-- Load the CSV file
salesTable = LOAD 'hdfs:///user/kkFst/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Rank the lines
rankedTable = RANK salesTable;
-- Filter out the first line
salesData = FILTER rankedTable BY (ranked_rankedTable > 1);
-- Group data using the country column
GroupByCountry = GROUP salesData BY Country;
-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
-- Save result in HDFS folder
STORE CountByCountry INTO 'hdfs:///user/kkFst/SalesOutput' USING PigStorage('\t');

