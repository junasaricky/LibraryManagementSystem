<<<<<<< HEAD
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

## Required Libraries

Make sure the following `.jar` files are present in the folder:  
`/WebContent/WEB-INF/lib/` or `/src/main/webapp/WEB-INF/lib/` (depending on your project structure):

- `gson-2.13.1.jar`
- `javax.activation-1.2.0.jar`
- `javax.mail.jar`
- `jstl-1.2.jar`
- `sqlite-jdbc-3.49.1.0.jar`

> **Note:** If these files are missing, download them manually and place them in the `WEB-INF/lib` folder so Eclipse/Tomcat can load them during runtime.

---

## How to Run
1. Clone this repository
2. Open in your favorite Java IDE (Eclipse/NetBeans/IntelliJ)
3. Configure server (Apache Tomcat)
4. Add SQLite JDBC driver
5. Run the project and open in browser

---

###	Java EE Setup Notes (Eclipse)

#### Add Java EE Runtime (e.g., Apache Tomcat)
If you're using **Eclipse**, make sure you configure the server properly:
1. Go to `Window` → `Preferences` → `Server` → `Runtime Environments`
2. Click **Add** → choose **Apache Tomcat**
3. Point to your Tomcat installation directory and click Finish

#### Fix – Missing Servlet API Errors
If you see errors like `javax.servlet.http.HttpServlet not found`, follow these steps:

1. **Right-click your project** → `Build Path` → `Configure Build Path`  
2. Go to the **Libraries** tab  
3. Ensure that **Apache Tomcat** or **Servlet API** is listed  
4. If **missing**:
   - Click **Add Library** → choose **Server Runtime**
   - Select your installed **Tomcat version**
   - Click **Finish**, then **Apply and Close*

---

## Author
**Ricky Junasa**  
For educational purposes only.  
GitHub: https://github.com/junasaricky/LibraryManagementSystem
Email: junasa.ricky@gmail.com

---

## License
MIT License
=======
# LibraryManagementSystem
>>>>>>> 01ae0721acdb5ce33675b8b6d6f6052d739384bb
