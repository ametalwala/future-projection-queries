Turnout for State House, Senate, and Congressional Districts for Georgia 

-- state house districts

SELECT
 --   p.vb_vf_source_state
    p.vb_vf_hd AS state_house_districts
	, SUM(ct.clarity_turnout_2022_v1 / 100)
	, SUM(ct.clarity_turnout_2022_v1 / 100) * 0.95 AS floor
	, SUM(ct.clarity_turnout_2022_v1 / 100) * 1.05 AS ceiling
FROM cpd_ngp.clarity_turnout_2022_v1_20220224 ct
LEFT JOIN 
(
SELECT * 
FROM ts.ntl_current p
WHERE LEFT(p.vb_voterbase_id, 2) = 'GA'
AND p.vb_vf_source_state = 'GA'
) p ON ct.voterbase_id = p.vb_voterbase_id
WHERE p.vb_vf_hd IN ('050', '151', '120', '043', '035', '097', '102', '116', '110', '065', '106', '126', '093', '062', '058', '059')
GROUP BY 1
ORDER BY 1 ASC; 

-- state senate districts 

SELECT
 --   p.vb_vf_source_state
   p.vb_vf_sd AS state_senate_districts
  , SUM(ct.clarity_turnout_2022_v1 / 100)
  , SUM(ct.clarity_turnout_2022_v1 / 100) * 0.95 AS floor
  , SUM(ct.clarity_turnout_2022_v1 / 100) * 1.05 AS ceiling
  , COUNT(DISTINCT(CASE WHEN p.vb_voterbase_registration_status = 'Registered'
      AND p.vb_voterbase_deceased_flag IS NULL
      AND p.vb_vf_voter_status IN ('Active', 'Inactive')
      THEN p.vb_smartvan_id ELSE NULL END)) AS unique_electorate
  , turnout::float/unique_electorate::float AS perc_turnout
  , floor::float/unique_electorate::float * 0.95 AS low_range
  , ceiling::float/unique_electorate::float * 1.05 AS high_range
FROM cpd_ngp.clarity_turnout_2022_v1_20220224 ct
LEFT JOIN 
(
SELECT * 
FROM ts.ntl_current p
WHERE LEFT(p.vb_voterbase_id, 2) = 'GA'
AND p.vb_vf_source_state = 'GA'
) p ON ct.voterbase_id = p.vb_voterbase_id
WHERE p.vb_vf_sd IN ('007', '006', '002', '017', '036')
GROUP BY 1
ORDER BY 1 ASC; 

-- state congressional districts 
SELECT
 --   p.vb_vf_source_state
    p.vb_vf_cd
	, SUM(ct.clarity_turnout_2022_v1 / 100)
	, SUM(ct.clarity_turnout_2022_v1 / 100) * 0.95 AS floor
	, SUM(ct.clarity_turnout_2022_v1 / 100) * 1.05 AS ceiling
FROM cpd_ngp.clarity_turnout_2022_v1_20220224 ct
LEFT JOIN 
(
SELECT * 
FROM ts.ntl_current p
WHERE LEFT(p.vb_voterbase_id, 2) = 'GA'
AND p.vb_vf_source_state = 'GA'
) p ON ct.voterbase_id = p.vb_voterbase_id
GROUP BY 1; 


-- ADD in where statements for specific districts 
-- HD 50
-- HD 151
-- HD 120
-- HD 43
-- HD 35
-- SD 7
-- HD 97
-- HD 102
-- SD 6
-- HD 116
-- SD 2
-- HD 110
-- HD 65
-- SD 17 
-- HD 106
-- HD 126
-- HD 93
-- HD 62
-- HD 58
-- HD 59
-- SD 36

-- state house districts

SELECT
 --   p.vb_vf_source_state
    p.vb_vf_hd AS state_house_districts
  , SUM(ct.clarity_turnout_2022_v1 / 100) AS turnout
  , SUM(ct.clarity_turnout_2022_v1 / 100) * 0.95 AS floor
  , SUM(ct.clarity_turnout_2022_v1 / 100) * 1.05 AS ceiling
  , COUNT(DISTINCT(CASE WHEN p.vb_voterbase_registration_status = 'Registered'
      AND p.vb_voterbase_deceased_flag IS NULL
      AND p.vb_vf_voter_status IN ('Active', 'Inactive')
      THEN p.vb_smartvan_id ELSE NULL END)) AS unique_electorate
  , turnout::float/unique_electorate::float AS perc_turnout
  , floor::float/unique_electorate::float AS low_range
  , ceiling::float/unique_electorate::float AS high_range
FROM cpd_ngp.clarity_turnout_2022_v1_20220224 ct
LEFT JOIN 
(
SELECT * asdfasdfasdfasdfasdfasdfasdf
FROM ts.ntl_current p
WHERE LEFT(p.vb_voterbase_id, 2) = 'GA'
AND p.vb_vf_source_state = 'GA'
) p ON ct.voterbase_id = p.vb_voterbase_id
WHERE p.vb_vf_hd IN ('050', '151', '120', '043', '035', '097', '102', '116', '110', '065', '106', '126', '093', '062', '058', '059')
GROUP BY 1
ORDER BY 1 ASC