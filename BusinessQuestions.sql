-- What are the top 5 Agencies that have the most job postings available
Select top 5
Agency.AgencyName,
count(Jobs.Source_JobID) as TotalPostings
from NYC_Jobs.FactJobs As Jobs
Inner join NYC_Jobs.DimAgency As Agency on Jobs.AgencyID = Agency.AgencyID
Group By Agency.AgencyName
order by TotalPostings DESC;
 
-- What are the average number of positions available for each agency.
Select 
Agency.AgencyName,
AVG(Jobs.NoOfPositions) as AvgPositions
from NYC_Jobs.FactJobs As Jobs
Inner join NYC_Jobs.DimAgency As Agency on Jobs.AgencyID = Agency.AgencyID
Group By Agency.AgencyName