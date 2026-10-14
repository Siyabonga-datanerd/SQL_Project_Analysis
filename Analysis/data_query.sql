--get data and join different tables using inner join

CREATE TABLE job_postings_final AS
SELECT
jpc.job_id,
jpc.company_id,
job_title_short,
job_location,
job_via,
job_schedule_type,
job_work_from_home,
job_posted_date,
job_no_degree_mention,
job_health_insurance,
job_country,
salary_rate,
salary_year_avg,
salary_hour_avg,
month_num,
month_name,
salary_adj,
name
FROM job_postings_cleaned AS jpc
INNER JOIN company_dim_cleaned AS cdc ON jpc.company_id= cdc.company_id;

CREATE TABLE job_skills_final AS
SELECT
job_id,
skills as skill
FROM skills_job_dim AS sjd
INNER JOIN skills_dim AS sd ON sjd.skill_id=sd.skill_id;

CREATE TABLE schedule_type_final AS
SELECT*
FROM schedule_type_dim;








