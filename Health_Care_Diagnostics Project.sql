-- RETRIEVE DETAILED PATIENT LAB HISTORY

SELECT p.patientid , p.name, d.diagnosisname , o.outcomename, l.testname, l.result, l.normalrange
from patients p
join diagnoses d
on p.diagnosisid = d.diagnosisid
join outcomes o on
p.outcomeID = o.outcomeid
join labs l on
p.patientid = l.patientid
order by p.patientid, l.testname;

-- Average Lab results by diagnosis

SELECT d.diagnosisname , l.testname , avg (l.result) as Avg_Result 
from patients p
join diagnoses d on 
p.diagnosisid = d.diagnosisid
join labs l on 
p.patientid = l.patientid
group by d.diagnosisname, l.testname;

--Abnormal results of patients

SELECT p.patientID, p.name , count(*) as abnormal_count
from patients p
join labs l on 
p.patientid = l.patientid
where (l.testname = 'Blood Sugar' AND l.result >120) or 
(l.testname = 'Cholestrol' and l.result >200) or
(l.testname = 'hemoglobin' and l.result < 13)
group by p.patientid , p.name
order by abnormal_count desc;

-- Diagnosis with highest gtratment cost

SELECT d.diagnosisname, sum(treatmentcost) as Total_cost
from patients p
join diagnoses d on
p.diagnosisid = d.diagnosisid
group by d.diagnosisname order by Total_cost desc;

--patients at risk  by age and gender

SELECT p.name,p.patientid, d.diagnosisname,p.age , p.gender ,o.outcomename
from patients p
join diagnoses d on
p.diagnosisid =d.diagnosisid 
join outcomes o on
p.outcomeid = o.outcomeid
where p.age > 65  and o.outcomename != 'Recovered';

--lab trends over time for a specific patient

SELECT l.testname, l.result, p.admissiondate 
from labs l 
join patients p on
p.patientid = l.patientid
where p.patientid = '10' 
order by p.admissiondate;

--Distribution of Outcomes by Diagnosis

Select d.diagnosisname , o.outcomename, count(o.outcomename) as outcome_count
from patients p
join diagnoses d on 
p.diagnosisid = d.diagnosisID
join Outcomes o on 
p.outcomeid = o.outcomeid
group by d.diagnosisname, o.outcomename
order by d.diagnosisname, o.outcomename;