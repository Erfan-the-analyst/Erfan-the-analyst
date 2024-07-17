

---Cleaning Data in SQL Queries---(PORTFOLIO-PROJECT)



select*
from Portfolio..housing
-----------------------------------------------

-- Standardize Date Format


select saledate, CONVERT(date,saledate) 
from Portfolio..housing

update Portfolio..housing
set saledate = CONVERT(date,saledate) 

--it didnt work so..

alter table Portfolio..housing
add saledateconverted date;

update Portfolio..housing
set saledateconverted = CONVERT(date,saledate) 

select saledateconverted, CONVERT(date,saledate) 
from Portfolio..housing;

------------------------------------------------------

-- Populate Property Address data


select PropertyAddress
from Portfolio..housing
where PropertyAddress IS NULL;

select *
from Portfolio..housing
ORDER BY ParcelID;

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from Portfolio..housing a
join Portfolio..housing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null;

update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from Portfolio..housing a
join Portfolio..housing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null;

--------------------------------------------------------------------------


-- Breaking out Address into Individual Columns (Address, City, State)


select 
substring(propertyaddress,1, CHARINDEX(',' , PropertyAddress)-1) AS address, 
substring(propertyaddress,CHARINDEX(',' , PropertyAddress)+1 , len(propertyaddress)) as address

from Portfolio..housing

alter table Portfolio..housing
add propertysplitaddress nvarchar(255);

update Portfolio..housing
set propertysplitaddress = substring(propertyaddress,1, CHARINDEX(',' , PropertyAddress)-1)


alter table Portfolio..housing
add propertysplitcity nvarchar(255);

update Portfolio..housing
set propertysplitcity = substring(propertyaddress,CHARINDEX(',' , PropertyAddress)+1 , len(propertyaddress)) 

select*
from Portfolio..Housing


--we can use substring or parsename...

select OwnerAddress
from Portfolio..Housing

select 
PARSENAME(replace(owneraddress, ',' , '.'), 3) as Address
,PARSENAME(replace(owneraddress, ',' , '.'), 2) as City
,PARSENAME(replace(owneraddress, ',' , '.'), 1) as State

from Portfolio..Housing



alter table Portfolio..housing
add ownersplitaddress nvarchar(255);

update Portfolio..housing
set ownersplitaddress = PARSENAME(replace(owneraddress, ',' , '.'), 3) 

alter table Portfolio..housing
add ownersplitcity nvarchar(255);

update Portfolio..housing
set ownersplitcity = PARSENAME(replace(owneraddress, ',' , '.'), 2) 



alter table Portfolio..housing
add ownersplitState nvarchar(255);

update Portfolio..housing
set ownersplitState = PARSENAME(replace(owneraddress, ',' , '.'), 1) 

select*
from Portfolio..Housing

-----------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field


select distinct(SoldAsVacant), count(soldasvacant)
from Portfolio..Housing
group by SoldAsVacant
order by 2;

select SoldAsVacant
,case WHEN SoldAsVacant = 'Y' THEN 'YES'
	  WHEN SoldAsVacant = 'N' THEN 'NO'
	  ELSE SoldAsVacant
	  END
from Portfolio..Housing

UPDATE Portfolio..Housing
SET SoldAsVacant = case WHEN SoldAsVacant = 'Y' THEN 'YES'
	  WHEN SoldAsVacant = 'N' THEN 'NO'
	  ELSE SoldAsVacant
	  END

---------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference ORDER BY UniqueID) row_num
From Portfolio..Housing
)
			
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (PARTITION BY ParcelID,PropertyAddress,SalePrice,SaleDate, LegalReference ORDER BY UniqueID) row_num
From Portfolio..Housing
)
DELETE
From RowNumCTE
Where row_num > 1



WITH RowNumCTE AS(
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

From Portfolio..Housing

)
SELECT*
From RowNumCTE
Where row_num > 1
Order by PropertyAddress

--------------------------------------------

-- Delete Unused Columns



Select *
From Portfolio..Housing


ALTER TABLE Portfolio..Housing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate