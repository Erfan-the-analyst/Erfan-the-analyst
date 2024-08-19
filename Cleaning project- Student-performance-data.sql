SELECT *
 FROM portfolio.student_data;
 
 select gender,
 case 
 when gender = 0 then 'Male'
 when gender = 1 then 'Female'
 end
 from student_data;
 
 alter table student_data
add Gender_new nvarchar(255);

update student_data
set Gender_new = case 
 when gender = 0 then 'Male'
 when gender = 1 then 'Female'
 end;

 select*
 from student_data;
 ---------------------------------------
 select ethnicity,
 case
 when Ethnicity = 0 then 'Caucasian'
 when Ethnicity = 1 then 'African American'
 when Ethnicity = 2 then  'Asian'
 when Ethnicity = 3 then 'Other'
 end
 from student_data;
 
  alter table student_data
add ethnicity_new nvarchar(255);

update student_data
set ethnicity_new = case
 when Ethnicity = 0 then 'Caucasian'
 when Ethnicity = 1 then 'African American'
 when Ethnicity = 2 then  'Asian'
 when Ethnicity = 3 then 'Other'
 end;
 
  select*
 from student_data;
 --------------------------------------------
 
 select ParentalEducation,
 case 
 when ParentalEducation= 0 then 'None'
when ParentalEducation= 1 then 'High School'
when ParentalEducation= 2 then  'Some College'
when ParentalEducation= 3 then 'Bachelor'
when ParentalEducation= 4 then 'Higher'
end
 from student_data;
 
  alter table student_data
add ParentalEducation_new nvarchar(255);

update student_data 
set ParentalEducation_new = case 
 when ParentalEducation= 0 then 'None'
when ParentalEducation= 1 then 'High School'
when ParentalEducation= 2 then  'Some College'
when ParentalEducation= 3 then 'Bachelor'
when ParentalEducation= 4 then 'Higher'
end;

 select*
 from student_data;
 
 -------------------------------------------------
  select absences,
case 
 when Absences = 0 then 'None'
 when Absences between 1 and 10 then 'low'
 when Absences between 10 and 20 then 'meduim'
 when Absences between 20 and 30 then 'many'
 end
  from student_data;
  
  alter table student_data
add Absences_new nvarchar(255);

update student_data 
set Absences_new = case 
 when Absences = 0 then 'None'
 when Absences between 1 and 10 then 'low'
 when Absences between 10 and 20 then 'meduim'
 when Absences between 20 and 30 then 'many'
end;

select*
 from student_data;
 ------------------------------------------------------
 select Tutoring,
case 
 when Tutoring = 0 then 'No'
 when Tutoring = 1 then 'Yes'
 end
  from student_data;
  
  alter table student_data
add Tutoring_new nvarchar(255);

update student_data 
set Tutoring_new = case 
when Tutoring = 0 then 'No'
 when Tutoring = 1 then 'Yes'
end;

select*
 from student_data;
 --------------------------------------------
 select ParentalSupport,
case 
 when ParentalSupport = 0 then 'None'
 when ParentalSupport = 1  then 'low'
 when ParentalSupport = 2 then 'Maderate'
 when ParentalSupport = 3 then 'High'
 when ParentalSupport = 4 then 'very High'
 end
  from student_data;

alter table student_data
add ParentalSupport_new nvarchar(255);

update student_data 
set ParentalSupport_new = case 
 when ParentalSupport = 0 then 'None'
 when ParentalSupport = 1  then 'low'
 when ParentalSupport = 2 then 'Maderate'
 when ParentalSupport = 3 then 'High'
 when ParentalSupport = 4 then 'very High'
end;
  
 select*
 from student_data;
 ---------------------------------------------------
 select Extracurricular,
case 
 when Extracurricular = 0 then 'No'
 when Extracurricular = 1 then 'Yes'
 end
  from student_data;

alter table student_data
add Extracurricular_new nvarchar(255);

update student_data 
set Extracurricular_new = case 
 when Extracurricular = 0 then 'No'
 when Extracurricular = 1  then 'Yes'
end;

select*
 from student_data;
 -----------------------------------------------
 select Sports,
case 
 when Sports = 0 then 'No'
 when Sports = 1 then 'Yes'
 end
  from student_data;

alter table student_data
add Sports_new nvarchar(255);

update student_data 
set Sports_new = case 
 when Sports = 0 then 'No'
 when Sports = 1  then 'Yes'
end;

select*
 from student_data;
 -----------------------------------------
 select Music,
case 
 when Music = 0 then 'No'
 when Music = 1 then 'Yes'
 end
  from student_data;

alter table student_data
add Music_new nvarchar(255);

update student_data 
set Music_new = case 
 when Music = 0 then 'No'
 when Music = 1  then 'Yes'
end;

select*
 from student_data;
-----------------------------------------------
 select Volunteering,
case 
 when Volunteering = 0 then 'No'
 when Volunteering = 1 then 'Yes'
 end
  from student_data;

alter table student_data
add Volunteering_new nvarchar(255);

update student_data 
set Volunteering_new = case 
 when Volunteering = 0 then 'No'
 when Volunteering = 1  then 'Yes'
end;

select*
 from student_data;
 -------------------------------------------
 select round(StudyTimeWeekly,2)
 from student_data;
 
 alter table student_data
add StudyTimeWeekly_new nvarchar(255);

update student_data 
set StudyTimeWeekly_new = round(StudyTimeWeekly,2);

select*
 from student_data;
 ------------------------------------
 
 
 ALTER TABLE student_data
DROP COLUMN ParentalEducation,
DROP COLUMN Absences,
DROP COLUMN Tutoring,
DROP COLUMN ParentalSupport,
DROP COLUMN Sports,
DROP COLUMN Music,
DROP COLUMN StudyTimeWeekly
;
 ALTER TABLE student_data
DROP COLUMN StudyTimeWeekly;

 ALTER TABLE student_data
DROP COLUMN Extracurricular;

------------------------------------------
select*
 from student_data;
 -----------------------------------------
 select GradeClass,
case 
 when GradeClass = 0 then 'A'
 when GradeClass = 1  then 'B'
 when GradeClass = 2 then 'C'
 when GradeClass = 3 then 'D'
 when GradeClass = 4 then 'F'
 end
  from student_data;
  
  alter table student_data
add GradeClass_new nvarchar(255);

update student_data 
set GradeClass_new = case 
 when GradeClass = 0 then 'A'
 when GradeClass = 1  then 'B'
 when GradeClass = 2 then 'C'
 when GradeClass = 3 then 'D'
 when GradeClass = 4 then 'F'
end;
  
 select*
 from student_data;
 --------------------------------
 ALTER TABLE student_data
DROP COLUMN GradeClass;
-------------------------------
select round(GPA,2)
 from student_data;
 
 alter table student_data
add GPA_new nvarchar(255);

update student_data 
set GPA_new = round(GPA,2);
-----------------------------------
ALTER TABLE student_data
DROP COLUMN GPA;
-------------------------------
 ---Finish----
 



 
 