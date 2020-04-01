# reporting

On Friday every team member has to write a short reporting for their team lead.
The reporting consists of the calendar week for which it is done, the name of the team member and
current as well as upcoming issues – what happened this week, which tasks did they finish and what
is planned for the next week.


# Prerequisites
```
o	Framerwork			: Laravel 7.3 /
o	Databse			        : Mysql 5.7 /
o	Webserver			: Wamp /
o	Database administration tool	: phpmyadmin /
o	Editor				: phpstorm  /
o	Programming Language            : PHP 7.2  /
o	CSS framework			: Bootstrap 4 /
```
# Installing
creating project using command line:
	composer create-project laravel/laravel (name of the project)
	
   forexample this project was:

	composer create-project laravel/laravel digitalreporting
	
   URL : http://localhost/digitalreporting/
address to project folder:
       wamp > www > digitalreporting
					
Project other than “,htaccess” and “index.php” file consist of two folders:

**Laravel**: contains framework and php scripts.

**Public**: contains static files (images/css/js...)

**Note**: digital_reporting.sql file in repository is SQL file which you can easily import to your database.

**Note2**: since Admin user ‘s “is_admin” flag is change manually (changed from 0 to 1) you can just import this sql file, or if planning on migrating after inserting a new user go to database and change value of “is_admin” from 0 to 1.

Laravel is a MVC framework, and three folders (views,Controller and models ) contain the core of our coding.

**step one:**

database is created using phpmyadmin and the connection to the databse is made through “.env” file, which is placed in Laravel folder.
```
DB_DATABASE=digital_reporting
DB_USERNAME=root
DB_PASSWORD=
```
**step two:**

Along creating Models using this command line.

> php artisan make:model  User –m

“-m” is a flag which means that in addition to model create migration too. by going to “migrations” director (database / migrations), all our tables are in this folder and we can define our fields.

An example for users table:

```
$table->string ('password',100);
$table->char   ('name' , 50 );
$table->char   ('last_name' , 50 );
```

after defining the tables and fields structure, by using this command tables are created in the database.

> php artisan migrate

**View Folder:**

all view files are placed in “ resources/views"  directory. our main view is master which contains the main frame for our design and other pages are loaded inside it.

**-index.blade.php**

Route: http://localhost/digitalreporting/

Controller: UserController

contains “member form”, users enter their personal infomation in this form, it also works as a log in page too, so if a user already submitted his report they can easily redirect to “report form” and submit another report. if it’s users first time, then before redireting a new record is inserted for user in “users” table and then the user is redirected. 

clicking on “submit-form” button, invokes an js event which send a ajax request with the form data to the controller using the routes that we have defined for it in “web.php” file. you can find javascript codes inside “scripts.js” file.

**Note:** web.php file can be found in “routes” folder.

**Note2:** Blade is the built in templating engine for Laravel.

