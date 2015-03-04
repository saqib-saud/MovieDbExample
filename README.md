
[Read the back story first] (https://github.com/wisesabre/MovieDbExample/wiki)



That was old story. 

### MVC ###

Most of the times Controllers get so large that first few iterations it becomes cumbersome to manage large Controllers. In effort to thin the Controllers, I have moved some of the network logic intro Models. 

Depending on the nature of application, network logic in models might prove a bad idea (e.g if too many requests are used to create model or network requests out lives the models). However, in our scenario, shifting logic to model is the best idea. 

Alternatively, you can also move network logic to seperate network manager layer. 


* Improved unit test cases, more Coredata related unit tests are coming. 
* Removed tableview datasource from controller, into a seperate class. 