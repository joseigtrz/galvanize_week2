/*
SELECT userid,
	CASE
		WHEN userid in (SELECT DISTINCT userid FROM optout) THEN 1
		ELSE 0
	END AS optout
FROM logins
*/
WITH logins_rank AS (
	SELECT 
		 userid
		,tmstmp AS last_login
		,ROW_NUMBER() OVER(PARTITION BY userid 
							ORDER BY tmstmp desc) AS row_num
	FROM logins B       
	WHERE DATEDIFF(DAY, B.tmstmp, '2014-08-14') >=-7
), logins_day AS (
	SELECT userid, COUNT(distinct cast(tmstmp as DATE)) AS login_7d
	FROM logins
	WHERE tmstmp > dateadd(day, -7, '2014-08-14')
	GROUP BY userid
), logins_mobile AS (
	SELECT userid, COUNT(distinct cast(tmstmp as DATE)) AS login_7d_mobile
	FROM logins
	WHERE tmstmp > dateadd(day, -7, '2014-08-14')
	AND [type] = 'mobile' 
	GROUP BY userid
), logins_web AS (
	SELECT userid, COUNT(distinct cast(tmstmp as DATE)) AS login_7d_web
	FROM logins
	WHERE tmstmp > dateadd(day, -7, '2014-08-14')
	AND [type] = 'web' 
	GROUP BY userid
) SELECT  A.userid,
    D. last_login,
    A.login_7d,
    B.login_7d_mobile,
    C.login_7d_web,
    CASE
        WHEN A.userid in (SELECT DISTINCT E.userid FROM optout E) THEN 1
        ELSE 0
    END AS optout                        
FROM logins_day A
LEFT JOIN logins_mobile B
ON A.userid = B.userid
LEFT JOIN logins_web C
ON A.userid = C.userid
LEFT JOIN logins_rank D
ON A.userid = D.userid


WITH logins_rank AS (
	SELECT 
		 userid
		,tmstmp AS last_login
		,ROW_NUMBER() OVER(PARTITION BY userid 
							ORDER BY tmstmp desc) AS row_num
	FROM logins B       
	WHERE DATEDIFF(DAY, B.tmstmp, '2014-08-14') >=-7
) SELECT * FROM logins_rank
ORDER BY userid desc, last_login desc, row_num asc