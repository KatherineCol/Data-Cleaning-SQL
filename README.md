# Data Cleaning SQL 

Advanced queries in SQL Server Management Studio were utilized to clean and manipulate the raw database.
#### 1. Standardize Date Format 
         Utilized to improve visualization of date information.
  
#### 2. Breaking out Address into Individual Columns (Address, City, State)
         Preparing the data to be searchable by address, city, or state.  In the raw data base all this information was in only one column.

#### 3. Populate Property Address data
         Here we manage the null address rows by populating the appropiate addresses.


#### 4. Change Y and N to Yes and No in "Sold as Vacant" field & Identified the most comun used
         The use of mixed words and letters 'Yes', 'Y', 'N', and 'No' was changed to a standardized format.
         
#### 5. Remove Duplicates
         Using the function row_number and a CTE duplicates are eliminated. 

#### 6. Delete Unused Columns


