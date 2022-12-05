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

