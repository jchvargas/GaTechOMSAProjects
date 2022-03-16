-------------------------------------------------------- Interactive Visualization of Association Rules ------------------------------------------------------------------------------------

Team Members: David Lysko, Jessica Chan Vargas, Ji Ho Ahn, Kunwoo Hong
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

1. DESCRIPTION ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

There are 3 files included in the CODE folder:
- ArulesApp.R
- DataCleaning.R
- online_retail_clean.csv 

The e-commerce dataset used in our project is hosted on the UCI Machine Learning Repository. It is an Excel file called Online Retail.xlsx and can be downloaded from the following site:
https://archive.ics.uci.edu/ml/machine-learning-databases/00352/ 

Saving this file as Online Retail.csv and running the DataCleaning.R script generates a clean dataset: online_retail_clean.csv. This is the file which has been included in the CODE folder.
The ArulesApp.R script uses this clean dataset as an input and generates an interactive R Shiny app for the visualization of association rules. 

2. INSTALLATION ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

R, RStudio, and required R libraries 

- Download and install R from the following link: https://cran.r-project.org/
- Download and install RStudio from the following link: https://www.rstudio.com/products/rstudio/download/ 
- Download the following R libraries: tidyverse, shiny, arules, arulesViz, visNetwork. To do so, run the following command in the RStudio console: 
install.packages(c("tidyverse", "shiny", "arules", "arulesViz", "visNetwork")

3. EXECUTION -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

3.1 Local Execution (for full dataset)

Open ArulesApp.R in RStudio and enter the shortcut Ctrl + Alt + R to run the code. After a few seconds, a new window will appear containing the interactive app. There are two sets of user 
inputs: 

1. On the left-hand side, there are selectors for support, confindence, and lift thresholds, along with an InvoiceDate range. Upon a change, the app will take a few seconds to update
the output graph and table. 
2. Above the network graph, there is a box with a default value of "Select by id". This box can be used to select an individual item of interest. Upon selection, the graph below
will highlight the association rules which that item is part of. 

3.2 On the Web (for demonstration only with limited dataset)

To show how the app would look on the web, we have deployed the Shiny app to shinyapps.io along with the first 100,000 rows of online_retail_clean.csv. The app can 
be accessed at the following link and does not require the Installation described in Step 2: https://dlysko3.shinyapps.io/Arules_App_Test 

The reason for limiting to 100,000 rows is to avoid exceeding the memory usage limit of the Free tier of shinyapps.io. Paying $39/month to upgrade to the Basic Tier would 
enable hosting the app along with the full dataset. For this project, however, all of the same functionality can be demonstrated using this limited dataset. 



 