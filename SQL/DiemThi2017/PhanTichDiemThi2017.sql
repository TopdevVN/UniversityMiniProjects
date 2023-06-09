﻿CREATE DATABASE DIEMTHI
USE DIEMTHI

--Lay ra SBD va diem thi cac mon khoi A, A1 tuong ung va chuyen kieu du lieu diem sang float
SELECT SOBAODANH, 
CASE
	WHEN DIEM_THI like 'T[oan]%' THEN CAST(SUBSTRING(DIEM_THI, (CHARINDEX(N'Toán', DIEM_THI) + 7), 5) AS FLOAT)
	END AS DIEMTOAN,
CASE	
	WHEN DIEM_THI like '%V___l%' THEN CAST(SUBSTRING(DIEM_THI, (CHARINDEX(N'Vật lí', DIEM_THI) + 9), 5) AS FLOAT)
	END AS DIEMLY, 
CASE	
	WHEN DIEM_THI like '%H__ __c:%' THEN CAST(SUBSTRING(DIEM_THI, (CHARINDEX(N'Hóa học:', DIEM_THI) + 10), 5) AS FLOAT)
	END AS DIEMHOA,
CASE	
	WHEN DIEM_THI like '%T___g Anh:%' THEN CAST(SUBSTRING(DIEM_THI, (CHARINDEX(N'Tiếng Anh:', DIEM_THI) + 12), 5) AS FLOAT)
	END AS DIEMANH
into KHOIAA1 FROM DiemThi2017

SELECT * FROM KHOIAA1
Order by (DIEMTOAN + DIEMLY + DIEMHOA + DIEMANH) DESC

--Q1 Top 3 thi sinh co diem khoi A, A1 cao nhat 2017
	--KHOI A
	SELECT TOP 3 SOBAODANH, DIEMTOAN, DIEMLY, DIEMHOA 
	FROM KHOIAA1
	ORDER BY (DIEMTOAN + DIEMLY + DIEMHOA) DESC

	--KHOI A1
	SELECT TOP 3 SOBAODANH, DIEMTOAN, DIEMLY, DIEMANH
	FROM KHOIAA1
	ORDER BY (DIEMTOAN + DIEMLY + DIEMANH) DESC


--Q2 Tinh diem trung binh khoi A, A1 2017
--KHOI A
SELECT ROUND(AVG(DIEMTOAN + DIEMLY + DIEMHOA), 2) as Diem_TB_KhoiA FROM KHOIAA1
WHERE DIEMTOAN IS NOT NULL AND DIEMLY IS NOT NULL AND DIEMHOA IS NOT NULL

--KHOI A1
SELECT ROUND(AVG(DIEMTOAN + DIEMLY + DIEMANH), 2) as Diem_TB_KhoiA1 FROM KHOIAA1
WHERE DIEMTOAN IS NOT NULL AND DIEMLY IS NOT NULL AND DIEMANH IS NOT NULL



--Q3 Cho biet so diem khoi A, A1 ma nhieu thi sinh dat duoc nhat 2017
--KHOI A
WITH MucDiemKhoiA_CTE AS
(
	SELECT (DIEMTOAN + DIEMLY + DIEMHOA) AS CacMucDiemKhoiA FROM KHOIAA1 
	WHERE DIEMTOAN IS NOT NULL AND DIEMLY IS NOT NULL AND DIEMHOA IS NOT NULL
)
SELECT CacMucDiemKhoiA, COUNT(*) AS SoLuongThiSinhDatMucDiemTuongUng FROM MucDiemKhoiA_CTE
GROUP BY CacMucDiemKhoiA
ORDER BY SoLuongThiSinhDatMucDiemTuongUng DESC

--KHOI A1
WITH MucDiemKhoiA1_CTE AS
(
	SELECT (DIEMTOAN + DIEMLY + DIEMANH) AS CacMucDiemKhoiA1 FROM KHOIAA1 
	WHERE DIEMTOAN IS NOT NULL AND DIEMLY IS NOT NULL AND DIEMANH IS NOT NULL
)
SELECT CacMucDiemKhoiA1, COUNT(*) AS SoLuongThiSinhDatMucDiemTuongUng FROM MucDiemKhoiA1_CTE
GROUP BY CacMucDiemKhoiA1
ORDER BY SoLuongThiSinhDatMucDiemTuongUng DESC



--Q4 Nhung thi sinh thi khoi A, A1 co diem liet 2017
-- KHOI A
SELECT SOBAODANH, DIEMTOAN, DIEMLY, DIEMHOA
FROM KHOIAA1
WHERE (DIEMTOAN is not null and DIEMLY is not null and DIEMHOA is not null) and (DIEMTOAN <=1 or DIEMLY <=1 or DIEMHOA <=1)

--KHOI A1
SELECT SOBAODANH, DIEMTOAN ,DIEMLY, DIEMANH
FROM KHOIAA1
WHERE (DIEMTOAN is not null and DIEMLY is not null and DIEMANH is not null) and (DIEMTOAN <=1 or DIEMLY <=1 or DIEMANH <=1)



--Q5 Cho biet nhung thi sinh co diem thi tu 27 diem tro len cua khoi A, A1 2017
--KHOI A
SELECT SOBAODANH, DIEMTOAN, DIEMLY, DIEMHOA FROM KHOIAA1
WHERE (DIEMTOAN + DIEMLY + DIEMHOA) >= 27 
ORDER BY DIEMTOAN DESC, DIEMLY DESC, DIEMHOA DESC

--KHOI A1
SELECT SOBAODANH, DIEMTOAN, DIEMLY, DIEMANH FROM KHOIAA1
WHERE (DIEMTOAN + DIEMLY + DIEMANH) >= 27 
ORDER BY DIEMTOAN DESC, DIEMLY DESC, DIEMANH DESC



--Q6 Cho biet nhung thi sinh co diem thi tu 24 diem tro len cua khoi A nhung liet mon anh 2017
SELECT SOBAODANH, DIEMTOAN, DIEMLY, DIEMHOA, DIEMANH FROM KHOIAA1
WHERE (DIEMTOAN + DIEMLY + DIEMHOA) >= 24 AND DIEMANH <=1
ORDER BY DIEMTOAN DESC, DIEMLY DESC, DIEMHOA DESC



--Q7 Cho biet nhung thi sinh co diem thi tu 24 diem tro len cua khoi A1 nhung liet mon hoa 2017
SELECT SOBAODANH, DIEMTOAN, DIEMLY, DIEMANH, DIEMHOA FROM KHOIAA1
WHERE (DIEMTOAN + DIEMLY + DIEMANH) >= 24 AND DIEMHOA <=1
ORDER BY DIEMTOAN DESC, DIEMLY DESC, DIEMHOA DESC