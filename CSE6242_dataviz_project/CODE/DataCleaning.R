# -------------------------------- Data Cleaning  ----------------------------------------
library(tidyverse)

# Load Online Retail data
df <- read.csv('Online Retail.csv') 

# Extract date for InvoiceDate column
df$InvoiceDate <- as.Date(df$InvoiceDate)

# Filter for rows where both Quantity and Price are valid numbers
df <- df[(df$Quantity > 0) & (df$UnitPrice > 0),] 

# Subset columns of interest
vars <- c("InvoiceNo", "Description", "InvoiceDate", "Country")
df <- df[vars]

# Filter for rows with valid product names only
df <- df[(!grepl("\\?", df$Description)) & df$Description != "" & df$Description != "20713"
         & df$Description != "AMAZON" & df$Description != "AMAZON FEE" & df$Description != "Sale error" ,] 

df <- df[(df$Description == toupper(df$Description) | grepl("\\d(g|x)", df$Description) | 
            grepl("Voucher", df$Description)),] 

# Keep remaining distinct rows only
df <- distinct(df)

summary(df)

write.csv(df, 'online_retail_clean.csv', row.names = FALSE)
# 518,525 rows by 4 columns
