-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 10, 2025 at 05:49 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12
-- Airlines Table
CREATE TABLE Airlines (
    airline_id INT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(100)
);

-- Airports Table
CREATE TABLE Airports (
    airport_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);

-- Flights Table
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY,
    airline_id INT,
    source_airport_id INT,
    dest_airport_id INT,
    departure_time DATETIME,
    arrival_time DATETIME,
    total_seats INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id),
    FOREIGN KEY (source_airport_id) REFERENCES Airports(airport_id),
    FOREIGN KEY (dest_airport_id) REFERENCES Airports(airport_id)
);

-- Passengers Table
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    passport_no VARCHAR(20) UNIQUE,
    nationality VARCHAR(50)
);

-- Bookings Table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    passenger_id INT,
    flight_id INT,
    booking_date DATETIME,
    seat_no VARCHAR(10),
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

-- Tickets Table
CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY,
    booking_id INT,
    issue_date DATETIME,
    status VARCHAR(20), -- Confirmed, Cancelled
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    ticket_id INT,
    amount DECIMAL(10, 2),
    payment_date DATETIME,
    payment_method VARCHAR(20), -- Credit, UPI, etc.
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);

-- Database: `pro-flight_reservation_system`
--
INSERT INTO Airlines VALUES (1, 'IndiGo', 'India'), (2, 'Emirates', 'UAE');

INSERT INTO Airports VALUES
(101, 'Chhatrapati Shivaji Intl', 'Mumbai', 'India'),
(102, 'Dubai Intl', 'Dubai', 'UAE');

INSERT INTO Flights VALUES
(201, 1, 101, 102, '2025-07-15 10:00', '2025-07-15 14:00', 180, 8500.00);

INSERT INTO Passengers VALUES
(301, 'Shrutika Kadam', 'Female', 'A1234567', 'India');

INSERT INTO Bookings VALUES
(401, 301, 201, '2025-07-10 12:00', '14A');

INSERT INTO Tickets VALUES
(501, 401, '2025-07-10 12:10', 'Confirmed');

INSERT INTO Payments VALUES
(601, 501, 8500.00, '2025-07-10 12:15', 'UPI');

-- --------------------------------------------------------

--
SELECT f.total_seats - COUNT(b.booking_id) AS available_seats
FROM Flights f
LEFT JOIN Bookings b ON f.flight_id = b.flight_id
WHERE f.flight_id = 201
GROUP BY f.total_seats;

--
-- Dumping data for table `Airlines`
--
SELECT f.flight_id, COUNT(b.booking_id) AS total_bookings
FROM Flights f
JOIN Bookings b ON f.flight_id = b.flight_id
GROUP BY f.flight_id
ORDER BY total_bookings DESC;


--
-- Indexes for dumped tables
--
SELECT a.name AS airline, SUM(p.amount) AS total_revenue
FROM Airlines a
JOIN Flights f ON a.airline_id = f.airline_id
JOIN Bookings b ON f.flight_id = b.flight_id
JOIN Tickets t ON b.booking_id = t.booking_id
JOIN Payments p ON t.ticket_id = p.ticket_id
GROUP BY a.name
ORDER BY total_revenue DESC;

--
-- Indexes for table `Airlines`
SELECT p.full_name, f.flight_id, f.departure_time, t.status, pay.amount
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Tickets t ON b.booking_id = t.booking_id
JOIN Payments pay ON t.ticket_id = pay.ticket_id
WHERE p.passport_no = 'A1234567';


SELECT f.flight_id, f.departure_time, f.arrival_time, a.name AS airline
FROM Flights f
JOIN Airlines a ON f.airline_id = a.airline_id
WHERE f.source_airport_id = 101 AND f.dest_airport_id = 102;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
