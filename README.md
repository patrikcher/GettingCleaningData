Getting and Cleaning Data
=========================
## Course Project Read Me
* Place run_analysis.R into a folder on your local drive. E.g. C:/Users/yourname/Documents/R/Course Project/

* In RStudio, enter the following commands into the console.
````
setwd("C:/Users/yourname/Documents/R/Course Project/")
source("run_analysis.R")
````

* To read data, enter the following command into the console.
````
data <- read.table("tidy_data_with_averages.txt")
````

* Note: Do not create UCI HAR Dataset folder manually. This will be created when you source run_analysis.R in console.