# 🏥 Hospital Operational Performance Review | Healthcare Data Analytics

**Turning Hospital Admission Data into Actionable Healthcare Insights Using PostgreSQL and Power BI**

![Healthcare Analytics](https://img.shields.io/badge/Domain-Healthcare%20Analytics-087E8B)
![SQL](https://img.shields.io/badge/Database-PostgreSQL-336791)
![Power BI](https://img.shields.io/badge/Visualization-Power%20BI-F2C811)
![Status](https://img.shields.io/badge/Project-Completed-success)

## 📌 Project Overview

Hospital operational efficiency and quality of healthcare delivery depend on the ability to transform routine clinical and administrative data into meaningful information for decision-making.

This project involved an operational performance review of **Zion Valley Specialist Hospital**, using hospital admission data to evaluate patient demographics, clinical outcomes, disease burden, discharge against medical advice (DAMA), physician workload and lifestyle-related risk factors.

PostgreSQL was used for data exploration, cleaning, transformation and analytical querying, while Power BI was used to develop an interactive dashboard for monitoring hospital performance.

The project demonstrates how healthcare data analytics can support evidence-based decision-making, improve resource allocation and identify opportunities for clinical quality improvement.

## 🎯 Project Objectives

The analysis was designed to answer the following business and clinical questions:

1. What is the overall hospital admission and mortality profile?
2. What proportion of admitted patients died or were discharged against medical advice?
3. Which chronic diseases contribute most to the hospital's disease burden?
4. Which disease categories have the highest mortality and DAMA rates?
5. How are lifestyle risk factors associated with patient outcomes?
6. Which medical specialisations experience the highest patient workload?
7. What operational interventions should management prioritise?

## 🛠️ Tools and Technologies

| Tool | Application |
|---|---|
| PostgreSQL | Data exploration, cleaning, transformation and SQL analysis |
| Power BI | Interactive dashboard development |
| DAX | Healthcare KPI calculations and analytical measures |
| Power Query | Data transformation and preparation |
| Excel | Preliminary data inspection and validation |

## 🗂️ Dataset Description

The dataset contains hospital admission records with information covering:

- Patient demographics: age, gender, education, marital status and occupation.
- Admission details and patient identifiers.
- Clinical conditions and disease categories.
- Patient outcomes, including death and discharge against medical advice.
- Doctors' specialisations and admission workload.
- Lifestyle risk factors, including alcohol history, tobacco history and NSAID use.

## ⚙️ Project Workflow

The project followed a structured healthcare analytics workflow.

### 1. Data Exploration and Quality Assessment

Initial data profiling was performed in PostgreSQL to understand the dataset structure and assess data quality.

Activities included:
- Examining table structures and data types.
- Identifying missing values.
- Investigating duplicate admission identifiers.
- Assessing categorical variables.
- Checking the consistency of patient outcome records.

### 2. Data Cleaning and Transformation

Data preparation was undertaken to improve analytical consistency.

Key activities included:
- Reviewing missing demographic and clinical values.
- Standardising categorical variables.
- Creating analytical age groups.
- Categorising chronic disease indicators.
- Classifying lifestyle risk factors.
- Preparing data for hospital performance analysis.

### 3. SQL Analysis

PostgreSQL queries were developed to investigate hospital operations and clinical outcomes.

The analysis covered:
- Admission trends and demographic distribution.
- Mortality and DAMA patterns.
- Chronic disease prevalence.
- Disease-specific outcomes.
- Physician workload by specialisation.
- Associations between lifestyle risk factors and patient outcomes.
- Views were created and imported into Power BI

### 4. Power BI Dashboard Development

The cleaned and analysed data were integrated into Power BI.

DAX measures were developed to calculate key performance indicators, while interactive visualisations were used to communicate findings to hospital management.

## 📊 Key Performance Indicators

The dashboard incorporated the following healthcare performance indicators:

| KPI | Description |
|---|---|
| Total Admissions | Total number of hospital admission records |
| Total Unique Patients | Number of distinct patients |
| Total Deaths | Number of recorded inpatient deaths |
| Mortality Rate | Deaths as a proportion of admissions |
| Total DAMA | Number of patients discharged against medical advice |
| DAMA Rate | DAMA cases as a proportion of admissions |
| Chronic Disease Prevalence | Admissions involving at least one chronic disease |
| Disease-Specific Mortality | Mortality rate across individual disease categories |
| Physician Workload | Average admissions managed per doctor |
| Risk-Factor Distribution | Distribution of patients according to identified lifestyle risk factors |

## 🔍 Key Findings and Insights

The analysis produced three major operational findings.

### 1. Significant Mortality and Chronic Disease Burden

- Approximately 1,478 admissions were recorded.
- A total of 290 deaths were documented.
- Overall mortality was approximately 20%.
- Chronic disease prevalence was 49.12%.

Disease-specific mortality rates were:

| Disease | Mortality Rate |
|---|---:|
| Cancer | 66.67% |
| Diabetes Mellitus | 40.63% |
| CKD | 22.84% |
| Stroke | 22.22% |
| PUD | 13.40% |

**Insight:** Cancer and Diabetes recorded the highest mortality rates, highlighting the need for stronger disease-specific management, early diagnosis and closer monitoring of high-risk patients.

### 2. High Discharge Against Medical Advice (DAMA)

- Total DAMA cases: 276.
- Overall DAMA rate: 18.67%.

DAMA rates by disease category:

| Disease Category | DAMA Rate |
|---|---:|
| Acute Disease | 20.48% |
| Chronic Disease | 16.80% |

**Insight:** DAMA was higher among patients admitted with acute diseases. Further investigation into treatment costs, waiting times, patient counselling and communication gaps is warranted.

### 3. Uneven Physician Workload and Risk-Factor Outcomes

Emergency Medicine recorded the highest average physician workload.

- Admissions managed: 384.
- Number of doctors: 2.
- Average workload: 192 admissions per doctor.

The risk-factor analysis revealed:

| Patient Category | Mortality Rate | DAMA Rate |
|---|---:|---:|
| Without identified risk factors | 20.60% | 18.21% |
| With identified risk factors | 16.43% | 20.17% |

**Insight:** The observed differences suggest that lifestyle risk factors may have complex relationships with hospital outcomes. Further investigation is necessary before drawing causal conclusions.

## 📈 Dashboard Preview

The interactive Power BI dashboard provides a consolidated view of hospital performance, patient outcomes, chronic disease burden, physician workload and risk-factor patterns.

**Dashboard screenshot:**
`![Hospital Operational Performance Dashboard](https://github.com/Dandyson24/Hospital-performance-analysis/blob/main/Real%20Faith%20Hospital%20dashboard.png))`

## 💡 Recommendations to Management

Based on the analytical findings, the following interventions are proposed:

1. **Strengthen clinical management:** Prioritise early diagnosis, clinical monitoring and treatment optimisation for patients with Cancer and Diabetes.
2. **Reduce DAMA:** Investigate the underlying reasons for premature discharge and strengthen patient counselling, communication and financial guidance.
3. **Optimise physician workload:** Review staffing adequacy and patient flow, particularly in Emergency Medicine.
4. **Improve chronic disease surveillance:** Establish routine monitoring of disease-specific prevalence, multiple chronic conditions and clinical outcomes.
5. **Institutionalise performance monitoring:** Introduce monthly dashboard-based operational reviews to monitor indicators and evaluate improvement interventions.

## ⚠️ Data Limitations

The following limitations were identified:

- Some demographic and clinical variables contained missing values.
- Multiple admissions by the same patient may affect admission-level and patient-level prevalence estimates.
- Disease-specific mortality percentages should be interpreted alongside the number of affected patients.
- The observational dataset does not establish causal relationships between risk factors and patient outcomes.

## 🎓 Skills Demonstrated

This project demonstrates practical application of:

**Healthcare Analytics**
- Hospital operational performance monitoring.
- Clinical outcome analysis.
- Chronic disease epidemiology.
- Mortality and DAMA analysis.
- Healthcare KPI development.

**Technical Skills**
- PostgreSQL and SQL querying.
- Data cleaning and transformation.
- Data modelling.
- Power BI dashboard development.
- DAX calculations.
- Data visualisation and storytelling.
- Evidence-based management reporting.

## 🚀 Project Impact

This project demonstrates how routine hospital admission data can be transformed into actionable operational intelligence.

The dashboard provides a framework for identifying clinical performance gaps, monitoring patient outcomes, assessing disease burden and supporting resource allocation decisions.

It also demonstrates the value of combining clinical and public health knowledge with data analytics to address practical healthcare management challenges.

## 👨‍💻 About the Analyst

A Medical Doctor and Public Health Practitioner transitioning into Healthcare Data Analytics, with professional experience in clinical care, public health programme implementation, monitoring and evaluation, and healthcare data management.

Interested in applying SQL, Power BI, Python and data analytics to improve healthcare delivery, strengthen health systems and support evidence-based decision-making.

**Areas of Interest:**
- Healthcare Data Analytics
- Public Health Informatics
- Health Systems Strengthening
- Clinical and Operational Intelligence
- Disease Surveillance and Epidemiology
- Artificial Intelligence in Healthcare

## 📬 Connect

I welcome opportunities to collaborate on healthcare analytics, public health informatics and data-driven health systems improvement.

**LinkedIn:** [https://www.linkedin.com/in/andrew-nwachimereze-o-6b429617/]

**GitHub:** [(https://github.com/Dandyson24)]

---

*Disclaimer: This project is an analytical case study. Findings are based on the available dataset and should not be interpreted as causal evidence or a substitute for clinical audit and validation.*
