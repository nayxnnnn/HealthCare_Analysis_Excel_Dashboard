
----------------------------------- ANALYSIS & REPORT -------------------------------------

------ FINDINGS KPI & INSIGHTS ------

SELECT * FROM healthcare_data;

-- 1) TOTAL UNIQUE PATIENTS
CREATE VIEW kpi_total_unique_patients AS
SELECT COUNT(DISTINCT patientid) AS total_unique_patients
FROM healthcare_data;

-- 2) TOTAL CASES RECORDS
CREATE VIEW kpi_total_cases_records AS 
SELECT COUNT(case_id) AS total_cases_records
FROM healthcare_data;

-- 3) AVERAGE LENGTH OF STAYS
CREATE VIEW kpi_avg_stay_days AS
SELECT 
    AVG( (CAST(SPLIT_PART(stay, '-', 1) AS INTEGER) 
        + CAST(SPLIT_PART(stay, '-', 2) AS INTEGER)) / 2.0
    ) AS avg_stay_days
FROM healthcare_data
WHERE stay ~ '^[0-9]+-[0-9]+$';

-- 4) TOTAL ADMISSION DEPOSIT COLLECTS
CREATE VIEW kpi_admission_deposits_collects AS
SELECT SUM(admission_deposit) AS admission_deposit_collects
FROM healthcare_data;

-- 5) AVERAGE ADMISSION DEPOSIT PER PATIENTS
CREATE VIEW kpi_average_admission_deposit_per_patients AS
SELECT AVG(admission_deposit) AS avg_deposit_per_patient
FROM (
    SELECT patientid, AVG(admission_deposit) AS admission_deposit
    FROM healthcare_data
    GROUP BY patientid
) sub;

-- 6) TOP 3 DEPARTMENT BY PATIENT VOLUME
CREATE VIEW kpi_top3_department_by_patient_volume AS
SELECT department, COUNT(*) AS total_patients 
FROM healthcare_data
GROUP BY department
ORDER BY total_patients DESC
LIMIT 3;


-- 7) HOSPITAL WITH MOST PATIENTS
CREATE VIEW kpi_hospital_most_patients AS 
SELECT hospital_code, COUNT(DISTINCT patientid) AS most_patient
FROM healthcare_data
GROUP BY hospital_code
ORDER BY most_patient DESC
LIMIT 1;



------------------------ CHART REQUIREMENTS -----------------------------

-- 1) PATIENT COUNT BY DEPARTMENT
CREATE VIEW chart_patientid_count_department AS
SELECT department, COUNT(DISTINCT patientid) AS patient_count
FROM healthcare_data
GROUP BY department;

-- 2) % OF CASES BY SEVERITY OF ILLNESS
CREATE VIEW chart_severity_illness AS 
SELECT severity_of_illness, ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM healthcare_data), 2) || '%' AS percentage_of_cases
FROM healthcare_data
GROUP BY severity_of_illness;

-- 3) WARD TYPE VS SEVERITY OF ILLNESS
CREATE VIEW ward_type_severity_of_illness AS
SELECT ward_type, severity_of_illness, COUNT(*) AS cases
FROM healthcare_data
GROUP BY ward_type, severity_of_illness;

-- 4) AVERAGE ADMISSION DEPOSIT BY AGE GROUP
CREATE VIEW chart_average_admission_deposit_by_age_group AS 
SELECT age, ROUND(AVG(admission_deposit), 2) AS avg_admission_deposit
FROM healthcare_data
GROUP BY age;

-- 5) AVERAGE AVAILABLE EXTRA ROOMS BY DEPARTMENT
CREATE VIEW chart_average_available_extra_rooms_by_department AS 
SELECT department, ROUND(AVG(available_extra_rooms_in_hospital), 0) AS average_available_extra_rooms
FROM healthcare_data
GROUP BY department;

-- 6) % of occupied beds by grade
CREATE VIEW chart_percentage_of_bed_by_grade AS
SELECT bed_grade,
       ROUND(COUNT(case_id) * 100.0 / (SELECT COUNT(*) FROM healthcare_data),2) || '%' AS utilization_percent
FROM healthcare_data
GROUP BY bed_grade
ORDER BY bed_grade;



