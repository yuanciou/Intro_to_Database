WITH Country_To_Continent AS(
	SELECT
		Country.Country_Code,
		Country.Country_Name,
		Continent.Continent_Code,
		Continent.Continent_Name
	FROM
		Country Natural JOIN Country_Continent
				Natural JOIN Continent
	),
	Country_Code_Name AS(
		SELECT
			Country.Country_Code,
			Country_two_let.Two_Letter_Code,
			Country_num.Country_Num
		FROM
			Country Natural JOIN Country_two_let
					Natural JOIN Country_num 
	),
	StringencyId_2020(Date, Continent_Code, Maximum, Minimum) AS(
	SELECT Date, Continent_Code, MAX(Stringency_Avg_Disp), Min(Stringency_Avg_Disp)
	FROM Index Natural JOIN Country_Continent
	WHERE Date = 20200401 
	GROUP BY Date, Continent_Code
	),
	StringencyId_2021(Date, Continent_Code, Maximum, Minimum) AS(
	SELECT Date, Continent_Code, MAX(Stringency_Avg_Disp), Min(Stringency_Avg_Disp)
	FROM Index Natural JOIN Country_Continent
	WHERE Date = 20210401 
	GROUP BY Date, Continent_Code
	),
	StringencyId_2022(Date, Continent_Code, Maximum, Minimum) AS(
	SELECT Date, Continent_Code, MAX(Stringency_Avg_Disp), Min(Stringency_Avg_Disp)
	FROM Index Natural JOIN Country_Continent
	WHERE Date = 20220401 
	GROUP BY Date, Continent_Code
	),
	StringencyId_2022_12(Date, Continent_Code, Maximum, Minimum) AS(
	SELECT Date, Continent_Code, MAX(Stringency_Avg_Disp), Min(Stringency_Avg_Disp)
	FROM Index Natural JOIN Country_Continent
	WHERE Date = 20221201
	GROUP BY Date, Continent_Code
	),
	CountryCode_Id_2020 AS(
	SELECT 
		S.Date, S.Continent_Code, Maximum,
		MaxCC.Country_Code AS Max_CountryCode,
		Minimum, MinCC.Country_Code AS Min_CountryCode
	FROM
		StringencyId_2020 AS S
		LEFT JOIN (Index Natural JOIN Country_Continent) AS MaxCC
			ON (S.Maximum = MaxCC.Stringency_Avg_Disp
				AND S.Date = MaxCC.Date
			   	AND S.Continent_Code = MaxCC.Continent_Code)
		LEFT JOIN (Index Natural JOIN Country_Continent) AS MinCC
			ON (S.Minimum = MinCC.Stringency_Avg_Disp 
				AND S.Date = MinCC.Date
			   	AND S.Continent_Code = MinCC.Continent_Code)
	ORDER BY S.Continent_Code
	),
	CountryCode_Id_2021 AS(
	SELECT 
		S.Date, S.Continent_Code, Maximum,
		MaxCC.Country_Code AS Max_CountryCode,
		Minimum, MinCC.Country_Code AS Min_CountryCode
	FROM
		StringencyId_2021 AS S
		LEFT JOIN (Index Natural JOIN Country_Continent) AS MaxCC
			ON (S.Maximum = MaxCC.Stringency_Avg_Disp
				AND S.Date = MaxCC.Date
			   	AND S.Continent_Code = MaxCC.Continent_Code)
		LEFT JOIN (Index Natural JOIN Country_Continent) AS MinCC
			ON (S.Minimum = MinCC.Stringency_Avg_Disp 
				AND S.Date = MinCC.Date
			   	AND S.Continent_Code = MinCC.Continent_Code)
	ORDER BY S.Continent_Code
	),
	CountryCode_Id_2022 AS(
	SELECT 
		S.Date, S.Continent_Code, Maximum,
		MaxCC.Country_Code AS Max_CountryCode,
		Minimum, MinCC.Country_Code AS Min_CountryCode
	FROM
		StringencyId_2022 AS S
		LEFT JOIN (Index Natural JOIN Country_Continent) AS MaxCC
			ON (S.Maximum = MaxCC.Stringency_Avg_Disp
				AND S.Date = MaxCC.Date
			   	AND S.Continent_Code = MaxCC.Continent_Code)
		LEFT JOIN (Index Natural JOIN Country_Continent) AS MinCC
			ON (S.Minimum = MinCC.Stringency_Avg_Disp 
				AND S.Date = MinCC.Date
			   	AND S.Continent_Code = MinCC.Continent_Code)
	ORDER BY S.Continent_Code
	),
	CountryCode_Id_2022_12 AS(
	SELECT 
		S.Date, S.Continent_Code, Maximum,
		MaxCC.Country_Code AS Max_CountryCode,
		Minimum, MinCC.Country_Code AS Min_CountryCode
	FROM
		StringencyId_2022_12 AS S
		LEFT JOIN (Index Natural JOIN Country_Continent) AS MaxCC
			ON (S.Maximum = MaxCC.Stringency_Avg_Disp
				AND S.Date = MaxCC.Date
			   	AND S.Continent_Code = MaxCC.Continent_Code)
		LEFT JOIN (Index Natural JOIN Country_Continent) AS MinCC
			ON (S.Minimum = MinCC.Stringency_Avg_Disp 
				AND S.Date = MinCC.Date
			   	AND S.Continent_Code = MinCC.Continent_Code)
	ORDER BY S.Continent_Code
	)
	
SELECT
	Date,
	Ma.Continent_Name,
	Maximum AS Highest_Stringency_Index, 
	Ma.Country_Name AS Highest_Country_Name,
	Minimum AS Lowest_Stringency_Index,
	Mi.Country_Name AS Lowest_Country_Name
FROM
	CountryCode_Id_2020
	LEFT JOIN Country_To_Continent AS Ma
		ON (CountryCode_Id_2020.Max_CountryCode = Ma.Country_Code
			AND CountryCode_Id_2020.Continent_Code = Ma.Continent_Code)
	LEFT JOIN Country_To_Continent AS Mi
		ON (CountryCode_Id_2020.Min_CountryCode = Mi.Country_Code
			AND CountryCode_Id_2020.Continent_Code = Mi.Continent_Code)
UNION
SELECT
	Date,
	Ma.Continent_Name,
	Maximum AS Highest_Stringency_Index, 
	Ma.Country_Name AS Highest_Country_Name,
	Minimum AS Lowest_Stringency_Index,
	Mi.Country_Name AS Lowest_Country_Name
FROM
	CountryCode_Id_2021
	LEFT JOIN Country_To_Continent AS Ma
		ON (CountryCode_Id_2021.Max_CountryCode = Ma.Country_Code
			AND CountryCode_Id_2021.Continent_Code = Ma.Continent_Code)
	LEFT JOIN Country_To_Continent AS Mi
		ON (CountryCode_Id_2021.Min_CountryCode = Mi.Country_Code
			AND CountryCode_Id_2021.Continent_Code = Mi.Continent_Code)
UNION
SELECT
	Date,
	Ma.Continent_Name,
	Maximum AS Highest_Stringency_Index, 
	Ma.Country_Name AS Highest_Country_Name,
	Minimum AS Lowest_Stringency_Index,
	Mi.Country_Name AS Lowest_Country_Name
FROM
	CountryCode_Id_2022
	LEFT JOIN Country_To_Continent AS Ma
		ON (CountryCode_Id_2022.Max_CountryCode = Ma.Country_Code
			AND CountryCode_Id_2022.Continent_Code = Ma.Continent_Code)
	LEFT JOIN Country_To_Continent AS Mi
		ON (CountryCode_Id_2022.Min_CountryCode = Mi.Country_Code
			AND CountryCode_Id_2022.Continent_Code = Mi.Continent_Code)
UNION
SELECT
	Date,
	Ma.Continent_Name,
	Maximum AS Highest_Stringency_Index, 
	Ma.Country_Name AS Highest_Country_Name,
	Minimum AS Lowest_Stringency_Index,
	Mi.Country_Name AS Lowest_Country_Name
FROM
	CountryCode_Id_2022_12
	LEFT JOIN Country_To_Continent AS Ma
		ON (CountryCode_Id_2022_12.Max_CountryCode = Ma.Country_Code
			AND CountryCode_Id_2022_12.Continent_Code = Ma.Continent_Code)
	LEFT JOIN Country_To_Continent AS Mi
		ON (CountryCode_Id_2022_12.Min_CountryCode = Mi.Country_Code
			AND CountryCode_Id_2022_12.Continent_Code = Mi.Continent_Code)
ORDER BY
	Date, Continent_Name, Highest_Country_Name