#### The ArticleViewSet class imports mixins that it doesnt use. The mixins are:
    - CreateModelMixin
    - RetrieveModelMixin

Changes Made
    - line 14 i have removed the unused mixins

#### The get_queryset will be inefficient because of how the models have been designed.

Article model should have a direct foreign key to User instead of a FK to Profile which then relates to User. This would reduce the number of joins to fetch eg username. Profile model is usually used to store extra data that might not be directly related to an article

Changes Made
    - recommend developer to re-design Article model to have a FK to User instead of Profile
    - line 20 remove author__user on select_related query
    - line 30 remove nested filter __user since now author will be a User model
    - line 36 remove nested filter __user since now favorited_by will be a User model

#### It is not recommended to override filter_queryset on the View Class
It is not recommended to override `filter_queryset` method. It limits the class to only one type of filter (the overriden filter), also it does not allow re-usability of the filter. A good approach would be to decouple the filter to its own custom filter class, then use the `filter_backends` property on the view class to set the filter. 

However, since this filter has a very specific use-case there is no need to create a Custom Filter Class. Instead just override `get_queryset` method

Changes Made
    - remove filter_queryset method
    - override get_queryset

#### Remove unused imports
Line 9 and Line 11 - remove Tag and TagSerializer
Line 4 - remove AllowAny, IsAuthenticated permission class
Line 7 - remove APIView

#### PEP8 Linting errors
Line 52 - continuation line missing indentation or outdented pep8(E122)
Line 87 - too many blank lines pep8(E303)