## Code review output

The following highlight the issues identified while reviewing the ruby code
contained within this repository.

Issues

* There is an apparent lack of consistency with respect to the usage of http status
codes. Sometimes, numbers are used and at other times, symbols are used.
* There is also a lack of consistency in terms of the response types being sent
back to the requesting client. Some responses are html while others are in json.
* Too many conditional branching to set proper article state
* There is no access control separation as all actions are left as public methods.
* Some lines of code were going beyond the required 80 character limit
* Multiple unnessary declarations of paginator variables accross several actions
* The strong parameter method used the wrong method naming style convention.
In Ruby, the style convention is to separate words using `snake_case` while the
method in question used `camelCase` naming.

Here are a few things I did to clean up the code

* Delegated the task of setting the proper articles state to `BatchArticlesDecorator`
a new class whose sole job is to handle setting the proper articles state.
This helps reduce the multiple conditional branching necessary to set the articles state.
* Created a new `Paginator` class to handle the pagination of articles. This helped
with reducing the unnecessary multiple declarations of the offset and limit variables
littered accross various actions.
* Setup proper access control within the controller class
* Used standard Ruby naming convention for the erroneously named strong parameter method
* Created a before_action callback to handle setting the proper article for
the show, update and destroy actions.
* Ensured all actions returned a standard response type
* There was an erroneous usage of an instance variable which would be undefined.
This instance variable was `@current_user_id`. I ensured that the current user id
was fetched using the `current_user` method.
* Simplified destroy action to make sure articles are scoped to the right user
when carrying out deletion actions.
