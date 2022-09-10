SELECT
	SUM(ct.clarity_turnout_2022_v1 / 100)
	, SUM(ct.clarity_turnout_2022_v1 / 100) * 0.95 AS floor
	, SUM(ct.clarity_turnout_2022_v1 / 100) * 1.05 AS ceiling
FROM cpd_ngp.clarity_turnout_2022_v1 ct
; 


--  use updated table !! 
SELECT
	SUM(ct.clarity_turnout_2022_v1 / 100)
	, SUM(ct.clarity_turnout_2022_v1 / 100) * 0.95 AS floor
	, SUM(ct.clarity_turnout_2022_v1 / 100) * 1.05 AS ceiling
FROM cpd_ngp.clarity_turnout_2022_v1_20220224 ct
; 

SELECT
	SUM(ct.clarity_turnout_2022_v1 / 100)
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
; 


--56 senators; 180 house 


-- SELECT 
--     vb_tsmart_sd
--     , vb_tsmart_hd
--     , vb_tsmart_cd
-- FROM ts.ntl_current
-- WHERE vb_vf_source_state = 'GA'
-- AND LEFT(vb_voterbase_id, 2) = 'GA'
-- ; 