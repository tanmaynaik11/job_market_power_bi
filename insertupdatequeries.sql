-- I am using Method 2: Manual Build with SQL Server Management Studio - [WINDOWS]
-- Inserting job information like Job Category, Full Time Part Time Indicator, Career Level, Salary Frequency, Job Description, 
-- Additional Information into DimJobInfo table from staging table 
INSERT INTO NYC_Jobs.DimJobInfo([JobCategory],[FullTimePartTimeIndicator],[CareerLevel],[SalaryFrequency],[JobDescription],[AdditionalInformation])
SELECT
DISTINCT [JobCategory],[FullTimePartTimeIndicator],[CareerLevel],[SalaryFrequency],[JobDescription],[AdditionalInformation]
FROM [NYC_Jobs].[Source_Data_Staging]
delete from NYC_Jobs.DimJobInfo
select * from NYC_Jobs.Source_Data_Staging

-- Updating the JobInfoID in Staging table based on multiple conditions involving columns from both Staging table and DimJobInfo table.
UPDATE NYC_Jobs.Source_Data_Staging
SET NYC_Jobs.Source_Data_Staging.JobInfoID = NYC_Jobs.DimJobInfo.job_id
FROM NYC_Jobs.Source_Data_Staging
INNER JOIN NYC_Jobs.DimJobInfo ON 
NYC_Jobs.Source_Data_Staging.[JobCategory] = NYC_Jobs.DimJobInfo.[JobCategory] and NYC_Jobs.Source_Data_Staging.[FullTimePartTimeIndicator] = NYC_Jobs.DimJobInfo.[FullTimePartTimeIndicator]
and NYC_Jobs.Source_Data_Staging.[CareerLevel] = NYC_Jobs.DimJobInfo.[CareerLevel] and NYC_Jobs.Source_Data_Staging.[SalaryFrequency] = NYC_Jobs.DimJobInfo.[SalaryFrequency]
and NYC_Jobs.Source_Data_Staging.[JobDescription] = NYC_Jobs.DimJobInfo.[JobDescription] and NYC_Jobs.Source_Data_Staging.[AdditionalInformation] = NYC_Jobs.DimJobInfo.[AdditionalInformation]

-- Inserting Applicants information like Applicant's first name, Applicant's last name, Email, City into DimNYC_Applicants table from staging table 
INSERT INTO NYC_Jobs.DimNYC_Applicants([Applicant_First_Name],[Applicant_Last_Name],[Email],[City])
SELECT
DISTINCT [Applicant_First_Name],[Applicant_Last_Name],[Email],[City]
FROM [NYC_Jobs].[Source_Data_Staging]

-- Updating the Applicant_id in Staging table based on multiple conditions involving columns from both Staging table and DimNYC_Applicants table.
UPDATE NYC_Jobs.Source_Data_Staging
SET NYC_Jobs.Source_Data_Staging.Applicant_id = NYC_Jobs.DimNYC_Applicants.Applicant_id
FROM NYC_Jobs.Source_Data_Staging
INNER JOIN NYC_Jobs.DimNYC_Applicants ON 
NYC_Jobs.Source_Data_Staging.[Applicant_First_Name] = NYC_Jobs.DimNYC_Applicants.Applicant_First_Name and NYC_Jobs.Source_Data_Staging.[Applicant_Last_Name] = NYC_Jobs.DimNYC_Applicants.Applicant_Last_Name
and NYC_Jobs.Source_Data_Staging.[Email] = NYC_Jobs.DimNYC_Applicants.Email and NYC_Jobs.Source_Data_Staging.[City] = NYC_Jobs.DimNYC_Applicants.City

---- Inserting Applicantions information like applicant id, application_date into DimNYC_Applications table from staging table 
INSERT INTO NYC_Jobs.DimNYC_Applications([applicant_id],[job_id],[application_date])
SELECT
DISTINCT [applicant_id],[JobInfoID],[application_date]
FROM [NYC_Jobs].[Source_Data_Staging]

-- Updating the application_id in Staging table based on multiple conditions involving columns from both Staging table and DimNYC_Applications table.
UPDATE NYC_Jobs.Source_Data_Staging
SET NYC_Jobs.Source_Data_Staging.application_id = NYC_Jobs.DimNYC_Applications.application_id
FROM NYC_Jobs.Source_Data_Staging
INNER JOIN NYC_Jobs.DimNYC_Applications ON 
NYC_Jobs.Source_Data_Staging.[application_date] = NYC_Jobs.DimNYC_Applications.application_date and NYC_Jobs.Source_Data_Staging.[JobInfoID] = NYC_Jobs.DimNYC_Applications.job_id
and NYC_Jobs.Source_Data_Staging.[Applicant_id] = NYC_Jobs.DimNYC_Applications.applicant_id 

-- Inserting hired information like applicant id, job id, hired date  into DimNYC_job_applicant_hired table from staging table 
INSERT INTO NYC_Jobs.DimNYC_job_applicant_hired([applicant_id],[job_id],[hired_date])
SELECT
DISTINCT [applicant_id],[JobInfoID],[hired_date]
FROM [NYC_Jobs].[Source_Data_Staging]

-- Updating the hired_id in Staging table based on multiple conditions involving columns from both Staging table and DimNYC_job_applicant_hired table.
UPDATE NYC_Jobs.Source_Data_Staging
SET NYC_Jobs.Source_Data_Staging.hired_id = NYC_Jobs.DimNYC_job_applicant_hired.hired_id
FROM NYC_Jobs.Source_Data_Staging
INNER JOIN NYC_Jobs.DimNYC_job_applicant_hired ON 
NYC_Jobs.Source_Data_Staging.[hired_date] = NYC_Jobs.DimNYC_job_applicant_hired.hired_date and NYC_Jobs.Source_Data_Staging.[JobInfoID] = NYC_Jobs.DimNYC_job_applicant_hired.job_id
and NYC_Jobs.Source_Data_Staging.[Applicant_id] = NYC_Jobs.DimNYC_job_applicant_hired.applicant_id 

-- Inserting Agencies into DimAgency table from staging table 
INSERT INTO NYC_Jobs.DimAgency([AgencyName])
SELECT
DISTINCT [AgencyName]
FROM [NYC_Jobs].[Source_Data_Staging]
ORDER BY [AgencyName] ASC

-- Updating the AgencyID in Staging table with the corresponding AgencyID from DimAgency table for rows where the AgencyName matches in both tables.
UPDATE NYC_Jobs.Source_Data_Staging
SET NYC_Jobs.Source_Data_Staging.AgencyID = NYC_Jobs.DimAgency.AgencyID
FROM NYC_Jobs.Source_Data_Staging
INNER JOIN NYC_Jobs.DimAgency ON 
NYC_Jobs.Source_Data_Staging.[AgencyName] = NYC_Jobs.DimAgency.[AgencyName]



-- Inserting Title related information like Business Title, Civil Service Title, Title Classificatin, Title Code No, Level 
-- into DimTitle table from staging table 
INSERT INTO NYC_Jobs.DimTitle([BusinessTitle],[CivilServiceTitle],[TitleClassification],[TitleCodeNo],[Level])
SELECT
DISTINCT [BusinessTitle],[CivilServiceTitle],[TitleClassification],[TitleCodeNo],[Level]
FROM [NYC_Jobs].[Source_Data_Staging]

-- Updating the TitleID in Staging table based on multiple conditions involving columns from both Staging table and DimTitle table.
UPDATE NYC_Jobs.Source_Data_Staging
SET NYC_Jobs.Source_Data_Staging.TitleID = NYC_Jobs.DimTitle.TitleID
FROM NYC_Jobs.Source_Data_Staging
INNER JOIN NYC_Jobs.DimTitle ON 
NYC_Jobs.Source_Data_Staging.[BusinessTitle] = NYC_Jobs.DimTitle.[BusinessTitle] 
and NYC_Jobs.Source_Data_Staging.[CivilServiceTitle] = NYC_Jobs.DimTitle.[CivilServiceTitle]
and NYC_Jobs.Source_Data_Staging.[TitleClassification] = NYC_Jobs.DimTitle.[TitleClassification] 
and NYC_Jobs.Source_Data_Staging.[TitleCodeNo] = NYC_Jobs.DimTitle.[TitleCodeNo]
and NYC_Jobs.Source_Data_Staging.[Level] = NYC_Jobs.DimTitle.[Level]

-- Inserting Location related information like Work Location, Division Work Unit, Work Location 1 into DimLocation table from staging table 
INSERT INTO NYC_Jobs.DimLocation([WorkLocation],[DivisionWorkUnit],[WorkLocation1])
SELECT
DISTINCT [WorkLocation],[DivisionWorkUnit],[WorkLocation1]
FROM [NYC_Jobs].[Source_Data_Staging]

-- Updating the LocationID in Staging table based on multiple conditions involving columns from both Staging table and DimLocation table.
UPDATE NYC_Jobs.Source_Data_Staging
SET NYC_Jobs.Source_Data_Staging.LocationID = NYC_Jobs.DimLocation.LocationID
FROM NYC_Jobs.Source_Data_Staging
INNER JOIN NYC_Jobs.DimLocation ON 
NYC_Jobs.Source_Data_Staging.[WorkLocation] = NYC_Jobs.DimLocation.[WorkLocation] and NYC_Jobs.Source_Data_Staging.[DivisionWorkUnit] = NYC_Jobs.DimLocation.[DivisionWorkUnit]
and NYC_Jobs.Source_Data_Staging.[WorkLocation1] = NYC_Jobs.DimLocation.[WorkLocation1] 

-- Inserting job information like Job Category, Full Time Part Time Indicator, Career Level, Salary Frequency, Job Description, 
-- Additional Information into DimJobInfo table from staging table 
INSERT INTO NYC_Jobs.DimJobInfo([JobCategory],[FullTimePartTimeIndicator],[CareerLevel],[SalaryFrequency],[JobDescription],[AdditionalInformation])
SELECT
DISTINCT [JobCategory],[FullTimePartTimeIndicator],[CareerLevel],[SalaryFrequency],[JobDescription],[AdditionalInformation]
FROM [NYC_Jobs].[Source_Data_Staging]
delete from NYC_Jobs.DimJobInfo
select * from NYC_Jobs.Source_Data_Staging

-- Updating the JobInfoID in Staging table based on multiple conditions involving columns from both Staging table and DimJobInfo table.
UPDATE NYC_Jobs.Source_Data_Staging
SET NYC_Jobs.Source_Data_Staging.JobInfoID = NYC_Jobs.DimJobInfo.job_id
FROM NYC_Jobs.Source_Data_Staging
INNER JOIN NYC_Jobs.DimJobInfo ON 
NYC_Jobs.Source_Data_Staging.[JobCategory] = NYC_Jobs.DimJobInfo.[JobCategory] and NYC_Jobs.Source_Data_Staging.[FullTimePartTimeIndicator] = NYC_Jobs.DimJobInfo.[FullTimePartTimeIndicator]
and NYC_Jobs.Source_Data_Staging.[CareerLevel] = NYC_Jobs.DimJobInfo.[CareerLevel] and NYC_Jobs.Source_Data_Staging.[SalaryFrequency] = NYC_Jobs.DimJobInfo.[SalaryFrequency]
and NYC_Jobs.Source_Data_Staging.[JobDescription] = NYC_Jobs.DimJobInfo.[JobDescription] and NYC_Jobs.Source_Data_Staging.[AdditionalInformation] = NYC_Jobs.DimJobInfo.[AdditionalInformation]

-- Inserting Requirements information like Minimum Qualification Requirements, Preferred Skills, To Apply, Hours Shift, Recruitment Contact, 
-- Residency Requirement into DimRequirements table from staging table 
INSERT INTO NYC_Jobs.DimRequirements([MinimumQualRequirements],[PreferredSkills],[ToApply],[HoursShift],[RecruitmentContact],[ResidencyRequirement])
SELECT
DISTINCT [MinimumQualRequirements],[PreferredSkills],[ToApply],[HoursShift],[RecruitmentContact],[ResidencyRequirement]
FROM [NYC_Jobs].[Source_Data_Staging]

-- Updating the RequirementsID in Staging table based on multiple conditions involving columns from both Staging table and DimRequirements table.	
UPDATE NYC_Jobs.Source_Data_Staging
SET NYC_Jobs.Source_Data_Staging.RequirementsID = NYC_Jobs.DimRequirements.RequirementsID
FROM NYC_Jobs.Source_Data_Staging
INNER JOIN NYC_Jobs.DimRequirements ON 
NYC_Jobs.Source_Data_Staging.[MinimumQualRequirements] = NYC_Jobs.DimRequirements.[MinimumQualRequirements] and NYC_Jobs.Source_Data_Staging.[PreferredSkills] = NYC_Jobs.DimRequirements.[PreferredSkills]
and NYC_Jobs.Source_Data_Staging.[ToApply] = NYC_Jobs.DimRequirements.[ToApply] and NYC_Jobs.Source_Data_Staging.[HoursShift] = NYC_Jobs.DimRequirements.[HoursShift]
and NYC_Jobs.Source_Data_Staging.[RecruitmentContact] = NYC_Jobs.DimRequirements.[RecruitmentContact] and NYC_Jobs.Source_Data_Staging.[ResidencyRequirement] = NYC_Jobs.DimRequirements.[ResidencyRequirement]

-- Updating the 'PostUntil' column in the staging table by converting its content to date datatype, as it was initially imported as varchar and 
-- was not in proper format.
-- I am also updating the '' values with 'NULL' as I have to enter these values in 'PostUntil' column of 'DimPosting' table which has the datatype date
UPDATE NYC_Jobs.[Source_Data_Staging]
SET PostUntil = 
    CASE 
        WHEN PostUntil = '' THEN NULL
        ELSE CONVERT(DATE, PostUntil, 110)
END;

-- Updating the 'PostingDate' column in the staging table by converting its content to date datatype, as it was initially imported as varchar and
-- was not in proper format.
UPDATE NYC_Jobs.[Source_Data_Staging]
SET PostingDate = 
    CASE 
        WHEN PostingDate = '' THEN NULL
        ELSE CONVERT(DATE, PostingDate, 110)
END;

-- Updating the 'PostingDate' column in the staging table by converting its content to date datatype, as it was initially imported as varchar and 
-- was not in proper format.
UPDATE NYC_Jobs.[Source_Data_Staging]
SET ProcessDate = 
    CASE 
        WHEN ProcessDate = '' THEN NULL
        ELSE CONVERT(DATE, ProcessDate, 110)
END;

-- Updating the 'PostingUpdated' column in the staging table by converting its content to date datatype, as it was initially imported as varchar and 
-- was not in proper format.
UPDATE NYC_Jobs.[Source_Data_Staging]
SET PostingUpdated = 
    CASE 
        WHEN PostingUpdated = '' THEN NULL
        ELSE CONVERT(DATE, PostingUpdated, 110)
END;


-- Inserting Posting related information like Posting Type, Post Until, Posting Updated, Process Date into DimPosting table from staging table 
INSERT INTO NYC_Jobs.DimPosting([PostingType],[PostingDate],[PostUntil],[PostingUpdated],[ProcessDate])
SELECT
DISTINCT [PostingType],[PostingDate],[PostUntil],[PostingUpdated],[ProcessDate]
FROM [NYC_Jobs].[Source_Data_Staging]

-- -- Updating the PostingID in Staging table based on multiple conditions involving columns from both Staging table and DimPosting table.
UPDATE NYC_Jobs.Source_Data_Staging
SET NYC_Jobs.Source_Data_Staging.PostingID = NYC_Jobs.DimPosting.PostingID
FROM NYC_Jobs.Source_Data_Staging
INNER JOIN NYC_Jobs.DimPosting ON 
NYC_Jobs.Source_Data_Staging.[PostingType] = NYC_Jobs.DimPosting.[PostingType] and NYC_Jobs.Source_Data_Staging.[PostingDate] = NYC_Jobs.DimPosting.[PostingDate]
and NYC_Jobs.Source_Data_Staging.[PostUntil] = NYC_Jobs.DimPosting.[PostUntil] and NYC_Jobs.Source_Data_Staging.[PostingUpdated] = NYC_Jobs.DimPosting.[PostingUpdated]
and NYC_Jobs.Source_Data_Staging.[PostingUpdated] = NYC_Jobs.DimPosting.[PostingUpdated] and NYC_Jobs.Source_Data_Staging.[ProcessDate] = NYC_Jobs.DimPosting.[ProcessDate]


-- Inserting the data into fact table from staging table
INSERT INTO [NYC_Jobs].[FactJobs]
           ([Source_JobID]
		   ,[application_id]
		   ,[hired_id]
           ,[AgencyID]
           ,[LocationID]
           ,[PostingID]
           ,[RequirementsID]
		   ,[TitleID]
           ,[NoOfPositions]
           ,[SalaryRangeFrom]
           ,[SalaryRangeTo])
		   SELECT
			  [Source_JobID]
			  ,[application_id]
			  ,[hired_id]
			  ,[AgencyID]
			  ,[LocationID]
			  ,[PostingID]
			  ,[RequirementsID]
			  ,[TitleID]
			  ,[NoOfPositions]
			  ,[SalaryRangeFrom]
			  ,[SalaryRangeTo]
			  
		  FROM [NYC_Jobs].[NYC_Jobs].[Source_Data_Staging]
