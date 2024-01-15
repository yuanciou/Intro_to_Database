WITH Country_To_Continent AS (
    SELECT
        Country.Country_Code,
        Country.Country_Name,
        Continent.Continent_Code,
        Continent.Continent_Name
    FROM
        Country
        NATURAL JOIN Country_Continent
        NATURAL JOIN Continent
),
Country_Code_Name AS (
    SELECT
        Country.Country_Code,
        Country_two_let.Two_Letter_Code,
        Country_num.Country_Num
    FROM
        Country
        NATURAL JOIN Country_two_let
        NATURAL JOIN Country_num
),
tem AS (
    SELECT 
        Country.Country_Code,
        Country_Continent.Continent_Code,
        Cases.date,
        Cases.Confirmed_Cases
    FROM
        Cases,
        Country,
        Country_Continent
    WHERE  
        Country.Country_Code=Cases.Country_Code AND 
        (Cases.Date = 20221126 
        OR Cases.Date = 20220325 
        OR Cases.Date = 20210325 
        OR Cases.Date = 20200325)
),
tem_temp AS (
    SELECT
        tem.Country_Code,
        tem.Continent_Code,
        tem.Date,
        Cases.Confirmed_Cases
    FROM 
        cases
        JOIN tem ON cases.country_Code = tem.Country_Code 
    WHERE 
        (cases.date=20221201 AND tem.date=20221126)
        OR (cases.date=20220401 AND tem.date=20220325)
        OR (cases.date=20210401 AND tem.date=20210325)
        OR (cases.date=20200401 AND tem.date=20200325)
),
Mov_Avg AS (
    SELECT
        Date,
        Country_Code,
        Confirmed_Cases,
        (Confirmed_Cases - LAG(Confirmed_Cases, 7) OVER ( 
            PARTITION BY Country_Code ORDER BY Date
        )) / 7 AS Moving_Average
    FROM
        Cases
),
OvStId AS (
    SELECT
        Index.Date,
        Index.Country_Code,
        Country_Continent.Continent_Code,
        CASE
            WHEN Mov_Avg.Moving_Average = 0 THEN Index.Stringency_Avg_Disp / 0.1
            ELSE Index.Stringency_Avg_Disp / Mov_Avg.Moving_Average
        END AS OveStId
    FROM
        Mov_Avg
        NATURAL JOIN Index
        NATURAL JOIN Country_Continent
),
MinMax_2020 AS (
    SELECT
        Date, Continent_Code, MAX(OveStId) AS Maximum, MIN(OveStId) AS Minimum
    FROM OvStId
    WHERE Date = 20200401
    GROUP BY Date, Continent_Code
),
MinMax_2021 AS (
    SELECT
        Date, Continent_Code, MAX(OveStId) AS Maximum, MIN(OveStId) AS Minimum
    FROM OvStId
    WHERE Date = 20210401
    GROUP BY Date, Continent_Code
),
MinMax_2022 AS (
    SELECT
        Date, Continent_Code, MAX(OveStId) AS Maximum, MIN(OveStId) AS Minimum
    FROM OvStId
    WHERE Date = 20220401
    GROUP BY Date, Continent_Code
),
MinMax_2022_12 AS (
    SELECT
        Date, Continent_Code, MAX(OveStId) AS Maximum, MIN(OveStId) AS Minimum
    FROM OvStId
    WHERE Date = 20221201
    GROUP BY Date, Continent_Code
),
Country_Code_Id_2020 AS (
    SELECT
        MM.Date, MM.Continent_Code, MM.Maximum, MM.Minimum,
        Highest.Country_Code AS Highest_CountryCode,
        Lowest.Country_Code AS Lowest_CountryCode
    FROM
        MinMax_2020 AS MM
        LEFT JOIN OvStId AS Highest
            ON (MM.Maximum = Highest.OveStId
                AND MM.Continent_Code = Highest.Continent_Code
                AND MM.Date = Highest.Date)
        LEFT JOIN OvStId AS Lowest
            ON (MM.Minimum = Lowest.OveStId
                AND MM.Continent_Code = Lowest.Continent_Code
                AND MM.Date = Lowest.Date)
),
Country_Code_Id_2021 AS (
    SELECT
        MM.Date, MM.Continent_Code, MM.Maximum, MM.Minimum,
        Highest.Country_Code AS Highest_CountryCode,
        Lowest.Country_Code AS Lowest_CountryCode
    FROM
        MinMax_2021 AS MM
        LEFT JOIN OvStId AS Highest
            ON (MM.Maximum = Highest.OveStId
                AND MM.Continent_Code = Highest.Continent_Code
                AND MM.Date = Highest.Date)
        LEFT JOIN OvStId AS Lowest
            ON (MM.Minimum = Lowest.OveStId
                AND MM.Continent_Code = Lowest.Continent_Code
                AND MM.Date = Lowest.Date)
),
Country_Code_Id_2022 AS (
    SELECT
        MM.Date, MM.Continent_Code, MM.Maximum, MM.Minimum,
        Highest.Country_Code AS Highest_CountryCode,
        Lowest.Country_Code AS Lowest_CountryCode
    FROM
        MinMax_2022 AS MM
        LEFT JOIN OvStId AS Highest
            ON (MM.Maximum = Highest.OveStId
                AND MM.Continent_Code = Highest.Continent_Code
                AND MM.Date = Highest.Date)
        LEFT JOIN OvStId AS Lowest
            ON (MM.Minimum = Lowest.OveStId
                AND MM.Continent_Code = Lowest.Continent_Code
                AND MM.Date = Lowest.Date)
),
Country_Code_Id_2022_12 AS (
    SELECT
        MM.Date, MM.Continent_Code, MM.Maximum, MM.Minimum,
        Highest.Country_Code AS Highest_CountryCode,
        Lowest.Country_Code AS Lowest_CountryCode
    FROM
        MinMax_2022_12  AS MM
        LEFT JOIN OvStId AS Highest
            ON (MM.Maximum = Highest.OveStId
                AND MM.Continent_Code = Highest.Continent_Code
                AND MM.Date = Highest.Date)
        LEFT JOIN OvStId AS Lowest
            ON (MM.Minimum = Lowest.OveStId
                AND MM.Continent_Code = Lowest.Continent_Code
                AND MM.Date = Lowest.Date)
)

SELECT
    CCI.Date,
    Highest.Continent_Name AS Continent,
    Highest.Country_Name AS Highest_Country,
    CCI.Maximum AS Highest_Over_Stringency_Index,
    Lowest.Country_Name AS Lowest_Country,
    CCI.Minimum AS Lowest_Over_Stringency_Index
FROM
    Country_Code_Id_2020 AS CCI
    LEFT JOIN Country_To_Continent AS Highest
        ON CCI.Highest_CountryCode = Highest.Country_Code
    LEFT JOIN Country_To_Continent AS Lowest
        ON CCI.Lowest_CountryCode = Lowest.Country_Code
UNION
SELECT
    CCI.Date,
    Highest.Continent_Name AS Continent,
    Highest.Country_Name AS Highest_Country,
    CCI.Maximum AS Highest_Over_Stringency_Index,
    Lowest.Country_Name AS Lowest_Country,
    CCI.Minimum AS Lowest_Over_Stringency_Index
FROM
    Country_Code_Id_2021 AS CCI
    LEFT JOIN Country_To_Continent AS Highest
        ON CCI.Highest_CountryCode = Highest.Country_Code
    LEFT JOIN Country_To_Continent AS Lowest
        ON CCI.Lowest_CountryCode = Lowest.Country_Code
UNION
SELECT
    CCI.Date,
    Highest.Continent_Name AS Continent,
    Highest.Country_Name AS Highest_Country,
    CCI.Maximum AS Highest_Over_Stringency_Index,
    Lowest.Country_Name AS Lowest_Country,
    CCI.Minimum AS Lowest_Over_Stringency_Index
FROM
    Country_Code_Id_2022 AS CCI
    LEFT JOIN Country_To_Continent AS Highest
        ON CCI.Highest_CountryCode = Highest.Country_Code
    LEFT JOIN Country_To_Continent AS Lowest
        ON CCI.Lowest_CountryCode = Lowest.Country_Code
UNION
SELECT
    CCI.Date,
    Highest.Continent_Name AS Continent,
    Highest.Country_Name AS Highest_Country,
    CCI.Maximum AS Highest_Over_Stringency_Index,
    Lowest.Country_Name AS Lowest_Country,
    CCI.Minimum AS Lowest_Over_Stringency_Index
FROM
    Country_Code_Id_2022_12 AS CCI
    LEFT JOIN Country_To_Continent AS Highest
        ON CCI.Highest_CountryCode = Highest.Country_Code
    LEFT JOIN Country_To_Continent AS Lowest
        ON CCI.Lowest_CountryCode = Lowest.Country_Code
ORDER BY
    Date, Continent;
