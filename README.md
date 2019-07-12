# task-review
The folder "code-review-task" contains four different files. 
The files are: ruby.rb, javascript.js, python.py and laravel.php. Each of the filenames represents the stack with which the file was written. 
The content of these files have been messed up and disarranged.
Fork a file of your stack from the 4 files to your github account. 
Then carry out instructed activities on it.

## CODE REVIEW DOCUMENTATION
1. Removal of unused imports.
   - Imports from rest_framework.permissions AllowAny, IsAuthenticated were unused.
   - Import of Tag model.
   - Import of TagSerializer .

2. Refactor If condition statement check make it less verbose.
   - Changed check from `if author is not None` to `if author`.
   - Changed check from `if tag is not None` to `if tag`.
   - Changed check from `if favorited_by is not None` to `if favorited_by`.

3. Changed how to access request data its redundant.
   - Changed from `serializer_data = request.data.get('article', {})` to just `serializer_data = request.data` serializer will take care of accessing the data keys.

4. Reduced spacing between methods from 2 lines to 1 in accordance to PEP 8 and for consistency with the rest.
