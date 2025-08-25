------------------------------------ HEALTHCARE ANALYSIS -----------------------------------------------

------ START OF SCHEMA -----


---- CREATE TABLE FOR TEST_DATA ---


CREATE TABLE test_data(
 case_id int,	
 Hospital_code int,
 Hospital_type_code	 text,
 City_Code_Hospital	int,
 Hospital_region_code text,
 Available_Extra_Rooms_in_Hospital	int,
 Department	varchar(20),
 Ward_Type	text,
 Ward_Facility_Code	text,
 Bed_Grade varchar(15),
 patientid	int,
 City_Code_Patient	varchar(15),
 Type_of_Admission	text,
 Severity_of_Illness text,
 Visitors_with_Patient 	int,
 Age varchar(10),
 Admission_Deposit int,
 Stay varchar(10)
);


-----CREATE TABLE FOR TRAIN_DATA -------

CREATE TABLE train_data(
case_id	 int,
Hospital_code int,
Hospital_type_code	text,
City_Code_Hospital	int,
Hospital_region_code text,
Available_Extra_Rooms_in_Hospital int,
Department text,
Ward_Type text,
Ward_Facility_Code text,
Bed_Grade varchar(15),
patientid int,
City_Code_Patient varchar(15),
Type_of_Admission text,
Severity_of_Illness	 text,
Visitors_with_Patient	int,
Age	varchar(15),
Admission_Deposit int,
Stay varchar(10)
);

ALTER TABLE train_data ALTER COLUMN stay TYPE varchar(20);

SELECT * FROM test_data;
SELECT * FROM train_data ;

---- END OF SCHEMA ---


--------------------------------------DATA CLEANING ----------------------------------------------------

--- HANDLING NULL VALUES ---

-- Count no of each column value in test_data 
SELECT 
    COUNT(case_id) AS case_id_count,
    COUNT(Hospital_code) AS Hospital_code_count,
    COUNT(Hospital_type_code) AS Hospital_type_code_count,
    COUNT(City_Code_Hospital) AS City_Code_Hospital_count,
    COUNT(Hospital_region_code) AS Hospital_region_code_count,
    COUNT(Available_Extra_Rooms_in_Hospital) AS Extra_Rooms_count,
    COUNT(Department) AS Department_count,
    COUNT(Ward_Type) AS Ward_Type_count,
    COUNT(Ward_Facility_Code) AS Ward_Facility_Code_count,
    COUNT(Bed_Grade) AS Bed_Grade_count,
    COUNT(patientid) AS patientid_count,
    COUNT(City_Code_Patient) AS City_Code_Patient_count,
    COUNT(Type_of_Admission) AS Type_of_Admission_count,
    COUNT(Severity_of_Illness) AS Severity_of_Illness_count,
    COUNT(Visitors_with_Patient) AS Visitors_with_Patient_count,
    COUNT(Age) AS Age_count,
    COUNT(Admission_Deposit) AS Admission_Deposit_count,
	COUNT(Stay) AS Stay_count
FROM test_data;


-- Count no of each column value in train_data 

SELECT
    COUNT(case_id) AS case_id_count,
    COUNT(Hospital_code) AS Hospital_code_count,
    COUNT(Hospital_type_code) AS Hospital_type_code_count,
    COUNT(City_Code_Hospital) AS City_Code_Hospital_count,
    COUNT(Hospital_region_code) AS Hospital_region_code_count,
    COUNT(Available_Extra_Rooms_in_Hospital) AS Extra_Rooms_count,
    COUNT(Department) AS Department_count,
    COUNT(Ward_Type) AS Ward_Type_count,
    COUNT(Ward_Facility_Code) AS Ward_Facility_Code_count,
    COUNT(Bed_Grade) AS Bed_Grade_count,
    COUNT(patientid) AS patientid_count,
    COUNT(City_Code_Patient) AS City_Code_Patient_count,
    COUNT(Type_of_Admission) AS Type_of_Admission_count,
    COUNT(Severity_of_Illness) AS Severity_of_Illness_count,
    COUNT(Visitors_with_Patient) AS Visitors_with_Patient_count,
    COUNT(Age) AS Age_count,
    COUNT(Admission_Deposit) AS Admission_Deposit_count,
    COUNT(Stay) AS Stay_count
FROM train_data;




----------------------------------------- DATA MODIFICATION ---------------------------------------------

/* MODIFY test_data */
-- REPLACE NULL VALUE IN bed_grade COLUMN 
UPDATE test_data
SET bed_grade = 'Unknown'
WHERE bed_grade IS NULL;

/* MODIFY train_data */
-- REPLACE VALUE IN age COLUMN 
UPDATE train_data 
SET age = '11-20' 
WHERE age = 'Nov-20';

-- REPLACE VALUE IN stay COLUMN 
UPDATE train_data 
SET stay = '11-20'
WHERE stay = '44136';

-- REPLACE VALUE IN age COLUMN 
UPDATE test_data
SET age = '11-20'
WHERE age = 'Nov-20';

-- CREATE MERGED TABLE all_data
CREATE TABLE healthcare_data AS
SELECT * FROM train_data
UNION ALL
SELECT * FROM test_data;

-- VIEW MERGED DATA
SELECT * FROM healthcare_data;
