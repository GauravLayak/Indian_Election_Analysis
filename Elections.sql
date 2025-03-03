--Create Few Tables--
DROP TABLE IF EXISTS states;
CREATE TABLE states (
	StateID	TEXT,
	Statename VARCHAR(50)
);

DROP TABLE IF EXISTS statewise_results;
CREATE TABLE statewise_results (
	Constituency VARCHAR(50),
	Const_No INT,
	ParliamentConstituency TEXT,
	LeadingCandidate VARCHAR(60),
	TrailingCandidate VARCHAR(50),
	Margin INT,
	Status VARCHAR(50),
	StateID	TEXT,
	Statename VARCHAR(50)
);

DROP TABLE IF EXISTS partywise_results;
CREATE TABLE partywise_results (
	Party TEXT,
	Won	INT,
	PartyID INT
);

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

DROP TABLE IF EXISTS constituencywise_details;
CREATE TABLE constituencywise_details (
	SerialNo INT,
	Candidate VARCHAR(100),
	Party VARCHAR(100),
	EVMVotes INT,
	PostalVotes	INT,
	TotalVotes INT,
	PercentofVotes NUMERIC,
	ConstituencyID TEXT
);

SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;
SELECT * FROM partywise_results;
SELECT * FROM statewise_results;
SELECT * FROM states;


-- DATA EXPLORATIONS --

--Find Total Seats
SELECT DISTINCT COUNT(parliamentconstituency) AS total_seats
FROM constituencywise_results;

--Total no. of seats available for elections in each state
SELECT s.statename,
	 COUNT(cr.parliamentconstituency) AS total_seats
FROM constituencywise_results AS cr
INNER JOIN statewise_results AS sr 
ON cr.parliamentconstituency = sr.parliamentconstituency
INNER JOIN states AS s
ON sr.stateID = s.stateID
GROUP BY 1
ORDER BY 1;

--Total seats won by NDA Alliance (1st: find who are the alliances of NDA)
SELECT 
	SUM(CASE 
		WHEN party IN (
			'Bharatiya Janata Party - BJP',
			'Telugu Desam - TDP',
			'Janata Dal  (United) - JD(U)',
			'Shiv Sena - SHS',
			'AJSU Party - AJSUP',
			'Apna Dal (Soneylal) - ADAL',
			'Asom Gana Parishad - AGP',
			'Hindustani Awam Morcha (Secular) - HAMS',
			'Janasena Party - JnP',
			'Janata Dal  (Secular) - JD(S)',
			'Lok Janshakti Party(Ram Vilas) - LJPRV',
			'Nationalist Congress Party - NCP',
			'Rashtriya Lok Dal - RLD',
			'Sikkim Krantikari Morcha - SKM'
		) THEN Won
		ELSE 0
	END ) AS NDA_total_seats_won
FROM 
partywise_results;

--Seats Won by NDA Alliance Parties
SELECT party AS Party_name,
	won AS Seats_won
FROM partywise_results
		WHERE party IN (
			'Bharatiya Janata Party - BJP',
			'Telugu Desam - TDP',
			'Janata Dal  (United) - JD(U)',
			'Shiv Sena - SHS',
			'AJSU Party - AJSUP',
			'Apna Dal (Soneylal) - ADAL',
			'Asom Gana Parishad - AGP',
			'Hindustani Awam Morcha (Secular) - HAMS',
			'Janasena Party - JnP',
			'Janata Dal  (Secular) - JD(S)',
			'Lok Janshakti Party(Ram Vilas) - LJPRV',
			'Nationalist Congress Party - NCP',
			'Rashtriya Lok Dal - RLD',
			'Sikkim Krantikari Morcha - SKM'
		)
ORDER BY 2 DESC;

--Total Seats won by I.N.D.I.A Alliance
SELECT 
    SUM(CASE 
           WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN Won
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    partywise_results;

--Seats Won by I.N.D.I.A Alliance Parties
SELECT party AS Party_name,
	won AS Seats_won
FROM partywise_results 
           WHERE party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            )
ORDER BY 2 DESC;

--Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER
ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50);

SELECT * FROM partywise_results;

--1st for I.N.D.I.A Alliance
UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            )

--2nd for NDA Alliance
UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
			'Bharatiya Janata Party - BJP',
			'Telugu Desam - TDP',
			'Janata Dal  (United) - JD(U)',
			'Shiv Sena - SHS',
			'AJSU Party - AJSUP',
			'Apna Dal (Soneylal) - ADAL',
			'Asom Gana Parishad - AGP',
			'Hindustani Awam Morcha (Secular) - HAMS',
			'Janasena Party - JnP',
			'Janata Dal  (Secular) - JD(S)',
			'Lok Janshakti Party(Ram Vilas) - LJPRV',
			'Nationalist Congress Party - NCP',
			'Rashtriya Lok Dal - RLD',
			'Sikkim Krantikari Morcha - SKM'
		)

--3rd for OTHER Alliance
UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;

SELECT * FROM partywise_results;

--Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states
SELECT party_alliance,
	SUM(won) AS total_seats
FROM partywise_results
GROUP BY 1
ORDER BY 2 DESC;

--Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency
SELECT cr.winningcandidate,
	pr.party,
	pr.party_alliance,
	cr.totalvotes,
	cr.margin,
	s.statename,
	cr.constituencyname
FROM constituencywise_results AS cr
INNER JOIN partywise_results AS pr
ON cr.partyid = pr.partyid
INNER JOIN statewise_results AS sr
ON cr.parliamentconstituency = sr.parliamentconstituency
INNER JOIN states AS s
ON sr.stateid = s.stateid
WHERE constituency ILIKE '%delhi%';

--What is the distribution of EVM votes versus postal votes for candidates in a specific constituency
SELECT cd.evmvotes,
	cd.postalvotes,
	cd.totalvotes,
	cd.candidate,
	cr.constituencyname
FROM constituencywise_results AS cr
INNER JOIN constituencywise_details AS cd
ON cr.constituencyid = cd.constituencyid
WHERE cr.constituencyname ILIKE '%Amethi%';


--Which candidate received the highest number of EVM votes in each constituency (Top 10)
SELECT
    cr.constituencyname,
    cd.constituencyid,
    cd.candidate,
    cd.EVMvotes
FROM constituencywise_details AS cd
INNER JOIN constituencywise_results AS cr 
ON cd.constituencyid = cr.constituencyid
WHERE cd.EVMvotes = (
        SELECT MAX(cd1.EVMvotes)
        FROM constituencywise_details AS cd1
        WHERE cd1.constituencyid = cd.constituencyid
    )
ORDER BY cd.EVMvotes DESC
LIMIT 10;


--END OF PROJECT--











	 


























