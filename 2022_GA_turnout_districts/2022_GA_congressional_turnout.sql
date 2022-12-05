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