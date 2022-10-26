/*
Cleaning Data in SQL Queries
*/

Select *
From PortafolioProject.dbo.NashvilleHousing

-- Standardize Date Format


Select SaleDateConverted, convert(Date,SaleDate)
From PortafolioProject.dbo.NashvilleHousing

Update NashvilleHousing
Set SaleDate= convert(Date,SaleDate)

Alter Table PortafolioProject.dbo.NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = Convert(Date,SaleDate)


-- Populate Property Address data

Select *
From PortafolioProject.dbo.NashvilleHousing
--where PropertyAddress is null
Order by ParcelID

Select A.ParcelID, A.PropertyAddress,B.ParcelID,B.PropertyAddress, ISNULL(A.PropertyAddress,B.PropertyAddress)
From PortafolioProject.dbo.NashvilleHousing A
JOIN PortafolioProject.dbo.NashvilleHousing B
	ON A.ParcelID = B.ParcelID
	AND A.[UniqueID ] <> B.[UniqueID ]
WHERE A.PropertyAddress IS NULL

UPDATE A
SET PropertyAddress= ISNULL(A.PropertyAddress,B.PropertyAddress)
From PortafolioProject.dbo.NashvilleHousing A
JOIN PortafolioProject.dbo.NashvilleHousing B
	ON A.ParcelID = B.ParcelID
	AND A.[UniqueID ] <> B.[UniqueID ]
WHERE A.PropertyAddress IS NULL

-- Breaking out Address into Individual Columns (Address, City, State)

Select 
SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1) as Address,	
	SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, len(PropertyAddress)) as CITY
From PortafolioProject.dbo.NashvilleHousing


Alter Table PortafolioProject.dbo.NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update PortafolioProject.dbo.NashvilleHousing
Set PropertySplitAddress= SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress)-1)

Alter Table PortafolioProject.dbo.NashvilleHousing
Add PropertySpliCity Nvarchar(255);

Update PortafolioProject.dbo.NashvilleHousing
Set PropertySpliCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, len(PropertyAddress)) 



Select OwnerAddress
From PortafolioProject.dbo.NashvilleHousing

Select 
	PARSENAME(REPLACE(OwnerAddress, ',','.'), 3)
,	PARSENAME(REPLACE(OwnerAddress, ',','.'), 2)
,	PARSENAME(REPLACE(OwnerAddress, ',','.'), 1) 
From PortafolioProject.dbo.NashvilleHousing



Alter Table PortafolioProject.dbo.NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update PortafolioProject.dbo.NashvilleHousing
Set OwnerSplitAddress= PARSENAME(REPLACE(OwnerAddress, ',','.'), 3)

Alter Table PortafolioProject.dbo.NashvilleHousing
Add OwnertySpliCity Nvarchar(255);

Update PortafolioProject.dbo.NashvilleHousing
Set OwnertySpliCity = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2) 

Alter Table PortafolioProject.dbo.NashvilleHousing
Add OwnertySpliState Nvarchar(255);

Update PortafolioProject.dbo.NashvilleHousing
Set OwnertySpliState = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)

Select *
From PortafolioProject.dbo.NashvilleHousing


-- Change Y and N to Yes and No in "Sold as Vacant" field- Identified the most comun used.

Select Distinct(SoldAsVacant),COUNT(SoldAsVacant)
From PortafolioProject.dbo.NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
,CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
 WHEN SoldAsVacant = 'N' THEN 'NO'
 ELSE SoldAsVacant
 END
From PortafolioProject.dbo.NashvilleHousing

UPDATE PortafolioProject.dbo.NashvilleHousing
SET SoldAsVacant = 
CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
 WHEN SoldAsVacant = 'N' THEN 'NO'
 ELSE SoldAsVacant
 END



 -- Remove Duplicates

 

 WITH RowNumCTE AS (
 Select *,

	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortafolioProject.dbo.NashvilleHousing
)
--Delete 
Select *
FROM RowNumCTE
WHERE row_num> 1
--ORDER BY PropertyAddress


--Delete Unused Columns


Select *
From PortafolioProject.dbo.NashvilleHousing

Alter Table PortafolioProject.dbo.NashvilleHousing
Drop Column OwnerAddress,TaxDistrict, PropertyAddress,SaleDate
