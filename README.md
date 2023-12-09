# Mobile
Mobile CRUD (JSP Servlet Model MVC2)

The mobile device data is stored in a table named `tbl_Mobile`. The structure of the `tbl_Mobile` table is specified as follows:

| Field Name        | Type                      |
|-------------------|---------------------------|
| mobileId          | varchar(10) – Primary Key |
| description       | varchar(250) – Not null   |
| price             | float                     |
| mobileName        | varchar(20) – Not null    |
| yearOfProduction  | int                       |
| quantity          | int                       |
| notSale           | bit (0: sale)             |

The application requires authentication to identify the members who can access the application. The authentication details are stored in a table named `tbl_User`.

| Field Name | Type                          |
|------------|-------------------------------|
| userId     | varchar (20) – Primary Key    |
| password   | int – Not null                |
| fullName   | varchar (50) – Not Null       |
| role       | int (0: user, 1: manager, 2: staff) |

Building the web site using MVC2 in JavaEE allows the following functions:

1. Login functionality for staff users and regular users.
2. Staff Functionality:
   - Search for a mobile device by ID or name.
   - Delete a mobile device from the data grid.
   - Update the price, description, quantity, and notSale status of a mobile device on the data grid.
   - Insert a new mobile device into the database.
3. User Functionality:
   - Search for a mobile device by price within a specified range (min, max).
   - Add a mobile device to the cart.
   - View the mobile cart and remove items.
   - Store the mobile devices to the database (specific implementation/design by the student).

All functions should be validated for security and ease of use.
