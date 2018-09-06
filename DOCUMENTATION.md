# Documentation of the changes made

In the refactoring of this code, the first thing I noticed was the fact that there was no protected module. The protected module keeps methods from being mistakenly called. So, the first thing I did was to add the protected module. I also noticed that the articleParams method was improperly named so I renamed it article_params everywhere it was called.

Next, I noticed that the index method was too long. I resolved to take out articles_type and articles_boundary. The articles_boundary was also used in the feed method so I took out the similar lines contained therein. I also removed the arrow from the code in the create method.

Finally, I simplified the long line in the show and destroy methods. They had similar lines so I merely took them out to form a method and called them.