I an example app for my coding style and architecture.

#Core data 
I am using Coredata for persistence. Coredata comes handy for support since it has built in support for searching, sorting, displaying and persisting data. CoreData model is divided into 2 sections. _CDMovie will be regenerated in the event of any change in model design, but CDMovie will never be regenerated. 

Models are also responsible for making their network requests.

We are using parent/child model for saving coredata objects.

# StoryBoard

We are using Storyboard, with combination of Xib’s so that story board stays small and manageable.


# Appdelegate

We have moved auto generated coredata code from app delegate to special singleton. Which also manages the coredata contexts. 