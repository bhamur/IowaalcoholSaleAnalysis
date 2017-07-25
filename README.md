# IowaalcoholSaleAnalysis
In this Project, I have implemented SSIS packages to load Sales Data Mart. I have followed Star Schema approach and there has already been some work done on the data set that I have listed in my References Section.

With this Analysis, I am trying to analyze below business scenarios

1. Sales Distribution across different liquor Category
2. Sales Distribution across different Vendor Category
3. Sales distribution across different Items
4. Sales distribution across Weekday vs Weekends

The data cleansing that has been done includes
1. The null and blank values for Category, County and City has been replaced by Unknown.
2. Since the Sale Amount in Dollars is not consistent, It has been calculated in SSIS package using derived column transformation as QtySold * StateBottleRetail.

The star schema design looks like below:

References:
https://gist.github.com/dannguyen/18ed71d3451d147af414
