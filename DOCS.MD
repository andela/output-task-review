### Review guide

* Comments
    - I updated every method to have a comment, this follows PEP8 guides

* Possible errors
    - I refactored dict lookup to use `.get()` this returns None if the key doesn't exist unlike using the `[]` accessor

* DRY
    - I created a method that returns query params if it exists because i noticed in the `get_queryset` method, there was repetition.

* Consistency
    - I ensured there are no more than one spacing between every methods

* General styling
    - I removed white spacing