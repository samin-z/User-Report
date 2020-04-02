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

**report-form.blade.php**

Route: http://localhost/digitalreporting/report/7

Controller: ReportController

this file contains “Report Form” codes, at the top are personal information of the user that is submitting the report, and at the following there are three fields.

week summary: a summary of the works done that week by the user.

Tasks done: a list of the tasks that user was able to do that week, by clicking on the (+) icon user can add to the fields and add more tasks.

Next Week Summary: a brief summary of users plan for next week.

Clicking on “submit-form” button, invokes an js event which send a ajax request with the form data to the controller(ReportController) using the routes that we have defined for it.

**cp-index.blade.php**

Route: http://localhost/digitalreporting/cp

Controller: PanelController

if any user other than Admin that was defnied in the database tries to reach this page they will get 403 error. this page contains a list of all reports submitted by users. there is also calendar browse at the header of the page, wethear you search for reports from a specific date to another date or just enter the date you want reports from to present date.

there is also a logout button at the top of the form, if no action is made in 10 minutes, user will be logged out automatically.

**report-view.blade.php**

Route: http://localhost/digitalreporting/cp/report/14

Controller:PanelController

By clicking on on the "view" link in control panel page, you get redirected to this page which presents an overview of the report submitted by the user. it contains the day it was submitted, user’s information, week summary, tasks done and next week summary. and by clicking on the “return to panel” you’re once again redirected to control panel’s index file.

**report-pdf-form.blade.php**

Route: http://localhost/digitalreporting/cp/pdf/12

Controller:PanelController

After clicking on on the "PDF" link in control panel page, the intended report is fetched from database and convert to PDF.

>Laravel  / app / Http / Controllers

**-HomeController.php**

the reason that function __construct was commented is that if a user tries to get access to the index page of our website, they’ll be redirected to login page, so in order to get access to main page you need to login to the website.

**function index**

returns index.blade.php from view folder to the users.

**-UserController.php**

**function store**

this controller only contains one function “store”. in this function first of all it checks the date and if it is not Friday, it will return an error for users that:

> users can submit their reports on Fridays!

because this condiction would stop the flow of the process, i just commented it, you can easily change the day on condition line:

>if(date(D) != ‘Fri’)

in the following, the next command line search the users table based on the “Email” arguman recieved from view, if a user matching the credentials is found, user gets redirected to “report-form.blade.php” page.

otherwise, if condition is met and validaor will check the “$request” values based on the predefined rules (required, string maximum and email true format), if all of the rules are applied then store a new record in users table. 

if not, jerror function along with the error made by validator is called. “jerror” function is in general_helper.php file (this file is in Helpers folder in Http folder). 

in summary, we send ajax request to the controller, contoller do the validation and if it fails returns the result with “jerror” function. this function convert the error to json string and replace the error fields in necessary  section.

at the end of function, if there was no error then “report form” route (http://localhost/digitalreporting/report/7) is returned to the jquery request and user automatically gets redirect to next page along with user’s id.

>jok(['url'=>route('report_form',['id'=>$user->id])]);

jok is a function with the same functionality like “jerro” with the only difference that it is for success status.

**-ReportController.php**

it contains two functions:

**function show**

this function has one arguman which is the id of the intended user which comes from UserController in the previous step. the reason is that if a user wantns to submit his report, they need to enter their information first. 

>$user = User(name of the model which conects to the database)::findOrFail($id);

**Note**:  findOrFail($id) takes an id and returns a single object. If no matching model exist, it throws an error.

if the result does not contain an error ,then in the following it returns the “report form” view along with the user object. in view page user’s information (name,last name) is shown at the top of the page.

**function store**

the information that users enter in report form fields is send to this function of the controller through ajax request.  first step is the validation to check if users filled all the necessary fields.  

next stage is checking if users exits, because when inserting report record we also have to represent which users is submitting the report., hence:

>$user = User::findOrFail($id);

next step we have two inserts, one inserting the report and then in the loop inserting all the tasks that are relevant to that report, so since these quesries are connected to eachother we place them in a transaction.

**Note**: The transaction in the database guarantees that several transactions on the database are all executed in parallel and conclusively, and if each transaction remains partially operational for various reasons including technical errors, hardware or software errors, the rest of the parallel transactions will not be executed.

first a new report record is inserted in our table, then we place 

>$request->input('task_stack')

which is an array of our tasks in a foreach loop, if anyof them is empty an error is return to the user otherwise the record along with the id of report is inserted in “report_tasks” table. 

after the operations, index route is returned for the user and get redirected to index page.

**-PanelController.php**

all the operations regarding Admin happens in this controller.

**function index**

In order  to prevent access to this panel, i use “is_admin “ column in users table to identify users with admin access which the value is 1 for admin. in the first condition it checks that if the logged in user’s “is_admin” value equals to 1 then proceed , else returns **403 error**.

if values “date_start” or “date_end” exist, then it should search queries that their “created_at” date is in the defiend interval. in the last command line, an array of searched reports along with logged in user model are returned with “cp-index” view.

**function view**

this function has one argument which is the id of intended report, by clicking on view button of any  report , a request with the ($id) of that report is sent to this function. by searching that id in the table , the result is returned and redirected to “report-view” view.

**function download**

this function get view file(report-pdf-form) and report model and convert the html file to pdf and return this file as end result. 

**function download_pdf**

this function converts a report html template to pdf.
