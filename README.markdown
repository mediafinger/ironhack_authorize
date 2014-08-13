# Authorize App (based on Projects and Tasks App)

## How to install
Clone, bundle, create (postgres) database, migrate, seed --> ready to rumble!

##  TODO (optional)
* Display tasks as a Scrum / Kanban Board
    * create a layout with the 3 columns todo, doing, done
    * display the tasks in the according columns as cards
    * display project name on the cards
    * display user on the cards
    * diplay task name on the cards
    * diplay updated_at on the cards
    * diplay optional deadline on the cards (new field!)
    * create filters to filter by projects and user
    * create new project and new task functionality outside of the board
    * add drag and drop functionality to move cards into new status
    * order done column by updated_at DESC
    * let po order todo column and save the position of the tasks
    * optional: make number and names of columns between todo and done configurable by admin
    * optional: provide some statistics about flow times per status / project / user
* _Hint: if you put some effort into this, to make it nice, it might be a good small app to show in an application process, as task boards are something every developer knows_ ;-)
    * but to present it, it needs a full test suite!

## Done
Implemented a User model and a Role model into Projects and Tasks App -
using rails has_secure_password and sending emails with authentication token.

### Steps
1. create a User model
    * attribute: email
    * validate that email is unique
    * how to validate if this is a real email?
2. create Relation between Projects and Users
    * User has_and_belongs_to_many Projects
    * create and run migration
3. create Relation between Tasks and Users
    * User has_many Tasks
    * every Task belongs_to a User
    * create and run migration
4. write a script in the seeds file
    * create 4 users
    * create 10 projects
    * add every user to some projects
    * create a few tasks for every user in each of his projects
5. Test if everythings works so far
    * optional: write some specs
6. Authentication preparation
    * Allow Users to sign up on the website, create Controller#new, view and route
    * ask for email, password and password_confirmation in the form
    * do not write a migration yet, use the password as virtual attribute
    * create validations for password and password confirmation
7. Authentication
    * In the User use: has_secure_password validations: false
    * migrate the tring :password_digest to the user
    * check that the bcrypt gem is bundled
    * create a SessionController with #new and #create actions
    * if User.find(email) && user.authenticate(password) then session[:user_id] = user.id
    * Log-in works now - add a current_user method to the ApplicationController
    * make it available to the views through helper_method :current_user
    * now enable Users to Log-out through a Session#destroy action
    * Finally we will secure access to Projects and Tasks so only authenticated Users will have access - write a before_filter that expects a current_user
    * optional: log Users in after Sign-up
    * optional (lots of) cleanup, i.e. better navigation...
8. Account Activation / Confirmation Email (optional)
    * create a unique one-time token on signup
    * send the user an email that includes a link with the one-time token
    * when the user hits the link his email address is confirmed
    * the token has to be deleted
    * the information that the email is confirmed has to be saved
    * in the session controller we have to check this information
    * hint: use the letter_opener gem for development
9. Use Token to identify session (optional)
    * now that we have the token mechanism, we should use it to add more security
    * instead of saving the user_id in the session, we should save a token
    * optional: invalidate session tokens after an expire time of 48 hours
10. Authorization
    * include pundit gem
    * create 3 roles for User: admin, po, developer (developer is default)
    * add Policies for both models and all roles (do it step by step!)
    * Developer
        * can create tasks for himself
        * can update his own tasks
        * can see all tasks in all his projects
        * can not see other projects or tasks in other projects
    * PO
        * is allowed to do everything Developers are allowed to do
        * + can see all projects and all tasks
        * + can create projects
    * Admin
        * is allowed to do everything other Users are allowed to do
        * + can update and delete all projects
        * + can update and delete all tasks
11. Business Logic in Service classes
12. Asynchronous Background Jobs with gem: sucker_punch and server gem: puma
13. A rake task
14. A schedule for cron jobs with gem: whenever
