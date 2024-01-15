CREATE TABLE public.Country
(
    Country_Code   CHAR(3),
    Country_Name   VARCHAR(100),
    primary key   (Country_Code)
);

CREATE TABLE public.Continent
(
    Continent_Code              CHAR(2),
    Continent_Name              VARCHAR(100),
    primary key (Continent_Code)
);

CREATE TABLE public.Country_two_let
(
    Country_Code      CHAR(3),
    Two_Letter_Code   CHAR(2),
    primary key   (Country_Code),
	foreign key (Country_Code) references Country(Country_Code)
);

CREATE TABLE public.Country_num
(
    Country_Code  CHAR(3),
    Country_Num   INT,
    primary key   (Country_Code),
	foreign key (Country_Code) references Country(Country_Code)
);

CREATE TABLE public.Country_continent
(
    Country_Code     CHAR(3),
    Continent_Code   CHAR(2),
    primary key   (Country_Code, Continent_code),
	foreign key (Country_Code) references Country(Country_Code),
    foreign key (Continent_Code) references Continent(Continent_Code)
);

CREATE TABLE public.Index
(
    Country_Code                                CHAR(3),
    Date                                        INT,
    Stringency_Avg                              NUMERIC(10,2),
    Stringency_Avg_Disp							NUMERIC(10,2),
	GovResp_Avg 							 	NUMERIC(10,2),
	GovResp_Avg_Disp							NUMERIC(10,2),
    ContainmentHealth_Avg					    NUMERIC(10,2),
	ContainmentHealth_Avg_Disp				    NUMERIC(10,2),
    EcoSup						                NUMERIC(10,2),
	EcoSup_Disp             					NUMERIC(10,2),
    primary key (Country_Code, Date),
    foreign key (Country_Code) references Country(Country_Code)
);

CREATE TABLE public.Policy
(
    Country_Code     	CHAR(3),
    Date                INT,

    C1M                 NUMERIC(3,2),
    C2M                 NUMERIC(3,2),
    C3M                 NUMERIC(3,2),
    C4M                 NUMERIC(3,2),
    C5M                 NUMERIC(3,2),
    C6M                 NUMERIC(3,2),
    C7M                 NUMERIC(3,2),
    C8EV                NUMERIC(3,2),
    C1M_Flag            BOOLEAN,
    C2M_Flag            BOOLEAN,
    C3M_Flag            BOOLEAN,
    C4M_Flag            BOOLEAN,
    C5M_Flag            BOOLEAN,
    C6M_Flag            BOOLEAN,
    C7M_Flag            BOOLEAN,

    E1                  NUMERIC(3,2),
    E2                  NUMERIC(3,2),
    E3                  FLOAT,
    E4                  FLOAT,
    E1_Flag             BOOLEAN,

    H1                  NUMERIC(3,2),
    H2                  NUMERIC(3,2),
    H3                  NUMERIC(3,2),
    H4                  FLOAT,
    H5                  FLOAT,
    H6M                 NUMERIC(3,2),
    H7                  NUMERIC(3,2),
    H8M                 NUMERIC(3,2),
    H1_Flag             BOOLEAN,
    H6M_Flag            BOOLEAN,
    H7_Flag             BOOLEAN,
    H8M_Flag            BOOLEAN,
	M1                  NUMERIC(3,2),	

    V1                  INT,
    V2A                 INT,
    V2B                 VARCHAR(20),
    V2C                 VARCHAR(20),
    V2D                 INT,
    V2E                 INT,
    V2F                 INT,
    V2G                 INT,
    V3                  INT,
    V4                  INT,

    primary key (Country_Code, Date),
    foreign key (Country_Code) references Country(Country_Code)
);

CREATE TABLE public.Cases
(
    Country_Code    			CHAR(3),
    Date                        INT,
    Confirmed_Cases             FLOAT,
	Confirmed_Deaths            FLOAT,
	Majority_Vaccinated         VARCHAR(5),
	Population_Vaccinated       NUMERIC(5,2),
    
    primary key (Country_Code, Date),
    foreign key (Country_Code) references Country(Country_Code)
);



CREATE TABLE public.OxCGRT_nat_latest
(
    CountryName         VARCHAR(100),
    CountryCode         CHAR(3),
    Date_               INT,
    C1M                 NUMERIC(3,2),
    C1M_Flag            BOOLEAN,
    C2M                 NUMERIC(3,2),
    C2M_Flag            BOOLEAN,
    C3M                 NUMERIC(3,2),
    C3M_Flag            BOOLEAN,
    C4M                 NUMERIC(3,2),
    C4M_Flag            BOOLEAN,
    C5M                 NUMERIC(3,2),
    C5M_Flag            BOOLEAN,
    C6M                 NUMERIC(3,2),
    C6M_Flag            BOOLEAN,
    C7M                 NUMERIC(3,2),
    C7M_Flag            BOOLEAN,
    C8EV                NUMERIC(3,2),
    E1                  NUMERIC(3,2),
    E1_Flag             BOOLEAN,
    E2                  NUMERIC(3,2),
    E3                  FLOAT,
    E4                  FLOAT,
    H1                  NUMERIC(3,2),
    H1_Flag             BOOLEAN,
    H2                  NUMERIC(3,2),
    H3                  NUMERIC(3,2),
    H4                  FLOAT,
    H5                  FLOAT,
    H6M                 NUMERIC(3,2),
    H6M_Flag            BOOLEAN,
    H7                  NUMERIC(3,2),
    H7_Flag             BOOLEAN,
    H8M                 NUMERIC(3,2),
    H8M_Flag            BOOLEAN,
    M1                  NUMERIC(3,2),
    V1                  INT,
    V2A                 INT,
    V2B                 VARCHAR(20),
    V2C                 VARCHAR(20),
    V2D                 INT,
    V2E                 INT,
    V2F                 INT,
    V2G                 INT,
    V3                  INT,
    V4                  INT,
    ConfirmedCases	                            INT,
    ConfirmedDeaths	                            INT,
    MajorityVaccinated	                        VARCHAR(2),
    PopulationVaccinated                        NUMERIC(10,2),
    StringencyIndex_Average                     NUMERIC(10,2),
    StringencyIndex_Average_ForDisplay          NUMERIC(10,2),
    GovernmentResponseIndex_Average             NUMERIC(10,2),
    GovernmentResponseIndex_Average_ForDisplay  NUMERIC(10,2),
    ContainmentHealthIndex_Average              NUMERIC(10,2),
    ContainmentHealthIndex_Average_ForDisplay   NUMERIC(10,2),
    EconomicSupportIndex                        NUMERIC(10,2),
    EconomicSupportIndex_ForDisplay             NUMERIC(10,2),
    primary key (CountryName, Date_)
);

CREATE TABLE public.country_and_continent_codes_list
(
    Continent_Name              VARCHAR(100),
    Continent_Code              CHAR(2),
    Country_Name                VARCHAR(100),
    Two_Letter_Country_Code     CHAR(2),
    Three_Letter_Country_Code   CHAR(3),
    Country_Number              INT
);






