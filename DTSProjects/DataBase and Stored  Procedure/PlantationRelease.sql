SELECT * FROM ORDR_PO_BRANDPACK WHERE PO_REF_NO IN('0219/PO/INP/III/13','0220/PO/INP/III/13','0221/PO/INP/III/13',
'0305/PO/INP/IV/13','0362/PO/INP/IV/13','0384/PO/INP/IV/13')
AND BRANDPACK_ID = '00055020LD';

--UPDATE ORDR_PO_BRANDPACK SET PLANTATION_ID = '058-00347'
--WHERE 
--PO_REF_NO IN('0219/PO/INP/III/13','0220/PO/INP/III/13','0221/PO/INP/III/13',
--'0305/PO/INP/IV/13','0362/PO/INP/IV/13','0384/PO/INP/IV/13')
--AND BRANDPACK_ID = '00055020LD';

--PLANTATION_ID = '058-00347'
--PO_REF_NO IN('0219/PO/INP/III/13','0220/PO/INP/III/13','0221/PO/INP/III/13',
--'0305/PO/INP/IV/13','0362/PO/INP/IV/13','0384/PO/INP/IV/13')
--AND BRANDPACK_ID = '00055020LD';

SELECT * FROM ORDR_PO_BRANDPACK WHERE PROJ_BRANDPACK_ID != NULL;