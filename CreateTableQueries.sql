-- I have put thr following attributes of NYCJobs table of assignment1 in different dimension tables 
-- posting_type
-- job_title
-- Primary_skill
-- no_of_positions
-- posting date 

-- I have changed the name of the following attributes of assignment1 to the mentioned names as the new 
-- given names were matching with the csv file I used. But the data similar to assignment1 can be entered in these columns. 
-- I just changes the attribute names.
-- job_type as FullTimePartTimeIndicator 
-- job_title as FullTimePartTimeIndicator
-- Primary_skill as PreferredSkills
-- Staging table
USE [NYC_Jobs]
GO

/****** Object:  Table [NYC_Jobs].[Source_Data_Staging]    Script Date: 17-10-2023 22:01:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [NYC_Jobs].[Source_Data_Staging](
	[Source_StagingID] [int] IDENTITY(1,1) NOT NULL,
	[Source_JobID] [int] NULL,
	[Applicant_First_Name] [varchar](50) NULL,
	[Applicant_Last_Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[Applicant_id] [int] NULL,
	[application_date] [date] NULL,
	[application_id] [int] NULL,
	[hired_date] [date] NULL,
	[hired_id] [int] NULL,
	[AgencyName] [varchar](50) NULL,
	[AgencyID] [int] NULL,
	[BusinessTitle] [varchar](200) NULL,
	[CivilServiceTitle] [varchar](100) NULL,
	[TitleClassification] [varchar](50) NULL,
	[TitleCodeNo] [varchar](10) NULL,
	[Level] [varchar](5) NULL,
	[TitleID] [int] NULL,
	[WorkLocation] [varchar](50) NULL,
	[DivisionWorkUnit] [varchar](100) NULL,
	[WorkLocation1] [varchar](500) NULL,
	[LocationID] [int] NULL,
	[JobCategory] [varchar](500) NULL,
	[FullTimePartTimeIndicator] [varchar](5) NULL,
	[CareerLevel] [varchar](50) NULL,
	[SalaryFrequency] [varchar](10) NULL,
	[JobDescription] [varchar](max) NULL,
	[AdditionalInformation] [varchar](3200) NULL,
	[JobInfoID] [int] NULL,
	[MinimumQualRequirements] [varchar](max) NULL,
	[PreferredSkills] [varchar](max) NULL,
	[ToApply] [varchar](3000) NULL,
	[HoursShift] [varchar](500) NULL,
	[RecruitmentContact] [varchar](15) NULL,
	[ResidencyRequirement] [varchar](800) NULL,
	[RequirementsID] [int] NULL,
	[PostingType] [varchar](10) NULL,
	[PostingDate] [varchar](10) NULL,
	[PostUntil] [varchar](10) NULL,
	[PostingUpdated] [varchar](10) NULL,
	[ProcessDate] [varchar](10) NULL,
	[PostingID] [int] NULL,
	[NoOfPositions] [int] NULL,
	[SalaryRangeFrom] [money] NULL,
	[SalaryRangeTo] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[Source_StagingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



----------------------------------------------------------------------------------------
-- Dimensions
-- NYCJobs
USE [NYC_Jobs]
GO

/****** Object:  Table [NYC_Jobs].[DimJobInfo]    Script Date: 17-10-2023 21:03:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [NYC_Jobs].[DimJobInfo](
	[job_id] [int] IDENTITY(1,1) NOT NULL,
	[JobCategory] [varchar](500) NULL,
	[FullTimePartTimeIndicator] [varchar](5) NULL,
	[CareerLevel] [varchar](50) NULL,
	[SalaryFrequency] [varchar](10) NULL,
	[JobDescription] [varchar](max) NULL,
	[AdditionalInformation] [varchar](3200) NULL,
PRIMARY KEY CLUSTERED 
(
	[job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
----------------------------------------------------------------------------------------------
-- NYC_Applicants
USE [NYC_Jobs]
GO

/****** Object:  Table [NYC_Jobs].[DimNYC_Applicants]    Script Date: 17-10-2023 21:04:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [NYC_Jobs].[DimNYC_Applicants](
	[Applicant_id] [int] IDENTITY(1,1) NOT NULL,
	[Applicant_First_Name] [varchar](50) NULL,
	[Applicant_Last_Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[City] [varchar](50) NULL,
 CONSTRAINT [PK_job_applicant] PRIMARY KEY CLUSTERED 
(
	[Applicant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-------------------------------------------------------------------------------------------
-- NYC_Applications
USE [NYC_Jobs]
GO

/****** Object:  Table [NYC_Jobs].[DimNYC_Applications]    Script Date: 17-10-2023 21:06:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [NYC_Jobs].[DimNYC_Applications](
	[application_id] [int] IDENTITY(1,1) NOT NULL,
	[applicant_id] [int] NULL,
	[job_id] [int] NULL,
	[application_date] [date] NULL,
 CONSTRAINT [PK_applications] PRIMARY KEY CLUSTERED 
(
	[application_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [NYC_Jobs].[DimNYC_Applications]  WITH CHECK ADD FOREIGN KEY([applicant_id])
REFERENCES [NYC_Jobs].[DimNYC_Applicants] ([Applicant_id])
GO

ALTER TABLE [NYC_Jobs].[DimNYC_Applications]  WITH CHECK ADD FOREIGN KEY([job_id])
REFERENCES [NYC_Jobs].[DimJobInfo] ([job_id])
GO
----------------------------------------------------------------------------------------------
-- NYC_Job_Applicant_Hired
USE [NYC_Jobs]
GO

/****** Object:  Table [NYC_Jobs].[DimNYC_job_applicant_hired]    Script Date: 17-10-2023 21:07:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [NYC_Jobs].[DimNYC_job_applicant_hired](
	[hired_id] [int] IDENTITY(1,1) NOT NULL,
	[applicant_id] [int] NULL,
	[job_id] [int] NULL,
	[hired_date] [date] NULL,
 CONSTRAINT [PK_job_applicant_hired] PRIMARY KEY CLUSTERED 
(
	[hired_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [NYC_Jobs].[DimNYC_job_applicant_hired]  WITH CHECK ADD FOREIGN KEY([applicant_id])
REFERENCES [NYC_Jobs].[DimNYC_Applicants] ([Applicant_id])
GO

ALTER TABLE [NYC_Jobs].[DimNYC_job_applicant_hired]  WITH CHECK ADD FOREIGN KEY([job_id])
REFERENCES [NYC_Jobs].[DimJobInfo] ([job_id])
GO
----------------------------------------------------------------------------------------------
--  Agency
USE [NYC_Jobs]
GO

/****** Object:  Table [NYC_Jobs].[DimAgency]    Script Date: 13-10-2023 10:39:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TABLE [NYC_Jobs].[DimAgency](
	[AgencyID] [int] IDENTITY(1,1) NOT NULL,
	[AgencyName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[AgencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
--------------------------------------------------------------------------------------------

-- Location
USE [NYC_Jobs]
GO

/****** Object:  Table [NYC_Jobs].[DimLocation]    Script Date: 13-10-2023 10:40:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [NYC_Jobs].[DimLocation](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[WorkLocation] [varchar](50) NULL,
	[DivisionWorkUnit] [varchar](100) NULL,
	[WorkLocation1] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO 

------------------------------------------------------------------------------------------------
-- Posting
USE [NYC_Jobs]
GO

/****** Object:  Table [NYC_Jobs].[DimPosting]    Script Date: 13-10-2023 16:37:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [NYC_Jobs].[DimPosting](
	[PostingID] [int] IDENTITY(1,1) NOT NULL,
	[PostingType] [varchar](10) NULL,
	[PostingDate] [date] NULL,
	[PostUntil] [date] NULL,
	[PostingUpdated] [date] NULL,
	[ProcessDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[PostingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------------------------------------------------------- 
 -- Requirements
 USE [NYC_Jobs]
GO

/****** Object:  Table [NYC_Jobs].[DimRequirements]    Script Date: 13-10-2023 10:41:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [NYC_Jobs].[DimRequirements](
	[RequirementsID] [int] IDENTITY(1,1) NOT NULL,
	[MinimumQualRequirements] [varchar](max) NULL,
	[PreferredSkills] [varchar](max) NULL,
	[ToApply] [varchar](3000) NULL,
	[HoursShift] [varchar](500) NULL,
	[RecruitmentContact] [varchar](15) NULL,
	[ResidencyRequirement] [varchar](800) NULL,
PRIMARY KEY CLUSTERED 
(
	[RequirementsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------------------
-- Title
USE [NYC_Jobs]
GO

/****** Object:  Table [NYC_Jobs].[DimTitle]    Script Date: 13-10-2023 10:41:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [NYC_Jobs].[DimTitle](
	[TitleID] [int] IDENTITY(1,1) NOT NULL,
	[BusinessTitle] [varchar](200) NULL,
	[CivilServiceTitle] [varchar](100) NULL,
	[TitleClassification] [varchar](50) NULL,
	[TitleCodeNo] [varchar](10) NULL,
	[Level] [varchar](5) NULL,
PRIMARY KEY CLUSTERED 
(
	[TitleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
----------------------------------------------------------------------------------------------------
-- Fact table
-- Fact Jobs
USE [NYC_Jobs]
GO

/****** Object:  Table [NYC_Jobs].[FactJobs]    Script Date: 17-10-2023 22:04:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [NYC_Jobs].[FactJobs](
	[FactID] [int] IDENTITY(1,1) NOT NULL,
	[Source_JobID] [int] NULL,
	[application_id] [int] NULL,
	[hired_id] [int] NULL,
	[AgencyID] [int] NULL,
	[LocationID] [int] NULL,
	[PostingID] [int] NULL,
	[RequirementsID] [int] NULL,
	[TitleID] [int] NULL,
	[NoOfPositions] [int] NULL,
	[SalaryRangeFrom] [money] NULL,
	[SalaryRangeTo] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[FactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [NYC_Jobs].[FactJobs]  WITH CHECK ADD  CONSTRAINT [FK_AgencyID] FOREIGN KEY([AgencyID])
REFERENCES [NYC_Jobs].[DimAgency] ([AgencyID])
GO

ALTER TABLE [NYC_Jobs].[FactJobs] CHECK CONSTRAINT [FK_AgencyID]
GO

ALTER TABLE [NYC_Jobs].[FactJobs]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationID] FOREIGN KEY([application_id])
REFERENCES [NYC_Jobs].[DimNYC_Applications] ([application_id])
GO

ALTER TABLE [NYC_Jobs].[FactJobs] CHECK CONSTRAINT [FK_ApplicationID]
GO

ALTER TABLE [NYC_Jobs].[FactJobs]  WITH CHECK ADD  CONSTRAINT [FK_hiredID] FOREIGN KEY([hired_id])
REFERENCES [NYC_Jobs].[DimNYC_job_applicant_hired] ([hired_id])
GO

ALTER TABLE [NYC_Jobs].[FactJobs] CHECK CONSTRAINT [FK_hiredID]
GO

ALTER TABLE [NYC_Jobs].[FactJobs]  WITH CHECK ADD  CONSTRAINT [FK_LocationID] FOREIGN KEY([LocationID])
REFERENCES [NYC_Jobs].[DimLocation] ([LocationID])
GO

ALTER TABLE [NYC_Jobs].[FactJobs] CHECK CONSTRAINT [FK_LocationID]
GO

ALTER TABLE [NYC_Jobs].[FactJobs]  WITH CHECK ADD  CONSTRAINT [FK_PostingID] FOREIGN KEY([PostingID])
REFERENCES [NYC_Jobs].[DimPosting] ([PostingID])
GO

ALTER TABLE [NYC_Jobs].[FactJobs] CHECK CONSTRAINT [FK_PostingID]
GO

ALTER TABLE [NYC_Jobs].[FactJobs]  WITH CHECK ADD  CONSTRAINT [FK_RequirementsID] FOREIGN KEY([RequirementsID])
REFERENCES [NYC_Jobs].[DimRequirements] ([RequirementsID])
GO

ALTER TABLE [NYC_Jobs].[FactJobs] CHECK CONSTRAINT [FK_RequirementsID]
GO

ALTER TABLE [NYC_Jobs].[FactJobs]  WITH CHECK ADD  CONSTRAINT [FK_TitleID] FOREIGN KEY([TitleID])
REFERENCES [NYC_Jobs].[DimTitle] ([TitleID])
GO

ALTER TABLE [NYC_Jobs].[FactJobs] CHECK CONSTRAINT [FK_TitleID]
GO

