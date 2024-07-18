SELECT * 
FROM Hotel h 
JOIN Room r ON r.hotel_id = h.hotel_id 
JOIN Reservation rs ON rs.room_id = r.room_id 
WHERE h.hotel_id = 1  
  AND (('2024-07-18' BETWEEN rs.check_in_date AND rs.check_out_date 
        OR '2024-08-19' BETWEEN rs.check_in_date AND rs.check_out_date) 
       OR (rs.check_in_date BETWEEN '2024-07-18' AND '2024-08-19' 
           OR rs.check_out_date BETWEEN '2024-07-18' AND '2024-08-19')) 
  
ORDER BY h.hotel_id, r.room_id ASC;

SELECT COUNT(r.room_id) AS room_count
FROM Room r
JOIN Reservation re ON re.room_id = h.hotel_id
WHERE h.hotel_id = 1;
select * from Room r join Hotel h on r.hotel_id = h.hotel_id where h.hotel_id = 1
SELECT * FROM Hotel where hotel_address LIKE '%nha trang%' ;



SELECT COUNT(r.room_id) AS room_count
FROM Room r
JOIN Hotel h ON r.hotel_id = h.hotel_id
WHERE h.hotel_id = 1;


             