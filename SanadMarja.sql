
with NumberedRows as(
    select SanadMarjaNo,
    ROW_NUMBER() over (order by SanadMarjaNo) as row_num
    from tblsanad
),

DistinctValues as(
    select distinct
    SanadMarjaNo,
    ROW_NUMBER() OVER (order by SanadMarjaNo) as distinct_row_num
    from tblsanad
)
update tblsanad
  set SanadMarjaNo = (
  select top 1 distinct_row_num
  from DistinctValues
  where DistinctValues.SanadMarjaNo = tblsanad.SanadMarjaNo)
where SanadMarjaNo is not null;
