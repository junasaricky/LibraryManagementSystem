# Library Management System (LMS)

This is a full-featured **Library Management System** built with **Java (Servlets + JSP)** using **MVC architecture** and **SQLite** for backend database. It allows both Admin and Borrowers to manage and interact with the system efficiently.

## Technologies Used
- Java (JSP + Servlet)
- SQLite
- Bootstrap 5
- JSTL
- JavaScript
- HTML/CSS

---

## Features

### MVC Architecture
The project follows the **Model-View-Controller** design pattern for clean separation of concerns.

---

## Admin Features

### Menu:
- **Home/Dashboard**: View summary cards:
  - Total Books
  - Borrowed Books
  - Total Borrowers
  - Overdue Books
- **View Books**: View all books with options to **Edit** or **Delete**
- **Add Books**: Add new books to the database
- **Borrower’s Status**:
  - See all borrowers and their books
  - Track status: **Pending**, **Borrowed**, **Returned**, **Overdue**
  - **Confirm** borrow requests / **Return** books
  - **Export CSV** list of borrowed books
- **Admin Profile**: View and **edit own account**
- **Borrower List**: View all registered borrowers

### Email Notifications:
- Change Password
- Change Email
- Reset Password (with token verification)
- Confirm borrow request (notify borrower)

### Automation:
- **Auto Cancel Request**: If borrower does not pick up the physical book after a set time
- **Overdue Alert**: Email sent if borrowed book is close to being overdue

---

## Borrower Features

### Menu:
- **Home/Dashboard**: See number of:
  - Borrowed Books
  - Overdue Books
- **View Books**:
  - Browse **Available Books**
  - See own **Pending / Borrowed** books
  - Can **Borrow Books**
- **Borrower’s Status**: See real-time status of borrowed books
- **Borrower’s History**: View full borrowing history (Pending, Borrowed, Returned, Overdue)
- **Profile**: View and **edit own information**

### Email Notifications:
- Change Password
- Change Email
- Reset Password
- When borrowing books

---

## Login / Register System
- Secure login for Admin and Borrower
- Registration with email validation

---

## Error Handling
- Displays offline alerts when there is **no internet connection** (JavaScript-based)

---

## How to Run
1. Clone this repository
2. Open in your favorite Java IDE (Eclipse/NetBeans/IntelliJ)
3. Configure server (Apache Tomcat)
4. Add SQLite JDBC driver
5. Run the project and open in browser

---

## Author
**Ricky Junasa**  
For educational purposes only.  
GitHub: https://github.com/dashboard
Email: junasa.ricky@gmail.com

---

## License
MIT License
