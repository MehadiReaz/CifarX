Flutter (mid-level) first round
task

Task Overview
You are required to build a Flutter app that fetches and displays a list of data
from a public JSON API. The app should support pagination and include
proper state management, navigation, and error handling.
You may use any free public API that provides paginated data (e.g.,
https://dummyjson.com).
Requirements
1. Pagination
Fetch data from the API with a pagination limit of 10 items per page.
Implement infinite scrolling — when the user reaches the bottom, the next
page should automatically load.
The UI design is up to you (keep it simple and clean).
2. State Management
Use Riverpod or BLoC for managing state.
Follow your preferred architecture (Clean Architecture, DDD, or TDD)
principles.
Clearly handle loading, success, and error states in the UI.
3. Error Handling
If the API returns:
403 (Unauthorized) → Redirect to a mock Login Page.
Other errors (e.g., 404, 500) → Display a user-friendly error message in
the UI.
Include a retry option where appropriate.

Flutter (mid-level) first round task 1

4. Navigation
Use GoRouter for handling navigation between pages (e.g., from the list
page to the login page on unauthorized errors).
Ensure navigation follows clean architecture principles — define routes in a
central configuration file.
Bonus Points
Proper folder structure ( domain , data , presentation layers)
Clean and reusable UI components
Use of functional programming concepts (e.g., Either from Fpdart)
Meaningful naming conventions and clear code organization
Submission Format
Submit your project as a ZIP file or share a GitHub repository link.
Include a short README.md that mentions:
The API you used (with a link)
Any assumptions or additional notes