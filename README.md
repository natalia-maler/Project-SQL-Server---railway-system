# Project-SQL-Server---railway-system
Railway system diagram with online ticket booking
Creation of a database on the railway network to handle train schedules, passenger journeys, information about stations and more. The system facilitates ticket booking, train service, ticket cancellation.

Functionalities:
- The system will contain information about trains, such as train name, number of carriages, train type (carrier name). This will create a pool of trains from which we will be able to select available trains to plan a new trip.

- You can create a table - technical details of trains, which stores technical details of each train, such as engine power, manufacturer, year of production. Each train would have exactly one record in this table, which would create a one-to-one relationship.
- The system will have a schedule table that will record the train schedules including the start time, end time, source, destination and the route the train will take and the duration and departure platform. 
- The system also requires a station name list that will provide information about each station such as the station name and the city or state it belongs to. 
- There is also a route information table that contains information about the route the train will take between the source and destination stations.
- Passengers purchasing tickets online log in to their account to download the ticket, check the status of the reservation, and make payments. The table contains the name, surname, address, and password to log in to their account.
- The system contains ticket reservations, allowing you to select the starting and source stations, ticket type with the corresponding discount, carriage number, and seat. It provides information about the reservation date, status, and planned departure and arrival time to a specific location.
- The payment table provides information about the amount, method, and date of a given reservation.
- The delay table contains the time and reason why the train is delayed from a given schedule.
- The ticket_cancellation table stores information about reservation cancellations, including the reason for cancellation, reservation ID, refund status, refund amount, date.
