## Code Review Output

Below are some of the things I noticed when reviewing the code.

- There was no way to differentiate private methods from public ones. The class was exposing all the methods defined in it and there pose a risk as any of the methods can be called.
- I also noticed that some of the methods didn't exhibit SRP. They were doing more than one thing e.g create and feed methods.
- I also noticed that there were duplicated code that could have been put in a private method and used in all these places.
- A particular method (`articlesParams`)name did not follow the standard way of naming methods; it was named in `camelCase` while it was supposed to be in `snake-case`.
- Unnecessary declaration of variables that could lead to more memory usage.
- Some lines of code were more than the required 80 characters per line.
- Some text were in single-quotes instead of double quotes.

Here are some of the things I did to refactor the code:

- Created a private method to handle the offset and limit parameters in the controller.
- Created a private method to handle forbidden errors that were duplicated in the `update` and `destroy` public methods.
- Changed the `articlesParams` method name from camel-case to snake-case and also made it a private method.
- Changed text to make use of double quotes.
- Created a private method for ordering the articles result and used it in the `feed` and `index` public methods.
- Moved the conditional check of the parameters to a private method to make the `index` method thinner.
- Created a `before_action` hook for handling fetching of article by its slug.
- Made sure only required method are public and make all others private.
- Made sure that the status returned for the methods are uniform i.e uses symbols rather than using a mix of symbol and numbers.