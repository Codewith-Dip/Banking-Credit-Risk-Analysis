-- =========================================================
-- BANKING CREDIT RISK ANALYSIS
-- SQL BUSINESS ANALYSIS
-- =========================================================




-- =========================================================
-- 1. PORTFOLIO KPIs
-- =========================================================
USE banking_credit_risk;
SELECT
    COUNT(*) AS total_loans,
    ROUND(SUM(loan_amnt), 2) AS total_loan_exposure,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount,
    SUM(`Default`) AS defaulted_loans,
    ROUND(AVG(`Default`) * 100, 2) AS overall_default_rate
FROM loans;

-- =========================================================
-- 2.FICO VS DEFAULTANALYSIS
-- =========================================================

USE banking_credit_risk;

SELECT
    fico_group,
    COUNT(*) AS loan_count,
    ROUND(AVG(`Default`) * 100, 2) AS default_rate
FROM
(
    SELECT
        CASE
            WHEN fico_n < 650 THEN 'Below 650'
            WHEN fico_n < 700 THEN '650-699'
            WHEN fico_n < 750 THEN '700-749'
            ELSE '750+'
        END AS fico_group,
        `Default`
    FROM loans
) AS fico_data
GROUP BY fico_group
ORDER BY
    CASE fico_group
        WHEN 'Below 650' THEN 1
        WHEN '650-699' THEN 2
        WHEN '700-749' THEN 3
        WHEN '750+' THEN 4
    END;
    
-- =========================================================
-- 3.DTI ANALYSIS
-- =========================================================    

USE banking_credit_risk;

SELECT
    dti_group,
    COUNT(*) AS loan_count,
    ROUND(AVG(`Default`) * 100, 2) AS default_rate
FROM
(
    SELECT
        CASE
            WHEN dti_n < 10 THEN '<10'
            WHEN dti_n < 20 THEN '10-20'
            WHEN dti_n < 30 THEN '20-30'
            WHEN dti_n < 40 THEN '30-40'
            ELSE '40+'
        END AS dti_group,
        `Default`
    FROM loans
) AS dti_data
GROUP BY dti_group
ORDER BY
    CASE dti_group
        WHEN '<10' THEN 1
        WHEN '10-20' THEN 2
        WHEN '20-30' THEN 3
        WHEN '30-40' THEN 4
        WHEN '40+' THEN 5
    END;
    
-- =========================================================
-- 4.LOAN MOUNT VS DEFAULTS
-- =========================================================   

USE banking_credit_risk;

SELECT
    loan_group,
    COUNT(*) AS loan_count,
    ROUND(AVG(`Default`) * 100, 2) AS default_rate
FROM
(
    SELECT
        CASE
            WHEN loan_amnt < 5000 THEN '<5k'
            WHEN loan_amnt < 10000 THEN '5k-10k'
            WHEN loan_amnt < 20000 THEN '10k-20k'
            WHEN loan_amnt < 30000 THEN '20k-30k'
            ELSE '30k+'
        END AS loan_group,
        `Default`
    FROM loans
) AS loan_data
GROUP BY loan_group
ORDER BY
    CASE loan_group
        WHEN '<5k' THEN 1
        WHEN '5k-10k' THEN 2
        WHEN '10k-20k' THEN 3
        WHEN '20k-30k' THEN 4
        WHEN '30k+' THEN 5
    END;
    
-- =========================================================
-- 5.LOAN PURPOSE VS DEFAULTS
-- ========================================================= 
USE banking_credit_risk;

SELECT
    purpose,
    COUNT(*) AS loan_count,
    ROUND(AVG(`Default`) * 100, 2) AS default_rate
FROM loans
GROUP BY purpose
ORDER BY default_rate DESC;

-- =========================================================
-- 6.HOME OWNERSHIP VS DEFAULTS
-- =========================================================   
 use banking_credit_risk;
 select 
	home_ownership_n as home_owner,
    count(*) as loan_count,
    round(avg(`Default`) * 100, 2) as default_rate
 from loans
 group by home_ownership_n
 order by default_rate DESC;
	
-- =========================================================
-- 7. DEFAULTS BY YEAR 
-- =========================================================   
use banking_credit_risk;
select
	issue_year,
    count(*) as loan_count,
    ROUND(SUM(loan_amnt), 2) as total_exposure,
    round(AVG(loan_amnt), 2) as average_amount,
    round(avg(`Default`) * 100, 2) as default_rate
FROM loans
group by issue_year
order by issue_year DESC;

-- =========================================================
-- 8.FICO + DTI Risk Matrix
-- =========================================================   
use banking_credit_risk;
select 
	fico_group,
    dti_group,
    count(*) as loan_count,
    round(avg(`Default`) * 100, 2) as default_rate
from (
	select 
		case
			when fico_n < 650 then 'Below 650'
            when fico_n < 700 then '650 - 699'
            when fico_n < 750 then '700 - 749'
            else '750+'
		end as fico_group,
        
        case 
			when dti_n < 10 then '<10'
            when dti_n <20 then '10 - 20'
            when dti_n < 30 then '20 - 30'
            when dti_n < 40 then '30 - 40'
            else '40+'
		end as dti_group,
		`Default`
	from loans
) as risk_data

group by 
	fico_group,
    dti_group
order by 
	case fico_group
		WHEN 'Below 650' THEN 1
        WHEN '650-699' THEN 2
        WHEN '700-749' THEN 3
        WHEN '750+' THEN 4
    END,
    case dti_group
		 WHEN '<10' THEN 1
        WHEN '10-20' THEN 2
        WHEN '20-30' THEN 3
        WHEN '30-40' THEN 4
        WHEN '40+' THEN 5
    END;

-- =========================================================
-- 9.Final Risk Category Analysis
-- ========================================================= 
use banking_credit_risk;
select 
	risk_category,
    COUNT(*) AS loan_count,
    ROUND(SUM(loan_amnt), 2) AS total_exposure,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount,
    ROUND(AVG(`Default`) * 100, 2) AS default_rate
from loans 
group by risk_category
order by
	case risk_category
		when 'High Risk' then 1
		when 'Medium Risk' then 2
        when 'Low Risk' then 3
	end;