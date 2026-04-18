 --select and clean the table i will use for my analysis
select
    job_title_short,
    split_part(job_location, ',', 1) as Job_location_city,--removes South Africa, where city is specified
    Split_part(Job_via, ' ',2) as Job_via,--removes repetitve 'via' word
    job_schedule_type,
    job_work_from_home,
    Job_posted_date,
    CASE
    when Extract(month from Job_posted_date) = 1 then 'January'
    when Extract(month from Job_posted_date) = 2 then 'February'
    when Extract(month from Job_posted_date) = 3 then 'March'
    when Extract(month from Job_posted_date) = 4 then 'April'
    when Extract(month from Job_posted_date) = 5 then 'May'
    when Extract(month from Job_posted_date) = 6 then 'June'
    when Extract(month from Job_posted_date) = 7 then 'July'
    when Extract(month from Job_posted_date) = 8 then 'August'
    when Extract(month from Job_posted_date) = 9 then 'September'
    when Extract(month from Job_posted_date) = 10 then 'October'
    when Extract(month from Job_posted_date) = 11 then 'November'
    when Extract(month from Job_posted_date) = 12 then 'December'
    else 'unknown' --which will help identify data quality issues
    end as Month_name,
    job_no_degree_mention
from job_postings_fact
where job_country = 'South Africa'
       and Extract( year from job_posted_date) = 2023 --Used to filter 2022 data, which only shows data collected in one day(2022 december 31)
       and split_part(job_location, ',', 1)  <> 'South Africa' 
       and job_schedule_type is not null;


    select
    job_id,
    job_title_short,
    split_part(job_location, ',', 1) as Job_location_city,--removes South Africa, where city is specified
    Split_part(Job_via, ' ',2) as Job_via,--removes repetitve 'via' word
    Trim(schedule) as Job_schedule_type,
    job_work_from_home,
    Job_posted_date,
    CASE
    when Extract(month from Job_posted_date) = 1 then 'January'
    when Extract(month from Job_posted_date) = 2 then 'February'
    when Extract(month from Job_posted_date) = 3 then 'March'
    when Extract(month from Job_posted_date) = 4 then 'April'
    when Extract(month from Job_posted_date) = 5 then 'May'
    when Extract(month from Job_posted_date) = 6 then 'June'
    when Extract(month from Job_posted_date) = 7 then 'July'
    when Extract(month from Job_posted_date) = 8 then 'August'
    when Extract(month from Job_posted_date) = 9 then 'September'
    when Extract(month from Job_posted_date) = 10 then 'October'
    when Extract(month from Job_posted_date) = 11 then 'November'
    when Extract(month from Job_posted_date) = 12 then 'December'
    else 'unknown' --which will help identify data quality issues
    end as Month_name,
    job_no_degree_mention
from job_postings_fact,
Lateral unnest(string_to_array(regexp_replace(job_schedule_type, '\s+and\s+', ',','gi'), ',')) as schedule
where job_country = 'South Africa'
       and Extract( year from job_posted_date) = 2023 --Used to filter 2022 data, which only shows data collected in one day(2022 december 31)
       and split_part(job_location, ',', 1)  <> 'South Africa' 
       and job_schedule_type is not null;