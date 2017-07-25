# IowaalcoholSaleAnalysis
In this Project, I have implemented SSIS packages to load Sales Data Mart. I have followed Star Schema approach and there has already been some work done on the data set that has been listed under reference. In this project, data has been analyzed for below scenarios.

1. Iowa liquor consumption by county
2. Most Popular Alcohol Type or Brand
3. Alcohol consumption trend in Weekday vs Weekend

Challenges Faced: 
The data cleansing was a bit of challenge as many county/Category names were blank or null. The Sale Amount in Dollars was not consistent in calculation. So It has been calculated as QtySold * StateBottleRetail.

References:
https://gist.github.com/dannguyen/18ed71d3451d147af414
