DELETE FROM ACCRUED_DETAIL WHERE ACHIEVEMENT_ID = ANY(SELECT ACHIEVEMENT_ID from ACCRUED_HEADER WHERE AGREEMENT_NO LIKE '%01122/NI/XI/2009-1L.11%');

DELETE  FROM ACCRUED_DETAIL WHERE ACHIEVEMENT_ID = ANY(SELECT ACHIEVEMENT_ID from ACCRUED_HEADER WHERE AGREEMENT_NO LIKE '%01122/NI/XI/2009-200ML.11%');
 
DELETE FROM ACCRUED_DETAIL WHERE ACHIEVEMENT_ID = ANY(SELECT ACHIEVEMENT_ID from ACCRUED_HEADER WHERE AGREEMENT_NO LIKE '%01122/NI/XI/2009-20L.11%');
 
DELETE FROM ACCRUED_DETAIL WHERE ACHIEVEMENT_ID = ANY(SELECT ACHIEVEMENT_ID from ACCRUED_HEADER WHERE AGREEMENT_NO LIKE '%01122/NI/XI/2009-4L.11%');
 
DELETE FROM ACCRUED_HEADER WHERE AGREEMENT_NO LIKE '%01122/NI/XI/2009-1L.11%'

DELETE FROM ACCRUED_HEADER WHERE AGREEMENT_NO LIKE '%01122/NI/XI/2009-200ML.11%'

DELETE FROM ACCRUED_HEADER WHERE AGREEMENT_NO LIKE '%01122/NI/XI/2009-20L.11%'

DELETE FROM ACCRUED_HEADER WHERE AGREEMENT_NO LIKE '%01122/NI/XI/2009-4L.11%'


SELECT * FROM ACCRUED_HEADER WHERE AGREEMENT_NO LIKE '%01122/NI/XI/2009-200ML.11%'