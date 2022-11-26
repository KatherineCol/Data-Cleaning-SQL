# Data-Cleaning-SQL- 

   Use of  SQL Server Management Studio advanced queries were utilized to clean and manipulate raw database.

#### 1. Standardize Date Format 
  Utilised to improve visualisation on dates information.
  
<img width="217" alt="Screenshot_20221126_104937" src="https://user-images.githubusercontent.com/115903497/204102763-f9040861-353e-46c0-ab67-b7ae3115c5bb.png"><img width="217" alt="Screenshot_20221126_105747" src="https://user-images.githubusercontent.com/115903497/204100167-977b29fb-5fc6-4ba7-9d4d-e177228bc774.png">


#### 2. Breaking out Address into Individual Columns (Address, City, State)
  Preparing the data to be searchable by address, city, or state.  In the raw data base all this information was in only one column.

#### 3. Populate Property Address data
   Here we manage the null address rows by populating the appropiate addresses.


#### 4. Change Y and N to Yes and No in "Sold as Vacant" field & Identified the most comun used
  The use of mixed words and letters 'Yes','Y','N'and'No' were change to statdarize format.  

#### 5. Remove Duplicates
  Using the function row_number and a CTE duplicates are eliminated. 

#### 6. Delete Unused Columns


