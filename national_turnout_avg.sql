SELECT
	SUM(ct.clarity_turnout_2022_v1 / 100)
	, SUM(ct.clarity_turnout_2022_v1 / 100) * 0.95 AS floor
	, SUM(ct.clarity_turnout_2022_v1 / 100) * 1.05 AS ceiling
FROM cpd_ngp.clarity_turnout_2022_v1 ct
