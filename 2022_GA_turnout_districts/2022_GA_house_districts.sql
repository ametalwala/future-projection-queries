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
SELECT * 
FROM ts.ntl_current p
WHERE LEFT(p.vb_voterbase_id, 2) = 'GA'
AND p.vb_vf_source_state = 'GA'
) p ON ct.voterbase_id = p.vb_voterbase_id
WHERE p.vb_vf_hd IN ('050', '151', '120', '043', '035', '097', '102', '116', '110', '065', '106', '126', '093', '062', '058', '059')
GROUP BY 1
ORDER BY 1 ASC