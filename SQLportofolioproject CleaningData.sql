select*
from [portfolio project ].[dbo].[NashvilleHousing]

select saleDate ,convert(Date, saleDate)
from [portfolio project ].[dbo].[NashvilleHousing]

select saleDate ,convert(Date, saleDate)
from [portfolio project ].[dbo].[NashvilleHousing]

update [portfolio project ].[dbo].[NashvilleHousing]
set saleDate = convert(Date, saleDate)

 Alter table [portfolio project ].[dbo].[NashvilleHousing]
 ADD saleDateconverted Date ;

 update [portfolio project ].[dbo].[NashvilleHousing]
set saleDateconverted = convert(Date, saleDate)

select saleDateconverted
from [portfolio project ].[dbo].[NashvilleHousing]

--populate propertyAddress

select propertyAddress
from [portfolio project ].[dbo].[NashvilleHousing]
WHERE propertyAddress is Null
 
 select *
from [portfolio project ].[dbo].[NashvilleHousing]
WHERE propertyAddress is Null
order by ParcelID

  select a.ParcelID , a.PropertyAddress,b.ParcelID ,b.PropertyAddress ,ISNULL(a.PropertyAddress,b.PropertyAddress)
from [portfolio project ].[dbo].[NashvilleHousing] a 
join [portfolio project ].[dbo].[NashvilleHousing] b
   on a.ParcelID = b.ParcelID
 and a.UniqueID <> b.UniqueID
 where a.PropertyAddress is Null 

 update a
 set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
 from [portfolio project ].[dbo].[NashvilleHousing] a 
join [portfolio project ].[dbo].[NashvilleHousing] b
   on a.ParcelID = b.ParcelID
 and a.UniqueID <> b.UniqueID
 where a.PropertyAddress is Null 

 --Breaking out Address into individuals columns (Address, City, State)


 
SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From [portfolio project ].[dbo].[NashvilleHousing]


ALTER TABLE [portfolio project ].[dbo].[NashvilleHousing]
Add PropertySplitAddress Nvarchar(255);

Update [portfolio project ].[dbo].[NashvilleHousing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE [portfolio project ].[dbo].[NashvilleHousing]
Add PropertySplitCity Nvarchar(255);

Update [portfolio project ].[dbo].[NashvilleHousing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

Select *
From [portfolio project ].[dbo].[NashvilleHousing]



Select OwnerAddress
From [portfolio project ].[dbo].[NashvilleHousing]


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From [portfolio project ].[dbo].[NashvilleHousing]


ALTER TABLE [portfolio project ].[dbo].[NashvilleHousing]
Add OwnerSplitAddress Nvarchar(255);

Update [portfolio project ].[dbo].[NashvilleHousing]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE [portfolio project ].[dbo].[NashvilleHousing]
Add OwnerSplitCity Nvarchar(255);

Update [portfolio project ].[dbo].[NashvilleHousing]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE [portfolio project ].[dbo].[NashvilleHousing]
Add OwnerSplitState Nvarchar(255);


select*
from[portfolio project ].[dbo].[NashvilleHousing]


---- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [portfolio project ].[dbo].[NashvilleHousing]
Group by SoldAsVacant
order by 2




Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From [portfolio project ].[dbo].[NashvilleHousing]


Update [portfolio project ].[dbo].[NashvilleHousing]
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


-----------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates


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

From [portfolio project ].[dbo].[NashvilleHousing]
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress




Select *
From [portfolio project ].[dbo].[NashvilleHousing]



---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From [portfolio project ].[dbo].[NashvilleHousing]


ALTER TABLE [portfolio project ].[dbo].[NashvilleHousing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate




Select *
From [portfolio project ].[dbo].[NashvilleHousing]

