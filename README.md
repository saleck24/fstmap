# fstmap

A Flutter-based mobile application designed to assist students and newcomers at the Faculty of Science and Technology in Nouakchott. The app helps users navigate the campus by searching for specific addresses using the search bar or exploring categories such as 'Rooms', 'Departments', 'Lecture Halls', and 'Administration'.

## Getting Started

1. Clone the Repository: git clone https://github.com/saleck24/fstmap.git
   
2. Install Dependencies: ensure Flutter is installed. Then, run: flutter pub get
   
3. Set Up WampServer:
   A) Download and install WampServer
   B) Start WampServer and open phpMyAdmin
   
4. Import the Database:
   A) Create a new database in phpMyAdmin
   B) Import the file 'FST_mysql.sql' into your newly created database
   
5. Configure the PHP Script:
   A) Open the file server_fst_bd.php'
   B) update it with your database credentials:
       <?php
      $servername = "localhost";
      $username = "your_database_username";
      $password = "your_database_password";
      $dbname = "your_database_name";
      ?>
   
6. Run the PHP Script:
   A) Place the PHP files in the 'www' directory of your WampServer
   B) Ensure WampServer is running and access the PHP script via your local server (e.g., http://localhost/your-php-script.php).
   
7. Run the Flutter Application:
   A) Connect your device or start an emulator
   B) Run the application.

