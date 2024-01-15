INSERT INTO
	country_and_continent_codes_list
VALUES
	('Europe', 'EU', 'Kosovo, Republic of', 'KS', 'RKS', 383);
	
--\COPY public.oxcgrt_nat_latest FROM 'C:\\Program Files\\PostgreSQL\\15\\bin\\DB_HW2_data\\OxCGRT_nat_latest.csv' WITH DELIMITER ',' CSV HEADER QUOTE E'\"';
--\COPY public.oxcgrt_nat_latest FROM 'C:\\Program Files\\PostgreSQL\\15\\bin\\DB_HW2_data\\country-and-continent-codes-list-csv.csv' WITH DELIMITER ',' CSV HEADER QUOTE E'\"';

INSERT INTO 
    public.Country
SELECT DISTINCT
    Three_Letter_Country_Code, 
    Country_Name
FROM 
    country_and_continent_codes_list;

	
INSERT INTO 
    public.Continent
SELECT DISTINCT
    Continent_Code,
    Continent_Name
FROM 
    country_and_continent_codes_list;

INSERT INTO 
    public.Country_two_let
SELECT DISTINCT
    Three_Letter_Country_Code, 
	Two_Letter_Country_Code
FROM 
    country_and_continent_codes_list;

INSERT INTO 
    public.Country_num
SELECT DISTINCT
    Three_Letter_Country_Code, 
	Country_Number 
FROM 
    country_and_continent_codes_list;
	
INSERT INTO 
    public.Country_continent
SELECT DISTINCT
    Three_Letter_Country_Code, 
	Continent_Code
FROM 
    country_and_continent_codes_list;	

INSERT INTO
    public.Index(Country_Code, Date, Stringency_Avg, Stringency_Avg_Disp, GovResp_Avg, GovResp_Avg_Disp, ContainmentHealth_Avg,
    ContainmentHealth_Avg_Disp, EcoSup, EcoSup_Disp )
SELECT DISTINCT
    CountryCode,
    Date_,
    StringencyIndex_Average,
    StringencyIndex_Average_ForDisplay,
    GovernmentResponseIndex_Average,
    GovernmentResponseIndex_Average_ForDisplay,
    ContainmentHealthIndex_Average,
    ContainmentHealthIndex_Average_ForDisplay,
    EconomicSupportIndex,
    EconomicSupportIndex_ForDisplay
FROM
    OxCGRT_nat_latest;


INSERT INTO 
    public.Policy
SELECT DISTINCT
    Countrycode,
    Date_,
    C1M,
    C2M,
    C3M,
    C4M,
    C5M,
    C6M,
    C7M,
    C8EV,
    C1M_Flag,
    C2M_Flag,
    C3M_Flag,
    C4M_Flag,
    C5M_Flag,
    C6M_Flag,
    C7M_Flag,
    E1,
    E2,
    E3,
    E4,
    E1_Flag,
    H1,
    H2,
    H3,
    H4,
    H5,
    H6M,
    H7,
    H8M,
    H1_Flag,
    H6M_Flag,
    H7_Flag,
    H8M_Flag,
    M1,
    V1,
    V2A,
	V2B,
    V2C,
    V2D,
    V2E,
    V2F,
    V2G,
    V3,
    V4
FROM 
    OxCGRT_nat_latest;

INSERT INTO
    public.Cases
SELECT DISTINCT
    countrycode,
    Date_,
    ConfirmedCases,
    ConfirmedDeaths,
	MajorityVaccinated,
	PopulationVaccinated
FROM
    OxCGRT_nat_latest;