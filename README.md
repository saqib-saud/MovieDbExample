
[Read the back story first] (https://github.com/wisesabre/MovieDbExample/wiki)



That was old story. 

### MVC ###

Most of the times Controllers get so large that after first few iterations it becomes cumbersome to manage large Controllers. In effort to thin the Controllers, I have moved some of the network logic intro Models. Ideally controllers and models, both should be thin. I disagree with people who say that model should be dumb.

Depending on the nature of application, network logic in models might prove a bad idea (e.g if too many requests are used to create model or network requests out lives the models). However, in our scenario, shifting logic to model is the best idea. 

Alternatively, you can also move network logic to seperate network manager layer. 


Following things have been improved
* Improved unit test cases, more Coredata related unit tests are coming. 
* Removed tableview datasource from controller, into a seperate class. 
* Extracted the coredata persistence related details into separate class from model 

Pending

* Full writeup about the design decisions.
* some unit test (mocking objects) can better be written in swift, so prolly i should port code to swift. 