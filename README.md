# LokSabha_Election_Analysis

## Project Overview
Election data analysis plays a crucial role in understanding democratic processes. This project organizes and analyzes election-related data such as state-wise results, party performance, and constituency-specific details. It highlights database management and querying techniques tailored for analytical reporting.

## Project Structure
### Database Setup

- **Database Creation**: The project starts by creating a database named `election_db`.
- **Tables Creation**:
 a. **states table**:
```sql
DROP TABLE IF EXISTS states;
CREATE TABLE states (
	StateID	TEXT,
	Statename VARCHAR(50)
);
```
 b. **statewise_result table**
 ```sql
DROP TABLE IF EXISTS statewise_results;
CREATE TABLE statewise_results (
	Constituency VARCHAR(50),
	Const_No INT,
	ParliamentConstituency TEXT,
	LeadingCandidate VARCHAR(60),
	TrailingCandidate VARCHAR(50),
	Margin INT,
	Status VARCHAR(50),
	StateID TEXT,
	Statename VARCHAR(50)
);
```
 c. **partywise_results table**
 ```sql
DROP TABLE IF EXISTS partywise_results;
CREATE TABLE partywise_results (
	Party TEXT,
	Won INT,
	PartyID INT
);
```
 d. **constituencywise_results table**
 ```sql
DROP TABLE IF EXISTS constituencywise_results;
CREATE TABLE constituencywise_results (
	SerialNo INT,
	ParliamentConstituency TEXT,
	ConstituencyName VARCHAR(30),
	WinningCandidate VARCHAR(60),
	TotalVotes INT,
	Margin INT,
	ConstituencyID TEXT,
	PartyID INT
);
```
 e. **constituencywise_details table**
 ```sql
DROP TABLE IF EXISTS constituencywise_details;
CREATE TABLE constituencywise_details (
	SerialNo INT,
	Candidate VARCHAR(100),
	Party VARCHAR(100),
	EVMVotes INT,
	PostalVotes INT,
	TotalVotes INT,
	PercentofVotes NUMERIC,
	ConstituencyID TEXT
);
```

### Data Explore
```sql
SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;
SELECT * FROM partywise_results;
SELECT * FROM statewise_results;
SELECT * FROM states;
```

### DATA EXPLORATION & ANALYSIS

1. **Find Total Seats**

2. **Total no. of seats available for elections in each state**

3. **Total seats won by NDA Alliance (1st: find who are the alliances of NDA)**

4. **Seats Won by NDA Alliance Parties**

5. **Total Seats won by I.N.D.I.A Alliance**

6. **Seats Won by I.N.D.I.A Alliance Parties**

7. **Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER**

8. **Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states**

9. **Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency**

10. **What is the distribution of EVM votes versus postal votes for candidates in a specific constituency**

11. **Which candidate received the highest number of EVM votes in each constituency (Top 10)**


## Core Features :
- Creation of a relational database schema for election data.
- Analysis-ready data structures for state-wise, constituency-level, and party-wise metrics.
- SQL queries for:
   1. Identifying leading candidates and vote margins.
   2. Evaluating party performance across states.
   3. Aggregating state-wise results for comprehensive reporting.


## Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, exploratory data analysis, and data-driven SQL queries. 
