✈️ Flight Reservation System – SQL Project
📌 Overview
The Flight Reservation System is a relational database project designed to manage and analyze data related to flights, passengers, bookings, payments, and airline operations. This project is built using SQL and is ideal for showcasing database design, normalization, and complex query handling.

🧱 Features
Manage flight schedules and seat availability

Handle passenger bookings and ticketing

Track payment transactions

Generate reports for airlines and airports

Analyze revenue and booking trends

🗃️ Database Schema
📄 Tables Used:
Table Name	Description
Airlines	Stores information about airlines
Airports	Stores airport details (source & destination)
Flights	Contains flight schedules and pricing
Passengers	Stores passenger personal details
Bookings	Holds flight booking records
Tickets	Issues and tracks ticket status
Payments	Tracks payments for each ticket

🧩 ER Diagram (Text-based)
lua
Copy
Edit
Airlines ---< Flights >--- Airports (Source & Destination)
Passengers ---< Bookings >--- Tickets --- Payments

