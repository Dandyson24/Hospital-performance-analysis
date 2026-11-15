/*** SQL CAPSTONE PROJECT
 * 
 * Objective:
You are a data analyst employed by Faith Specialist Hospital. 
Your task is to analyze the hospital’s patient data to uncover insights that can help the management address
 their challenges. Specifically, your objectives are:
1.Analyze patient demographics in relation to hospital outcomes.
2.Identify common reasons for discharge against medical advice (DAMA) 
3.Examine the prevalence and impact of chronic illnesses among patients.
4. Assess the impact of lifestyle factors on hospital outcomes.
5. Evaluate the performance of the doctors based on specialization, and workload.
6. Provide data-driven insights that can help improve hospital management and patient care in written format and create a tableau dashboard to showcase your insights
**/

/** Standardizing the column headers to improve readability and reduce the use of "" when refering to columns)**/
--admission details table
ALTER TABLE admission_details  RENAME COLUMN "Pt id" TO pt_id;
ALTER TABLE admission_details  RENAME COLUMN "Admission id" TO admission_id;
ALTER TABLE admission_details  RENAME COLUMN "Admission duration" TO admission_duration;
ALTER TABLE admission_details  RENAME COLUMN "Doctor Id" TO doctor_id;
ALTER TABLE admission_details  RENAME COLUMN "Reason For Dama" TO reason_for_DAMA;
ALTER TABLE admission_details  RENAME COLUMN "Cause Of Death" TO cause_of_death;
ALTER TABLE admission_details  RENAME COLUMN "Cause CKD" TO cause_of_CKD;
ALTER TABLE admission_details  RENAME COLUMN "No of Sessions" TO no_of_dialysis_sessions;
ALTER TABLE admission_details  RENAME COLUMN "Type Of Cancer" TO type_of_cancer;

--Standardizing patient details table
ALTER TABLE patient_details   RENAME COLUMN "Pt id" TO pt_id;
ALTER TABLE patient_details   RENAME COLUMN "Level Of Education" TO level_of_education;
ALTER TABLE patient_details   RENAME COLUMN "Marital Status" TO marital_status;

--Standardizing risk factor table
ALTER TABLE risk_factor   RENAME COLUMN "Pt id" TO pt_id;
ALTER TABLE risk_factor   RENAME COLUMN "Alcohol Hx" TO alcohol_history;
ALTER TABLE risk_factor   RENAME COLUMN "Tobacco Hx" TO tobacco_history;
ALTER TABLE risk_factor   RENAME COLUMN "NSAID Use" TO NSAID_use;

--Standardizing doctors table
ALTER TABLE "Capstone".doctors RENAME COLUMN "Doctor_id" TO doctor_id;
ALTER TABLE "Capstone".doctors RENAME COLUMN "Doctor" TO doctor;
ALTER TABLE "Capstone".doctors RENAME COLUMN "Gender" TO gender;
ALTER TABLE "Capstone".doctors RENAME COLUMN "Email" TO email;
ALTER TABLE "Capstone".doctors RENAME COLUMN "Specialization" TO specialization;


---DATA EXPLORATION---

/** MISSING DATA **/
--admission details table
SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE pt_id IS NULL) AS missing_patientid,
    COUNT(*) FILTER (WHERE admission_id IS NULL) AS missing_admission_id,
    COUNT(*) FILTER (WHERE admission_duration IS NULL) AS missing_admission_duration,
    COUNT(*) FILTER (WHERE doctor_id IS NULL) AS missing_doctor_id
FROM admission_details;
--There are 1478 records and no missing data in the fields examined

-- Examining doctors table for missing values
SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE Doctor IS NULL) AS missing_doctor_name,
    COUNT(*) FILTER (WHERE Gender IS NULL) AS missing_gender,
    COUNT(*) FILTER (WHERE Email IS NULL) AS missing_Email,
    COUNT(*) FILTER (WHERE Specialization IS NULL) AS missing_Specialization,
    COUNT(*) FILTER (WHERE Doctor_id IS NULL) AS missing_doctor_id
FROM doctors;

--There are 39 records and no missing data in the fields examined


--Examining patient details table for missing values

SELECT
    COUNT(*) AS total_records,
	COUNT(*) FILTER (WHERE pt_id IS NULL) AS missing_patientid,
	COUNT(*) FILTER (WHERE name IS NULL OR TRIM(name) = '') AS missing_name,
	COUNT(*) FILTER (WHERE age IS NULL OR TRIM(age::TEXT) = '' ) AS missing_age,
	COUNT(*) FILTER (WHERE Sex IS NULL OR TRIM(Sex) = '') AS missing_sex,
	COUNT(*) FILTER (WHERE Occupation IS NULL OR TRIM(Occupation) = '') AS missing_occupation,
	COUNT(*) FILTER (WHERE level_of_education IS NULL OR TRIM(level_of_education) = '') AS missing_education,
	COUNT(*) FILTER (WHERE marital_status IS NULL OR TRIM(marital_status) = '') AS missing_marital_status
FROM patient_details;
--There are 1478 records and 936 missing education, 16 marital status  and 5 missing age. These posed limitation to the analysis

--risk factor table
SELECT
COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE pt_id IS NULL) AS missing_patientid,
    COUNT(*) FILTER (WHERE alcohol_history IS NULL) AS missing_alcohol_history,
    COUNT(*) FILTER (WHERE tobacco_history IS NULL) AS missing_tobacco_history,
    COUNT(*) FILTER (WHERE nsaid_use IS NULL) AS missing_nsaid_use
FROM risk_factor;

    
    /*EXAMINING DATA FOR DUPLICATES**/ 

 SELECT
    ad.admission_id,
    COUNT(*) AS duplicate_count
FROM admission_details ad 
GROUP BY ad.admission_id 
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

--There are no duplicates in the admission details table

--Examining duplicates on the doctors table 
SELECT
    doctor_id,
    COUNT(*) AS duplicate_doctor_count
FROM doctors  
GROUP BY doctor_id
HAVING COUNT(*) > 1
ORDER BY duplicate_doctor_count DESC;
--There are no duplicates in the doctors' table

--Examining patients details table--
SELECT
    pt_id,
    COUNT(*) AS duplicate_patient_count
FROM patient_details  
GROUP BY pt_id
HAVING COUNT(*) > 1
ORDER BY duplicate_patient_count DESC;

/** The data is clean so the next step is to start solving the problems.
 * 
 * DATA PREPARATION
 * CREATING AGE CATEGORIES**/
 SELECT
    CASE
        WHEN pd.age BETWEEN 0 AND 10 THEN 'Child'
        WHEN pd.age BETWEEN 11 AND 18 THEN 'Adolescent'
        WHEN pd.age BETWEEN 19 AND 24 THEN 'Young Person'
        WHEN pd.age BETWEEN 25 AND 45 THEN 'Young Adult'
        WHEN pd.age BETWEEN 46 AND 60 THEN 'Middle Age'
        WHEN pd.age > 60 THEN 'Elderly'
        ELSE 'Unknown'
    END AS age_group
FROM patient_details AS pd;

--Adding age categories to the patient's detail column
ALTER TABLE patient_details
ADD COLUMN age_group VARCHAR(30);

UPDATE patient_details
SET age_group =
    CASE
        WHEN age BETWEEN 0 AND 10 THEN 'Child'
        WHEN age BETWEEN 11 AND 18 THEN 'Adolescent'
        WHEN age BETWEEN 19 AND 24 THEN 'Young Person'
        WHEN age BETWEEN 25 AND 45 THEN 'Young Adult'
        WHEN age BETWEEN 46 AND 60 THEN 'Middle Age'
        WHEN age > 60 THEN 'Elderly'
        ELSE 'Unknown'
    END;

--Confirming the newly created age group.
SELECT
    age_group,
    COUNT(*) AS total_patients,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM patient_details
GROUP BY age_group
ORDER BY total_patients DESC;
--There were more elderly people (35%).
 
 --Objective 1.Analyze patient demographics in relation to hospital outcomes.
--Demographics: Age, sex, occupation, level of education and marital status
-- Outcomes: DAMA, dead **/

--DAMA RATE BY age group
CREATE VIEW vw_demographic_effects__on_DAMA AS
SELECT
    pd.age_group,
    COUNT(*) AS total_admissions,
    COUNT(*) FILTER (
        WHERE ad."DAMA" = 'Yes'
    ) AS total_dama,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE ad."DAMA" = 'Yes'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS dama_rate
FROM admission_details ad
JOIN patient_details pd
    ON ad.pt_id = pd.pt_id
GROUP BY pd.age_group
ORDER BY dama_rate DESC;
--The blank age group had the highest dama rate. This needs further evaluation to data engineering team to supply the data if available.


---Bringing ALL the demographics together using cross join for DAMA analysis

------------------------------------------------------------------------------------------------------
CREATE VIEW vw_demographics_influence__on_DAMA AS
WITH dama_data AS (
    SELECT
        pd.age_group,
        pd.sex,
        pd.level_of_education,
        pd.marital_status,
        pd.occupation,
        CASE
            WHEN ad."DAMA" = 'Yes'
            THEN 1
            ELSE 0
        END AS dama_flag
    FROM admission_details ad
    JOIN patient_details pd
        ON ad.pt_id = pd.pt_id
)
SELECT
    d.demographic_variable,
    d.demographic_category,
    COUNT(*) AS total_admissions,
    SUM(dd.dama_flag) AS total_dama,
    ROUND(
        100.0 * SUM(dd.dama_flag)
        / NULLIF(COUNT(*), 0),
        2
    ) AS dama_rate
FROM dama_data dd
CROSS JOIN LATERAL (
    VALUES
        ('Age Group', dd.age_group),
        ('Sex', dd.sex),
        ('Education', dd.level_of_education),
        ('Marital Status', dd.marital_status),
        ('Occupation', dd.occupation)
) AS d(demographic_variable, demographic_category)
GROUP BY
    d.demographic_variable,
    d.demographic_category
ORDER BY
    d.demographic_variable,
    dama_rate DESC;

-- For mortality analysis
CREATE VIEW vw_demographics_influence__on_mortality AS
WITH mortality_data AS (
    SELECT
        pd.age_group,
        pd.sex,
        pd.level_of_education,
        pd.marital_status,
        pd.occupation,
        CASE
            WHEN ad."dead" ='Yes'
            THEN 1
            ELSE 0
        END AS mortality_flag
    FROM admission_details ad
    JOIN patient_details pd
        ON ad.pt_id = pd.pt_id
)
SELECT
    md.mortality_demographic_variable,
    md.mortality_demographic_category,
    COUNT(*) AS total_admissions,
    SUM(mdd.mortality_flag) AS total_mortality,
    ROUND(
        100.0 * SUM(mdd.mortality_flag)
        / NULLIF(COUNT(*), 0),
        2
    ) AS mortality_rate
FROM mortality_data mdd
CROSS JOIN LATERAL (
    VALUES
        ('Age Group', mdd.age_group),
        ('Sex', mdd.sex),
        ('Education', mdd.level_of_education),
        ('Marital Status', mdd.marital_status),
        ('Occupation', mdd.occupation)
) AS md(mortality_demographic_variable, mortality_demographic_category)
GROUP BY
    md.mortality_demographic_variable,
    md.mortality_demographic_category
ORDER BY
    md.mortality_demographic_variable,
    mortality_rate DESC;

--2.Identify common reasons for discharge against medical advice (DAMA) 
SELECT
	ad."reason_for_DAMA",
	COUNT(*) AS count_of_DAMA
FROM admission_details ad 
WHERE ad."DAMA"   = 'Yes'
GROUP BY ad."DAMA",
	ad."reason_for_DAMA"
ORDER BY count_of_DAMA DESC;

--This shows financial constraint and financial incapability which are closely related. Inorder to bring them together.
UPDATE admission_details
SET "reason_for_DAMA" = 'Financial Constraint'
WHERE "reason_for_DAMA" = 'Financial Incapability';
--
CREATE VIEW vw_reason_for_DAMA AS
SELECT
    ad."reason_for_DAMA",
    COUNT(*) AS count_of_DAMA,
    ROUND(
        100.0 * COUNT(*) /
        NULLIF(
            (SELECT COUNT(*)
             FROM admission_details
             WHERE "DAMA" = 'Yes'),
            0
        ),
        2
    ) AS dama_rate
FROM admission_details ad
WHERE ad."DAMA" = 'Yes'
GROUP BY
    ad."reason_for_DAMA"
ORDER BY
    count_of_DAMA DESC;

--Financial constraint was responsible for discharge against medical advise in 88% of the patients, followed by no improvement(7%) and Doctor's strike(5%)

/** 3.Examine the prevalence and impact of chronic illnesses among patients.
 * We can only determine the effect on mortality by chronic illnesses**/

--Prevalence of individual diseases.
CREATE VIEW vw_prevalence_of_individual_illnesses AS
WITH illness_data AS (
    SELECT
        ad."admission_id",
        v.chronic_illness,
        v.status
    FROM admission_details ad
    CROSS JOIN LATERAL (
        VALUES
            ('CKD', ad."CKD"),
            ('Stroke', ad."Stroke"),
            ('Diabetes Mellitus', ad."DM"),
            ('Cancer', ad."Cancer"),
            ('Peptic Ulcer Disease', ad."PUD")
    ) v(chronic_illness, status)
),
summary AS (
    SELECT
        chronic_illness,
        COUNT(DISTINCT admission_id) FILTER (
            WHERE status = 'Yes'
        ) AS affected_patients,
        COUNT(*) OVER (
            PARTITION BY chronic_illness
        ) AS total_admissions
    FROM illness_data
    GROUP BY chronic_illness, status, admission_id
)
SELECT
    chronic_illness,
    SUM(affected_patients) AS affected_patients,
    MAX(total_admissions) AS total_admissions,
    ROUND(100.0 * SUM(affected_patients) /
        NULLIF(MAX(total_admissions), 0), 2) AS prevalence_rate
FROM summary
GROUP BY chronic_illness
ORDER BY prevalence_rate DESC;

--Among the chronic disease, stroke had the highest prevalence while cancers had the least.
----------------------------------------------------------------------------------------------------------------

--Collective effect of diseases
CREATE VIEW vw_prevalence_of_chronic_illnesses AS
WITH chronic_burden AS (
    SELECT
        "pt_id",
        (
            CASE WHEN "CKD" = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN "Stroke" = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN "DM" = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN "Cancer" = 'Yes' THEN 1 ELSE 0 END +
            CASE WHEN "PUD" = 'Yes' THEN 1 ELSE 0 END
        ) AS chronic_illness_count
    FROM admission_details
)
SELECT
    CASE
        WHEN chronic_illness_count = 0
            THEN 'No Chronic Illness'
        WHEN chronic_illness_count = 1
            THEN 'One Chronic Illness'
        ELSE 'Multiple Chronic Illnesses'
    END AS illness_group,
    COUNT(*) AS total_patients,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (), 2
    ) AS percentage
FROM chronic_burden
GROUP BY 1
ORDER BY total_patients DESC;
--More people are without chronic illness.

--Impact of chronic illnesses on hospital outcomes
CREATE VIEW vw_chronic_illnesses__influence_on_outcomes AS
WITH disease_data AS (
    SELECT
        ad."pt_id",
        ad."admission_duration",
        ad."DAMA",
        ad."dead",
        disease.chronic_illness
    FROM admission_details ad
    CROSS JOIN LATERAL (
        VALUES
            ('CKD', ad."CKD"),
            ('Stroke', ad."Stroke"),
            ('Diabetes', ad."DM"),
            ('Cancer', ad."Cancer"),
            ('PUD', ad."PUD")
    ) AS disease(chronic_illness, disease_status)
    WHERE disease.disease_status ='Yes'
)
SELECT
    chronic_illness,
    COUNT(*) AS total_admissions,
    ROUND(
        AVG("admission_duration"), 2
    ) AS average_length_of_stay,
    COUNT(*) FILTER (
        WHERE "DAMA" ='Yes'
    ) AS total_DAMA,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "DAMA" ='Yes'
        ) / NULLIF(COUNT(*), 0), 2
    ) AS DAMA_rate,
    COUNT(*) FILTER (
        WHERE "dead" = 'Yes'
    ) AS total_deaths,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE "dead" = 'Yes'
        ) / NULLIF(COUNT(*), 0), 2
    ) AS mortality_rate
FROM disease_data
GROUP BY chronic_illness
ORDER BY mortality_rate DESC;

	
/**4. Assess the impact of lifestyle factors on hospital outcomes.**/
CREATE VIEW vw_risk_factor_influence_on_mortality AS 
WITH lifestyle_data AS (
    SELECT
        ad."admission_id",
        ad."dead",
        'Alcohol History' AS lifestyle_factor
    FROM admission_details ad
    JOIN risk_factor rf
        ON ad."pt_id" = rf.pt_id
    WHERE rf.alcohol_history ='Yes'
    UNION ALL
    SELECT
        ad."admission_id",
        ad."dead",
        'Tobacco History'
    FROM admission_details ad
    JOIN risk_factor rf
        ON ad."pt_id" = rf.pt_id
    WHERE rf.tobacco_history='Yes'
    UNION ALL
    SELECT
        ad."admission_id",
        ad."dead",
        'NSAID Use'
    FROM admission_details ad
    JOIN risk_factor rf
        ON ad."pt_id" = rf.pt_id
    WHERE rf.nsaid_use='Yes'
)
SELECT
    lifestyle_factor,
    COUNT(DISTINCT admission_id) AS total_admissions,
    COUNT(DISTINCT admission_id) FILTER (
        WHERE dead ='Yes'
    ) AS total_deaths,
    ROUND(
        100.0 *
        COUNT(DISTINCT admission_id) FILTER (
            WHERE dead='Yes'
        ) /
        NULLIF(COUNT(DISTINCT admission_id), 0),
        2
    ) AS mortality_rate
FROM lifestyle_data
GROUP BY lifestyle_factor
ORDER BY mortality_rate DESC;
--NSAID use was associated with the highest mortality, followed closely by tobacco history and alcohol history 
----------------------------------------------------------------------------------------------------------------------

-- Assessing effect of lifestyle factors on DAMA
--Shows that alcohol history had the highest DAMA rate followed closely by NSAID use and finally tobacco history.
CREATE VIEW vw_risk_factor_influence_on_DAMA AS
WITH dama_lifestyle_data AS (
    SELECT
        ad."admission_id",
        ad."DAMA",
        'Alcohol History' AS dama_lifestyle_factor
    FROM admission_details ad
    JOIN risk_factor rf
        ON ad."pt_id" = rf.pt_id
    WHERE rf.alcohol_history = 'Yes'
    UNION ALL
    SELECT
        ad."admission_id",
        ad."DAMA",
        'Tobacco History'
    FROM admission_details ad
    JOIN risk_factor rf
        ON ad."pt_id" = rf.pt_id
    WHERE rf.tobacco_history ='Yes'
    UNION ALL
    SELECT
        ad."admission_id",
        ad."DAMA",
        'NSAID Use'
    FROM admission_details ad
   JOIN risk_factor rf
        ON ad."pt_id" = rf.pt_id
    WHERE rf.nsaid_use ='Yes'
)
SELECT
    dama_lifestyle_factor,
    COUNT(DISTINCT admission_id) AS total_admissions,
    COUNT(DISTINCT admission_id) FILTER (
        WHERE "DAMA" ='Yes'
    ) AS total_dama,
    ROUND(
        100.0 *
        COUNT(DISTINCT admission_id) FILTER (
            WHERE "DAMA" ='Yes'
        ) /
        NULLIF(COUNT(DISTINCT admission_id), 0),
        2
    ) AS dama_rate
FROM dama_lifestyle_data
GROUP BY dama_lifestyle_factor
ORDER BY dama_rate DESC;
--5. Evaluate the performance of the doctors based on specialization, and workload.
CREATE VIEW vw_average_work_load_per_specialization AS
SELECT
    d.specialization,
    COUNT(DISTINCT d.doctor_id) AS total_doctors,
    COUNT(DISTINCT ad.admission_id) AS total_admissions,
    ROUND(
        COUNT(DISTINCT ad.admission_id) /
        NULLIF(COUNT(DISTINCT d.doctor_id), 0),
        2
    ) AS average_workload_per_doctor
FROM doctors d
LEFT JOIN admission_details ad
    ON ad.doctor_id = d.doctor_id
GROUP BY
    d.specialization
ORDER BY average_workload_per_doctor DESC;

--Emergency department had the highest average workload per doctor

--6. Provide data-driven insights that can help improve hospital management and patient care in written format and create a tableau dashboard to showcase your insights
**/
/** 1. Strengthen clinical quality improvement and early intervention programmes, given the observed 20% mortality rate among admissions.

2. Prioritise chronic disease management, particularly cancer and diabetes, which recorded the highest mortality rates.
3. Review emergency department staffing and resource allocation, as Emergency Medicine recorded the highest average workload (192 admissions per doctor).
4. Investigate the high DAMA rate of 18.67%, particularly among patients with acute diseases, and address contributing factors such as cost, patient dissatisfaction and treatment delays.
5. Introduce targeted patient counselling, improved follow-up and risk-factor screening to reduce preventable deaths, premature discharges and complications especially for diabetes which is the main cause of CKDs in the cohort.