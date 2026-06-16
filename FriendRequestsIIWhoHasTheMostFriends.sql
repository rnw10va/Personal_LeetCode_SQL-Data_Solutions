/*
Problem Name: Friend Requests II: Who Has the Most Friends
Problem Link: https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/
Problem Description:
Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.

The result format is in the following example.

Example 1:
Input: 
RequestAccepted table:
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |
+--------------+-------------+-------------+
Output: 
+----+-----+
| id | num |
+----+-----+
| 3  | 3   |
+----+-----+
Explanation: 
The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.
*/

--My Solution
SELECT TOP 1
CASE
    WHEN requester_id IS NOT NULL THEN requester_id
    ELSE accepter_id
END AS id,
COALESCE(requester_id_count,0)+COALESCE(accepter_id_count,0) AS num
FROM (
    SELECT 
        requester_id,
        COUNT(requester_id) AS requester_id_count
    FROM RequestAccepted
    GROUP BY requester_id
) AS R1
FULL OUTER JOIN (
    SELECT
        accepter_id,
        COUNT(accepter_id) as accepter_id_count
    FROM RequestAccepted
    GROUP BY accepter_id
) AS R2
ON R1.requester_id = R2.accepter_id
GROUP BY R1.requester_id, R2.accepter_id, R1.requester_id_count, R2.accepter_id_count
ORDER BY num DESC