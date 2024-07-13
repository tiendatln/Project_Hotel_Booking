-- Create the database
CREATE DATABASE Room_Booking_website;
GO

-- Use the database
USE Room_Booking_website;
GO

-- Create tables
CREATE TABLE Account(
    [username] NVARCHAR(50) PRIMARY KEY,
    [password] NVARCHAR(32),
    is_owner BIT,
    is_manager BIT,
    is_admin BIT,
    ban_status BIT,
    report_count INT, 
    email VARCHAR(100),
    [name] NVARCHAR(50),
    age INT,
    phone VARCHAR(10),
    id_number VARCHAR(20)
);


CREATE TABLE Hotel(
    hotel_id INT PRIMARY KEY IDENTITY(1,1),
    hotel_name NVARCHAR(50),
    hotel_address NVARCHAR(300),
    hotel_img VARCHAR(100),
    hotel_description NVARCHAR(200),
    username NVARCHAR(50) FOREIGN KEY REFERENCES Account(username)

);

CREATE TABLE RoomType(
    room_type_id INT PRIMARY KEY IDENTITY(1,1),
    name_type VARCHAR(50),
    room_capacity INT
);

CREATE TABLE Room(
    room_id INT PRIMARY KEY IDENTITY(1,1),
    room_name VARCHAR(50),
    room_price MONEY,
    room_img VARCHAR(100),
    room_status BIT,
    room_description NVARCHAR(500),
    room_type_id INT FOREIGN KEY REFERENCES RoomType(room_type_id),
    hotel_id INT FOREIGN KEY REFERENCES Hotel(hotel_id)
);

CREATE TABLE [Service](
    service_id INT PRIMARY KEY IDENTITY(1,1),
	[service_name] varchar(50),
    service_price MONEY,
	hotel_id INT FOREIGN KEY REFERENCES Hotel(hotel_id)
	
);


CREATE TABLE Feedback(
    feedback_id INT PRIMARY KEY IDENTITY(1,1),
    comment NVARCHAR(200),
    username NVARCHAR(50) FOREIGN KEY REFERENCES Account(username),
    hotel_id INT FOREIGN KEY REFERENCES Hotel(hotel_id),
    room_id INT FOREIGN KEY REFERENCES Room(room_id)
);

CREATE TABLE Reservation(
    re_id INT PRIMARY KEY IDENTITY(1,1),
    [status] INT,
    re_date DATE,
    quantity INT,
    check_in_date DATE,
    check_out_date DATE,
    list_price MONEY,
    room_id INT FOREIGN KEY REFERENCES Room(room_id),
    service_id INT FOREIGN KEY REFERENCES [Service](service_id),
    username NVARCHAR(50) FOREIGN KEY REFERENCES Account(username)
);

-- Insert sample data into Account table with MD5 hashed passwords
INSERT INTO Account (username, [password], is_owner, is_manager, is_admin, ban_status, report_count, email, [name], age, phone, id_number) 
VALUES 
('johndoe', CONVERT(NVARCHAR(32), HASHBYTES('MD5', 'password123'), 2), 1, 0, 0, 0, 0, 'johndoe@example.com', 'John Doe', 30, '1234567890', 'ID1234567890'),
('janedoe22', CONVERT(NVARCHAR(32), HASHBYTES('MD5', 'password456'), 2), 0, 1, 0, 0, 0, 'janedoe@example.com', 'Jane Doe', 28, '0987654321', 'ID0987654321');

-- Insert sample data into Service table


-- Insert sample data into Hotel table
INSERT INTO Hotel (hotel_name, hotel_address, hotel_img, hotel_description, username) VALUES 
('Vinpearl Resort Nha Trang', 'Hon Tre Island, Vinh Nguyen, Nha Trang, Khanh Hoa, Vietnam', 'vinpearl_nhatrang.jpg', 'A luxurious resort located on the beautiful Hon Tre Island.', 'johndoe'),
('InterContinental Danang Sun Peninsula Resort', 'Bai Bac, Son Tra Peninsula, Da Nang, Vietnam', 'intercontinental_danang.jpg', 'A five-star beach resort nestled in the heart of the Son Tra Peninsula nature reserve.', 'johndoe'),
('The Reverie Saigon', '22-36 Nguyen Hue Boulevard, District 1, Ho Chi Minh City, Vietnam', 'reverie_saigon.jpg', 'An opulent hotel located in the heart of Ho Chi Minh City.', 'johndoe'),
('Furama Resort Danang', '105 Vo Nguyen Giap Street, Khue My Ward, Ngu Hanh Son District, Da Nang, Vietnam', 'furama_danang.jpg', 'A stunning beachfront resort in Da Nang.', 'johndoe'),
('JW Marriott Phu Quoc Emerald Bay Resort & Spa', 'Bai Khem, Phu Quoc, Kien Giang, Vietnam', 'jwmarriott_phuquoc.jpg', 'A luxurious resort located on the pristine beach of Bai Khem.', 'johndoe'),
('Amanoi', 'Vinh Hy Village, Vinh Hai Commune, Ninh Hai District, Ninh Thuan Province, Vietnam', 'amanoi.jpg', 'A serene retreat overlooking Vinh Hy Bay.', 'johndoe'),
('Hyatt Regency Danang Resort and Spa', '05 Truong Sa Street, Hoa Hai Ward, Ngu Hanh Son District, Da Nang, Vietnam', 'hyatt_regency_danang.jpg', 'A luxurious resort offering stunning views of the East Sea.', 'johndoe'),
('Six Senses Con Dao', 'Dat Doc Beach, Con Dao District, Ba Ria-Vung Tau Province, Vietnam', 'six_senses_condao.jpg', 'A five-star eco-friendly resort on Con Dao Island.', 'johndoe'),
('Pullman Danang Beach Resort', '101 Vo Nguyen Giap Street, Khue My Ward, Ngu Hanh Son District, Da Nang, Vietnam', 'pullman_danang.jpg', 'A contemporary beachfront resort in Da Nang.', 'johndoe'),
('Sofitel Legend Metropole Hanoi', '15 Ngo Quyen Street, Hoan Kiem District, Hanoi, Vietnam', 'sofitel_metropole_hanoi.jpg', 'A historic luxury hotel in the heart of Hanoi.', 'johndoe');

-- Insert sample data into RoomType table
INSERT INTO RoomType (name_type, room_capacity) VALUES 
('Single', 1),
('Double', 2);

-- Insert sample data into Room table
INSERT INTO Room (room_name, room_price, room_img, room_status, room_description, room_type_id, hotel_id) VALUES
('Deluxe Ocean View', 300, 'deluxe_ocean_view.jpg', 1, 'A room with a stunning view of the ocean.', 1, 1),
('Suite with Balcony', 500, 'suite_balcony.jpg', 1, 'A spacious suite with a private balcony.', 2, 1),
('Standard Room', 150, 'standard_room.jpg', 1, 'A comfortable room with all basic amenities.', 1, 2),
('Presidential Suite', 1000, 'presidential_suite.jpg', 1, 'The most luxurious suite in the hotel.', 2, 3),
('Family Suite', 600, 'family_suite.jpg', 1, 'A large suite suitable for families.', 2, 4),
('Junior Suite', 400, 'junior_suite.jpg', 1, 'A small but luxurious suite.', 2, 5),
('Garden View Room', 250, 'garden_view.jpg', 1, 'A room with a beautiful view of the garden.', 1, 6),
('Penthouse Suite', 1200, 'penthouse_suite.jpg', 1, 'An extravagant suite on the top floor.', 2, 7),
('Beachfront Room', 350, 'beachfront_room.jpg', 1, 'A room right on the beach.', 1, 8),
('City View Room', 200, 'city_view.jpg', 1, 'A room with a view of the city skyline.', 1, 9),
('Historic Room', 450, 'historic_room.jpg', 1, 'A room with a touch of history.', 1, 10);

-- Insert sample data into Service table
INSERT INTO [Service] (service_name, service_price, hotel_id) VALUES 
('Room Service', 50.00, 1 ),
('Spa', 100.00, 1),
('Laundry Service', 20.00, 2),
('Airport Shuttle', 30.00, 3),
('Breakfast Buffet', 15.00, 4),
('Gym Access', 25.00, 5),
('Wi-Fi Access', 10.00, 6),
('Parking', 15.00, 7),
('Swimming Pool Access', 20.00, 8),
('Concierge Service', 50.00, 9),
('Daily Housekeeping', 30.00, 10),
('Mini Bar', 25.00, 1),
('In-room Dining', 40.00, 2),
('Massage Therapy', 70.00, 3),
('Conference Room Access', 100.00, 4);

-- Insert sample data into Feedback table
INSERT INTO Feedback (comment, username, hotel_id, room_id) VALUES 
('Great stay!', 'johndoe', 1, 1),
('Very spooky!', 'janedoe22', 2, 1);

-- Insert sample data into Reservation table
INSERT INTO Reservation (status, re_date, quantity, check_in_date, check_out_date, list_price, room_id, service_id, username) VALUES 
(1, '2024-06-01', 2, '2024-06-10', '2024-06-15', 600.00, 1, 1, 'johndoe'),
(2, '2024-06-05', 1, '2024-06-20', '2024-06-22', 300.00, 2, 2, 'janedoe22'),
(3, '2024-06-10', 3, '2024-07-01', '2024-07-05', 1000.00, 3, 3, 'johndoe'),
(4, '2024-06-15', 4, '2024-07-10', '2024-07-20', 1500.00, 4, 4, 'janedoe22'),
(5, '2024-06-20', 2, '2024-07-25', '2024-07-30', 800.00, 5, 5, 'johndoe'),
(6, '2024-06-25', 1, '2024-08-01', '2024-08-05', 450.00, 6, 6, 'janedoe22'),
(7, '2024-07-01', 3, '2024-08-10', '2024-08-15', 900.00, 7, 7, 'johndoe'),
(8, '2024-07-05', 2, '2024-08-20', '2024-08-25', 700.00, 8, 8, 'janedoe22'),
(9, '2024-07-10', 1, '2024-09-01', '2024-09-05', 400.00, 9, 9, 'johndoe'),
(10, '2024-07-15', 4, '2024-09-10', '2024-09-15', 1200.00, 10, 10, 'janedoe22');




SELECT * FROM Room r join Hotel h on r.hotel_id = h.hotel_id join RoomType rt on r.room_type_id = rt.room_type_id join [Service] s on s.room_id = r.room_id where h.hotel_address LIKE '%hanoi%'