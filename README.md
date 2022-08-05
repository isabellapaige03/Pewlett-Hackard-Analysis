# Pewlett-Hackard-Analysis

## Overview of Project

 Pewlett Hackard will soon be facing a "silver tsunami". This analysis wil provide information to help Pewlett Hackard prepare for the large amount of retiring employees. This analysis will determine the amount of roles needed to be filled based on the amount of retirement-ready employees. It will also determine how many retirement-ready employees are eligible to mentor new employess.


## Results
  The first table created looks at the employees who were born between January 1, 1952 and December 31, 1955. In the table below there are employees that have been duplicated. This is due to employees changing their job position.
  
  <img width="500" alt="retirementtitles" src="https://user-images.githubusercontent.com/106712521/182982103-30937b2a-9277-431f-aeec-46a52e7dfb69.png">
  
  The unique_titles table fixes the duplicate names by using the "DISTINCT ON" function in sql. The results show retirement-ready employees and their current postion. 
  
  <img width="361" alt="uniquetitles" src="https://user-images.githubusercontent.com/106712521/182982800-dc8eae1e-ba94-4eea-9a39-f4e9957ad211.png">
  
  The retiring_titles table shows how many employees are retirement-ready in each department. The majority of the upcomming employees who are close to retirement are from the Senior Engineer department and the Senior Staff department.

<img width="164" alt="retitringtitles" src="https://user-images.githubusercontent.com/106712521/182983469-fed33b28-29bb-4fd2-a4c6-51dd45c86edd.png">

In order to prepare for the "silver tsunami" this last table mentorship_eligibilty represents the retirement-ready employees who are eligible for a mentorship program. The table below shows employees who were born in the year 1965 and who are currently employed.

