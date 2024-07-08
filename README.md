# Flutter Blog App
This is a Flutter application for managing blogs. The backend and authentication are handled by Supabase, and Hive is used for caching blogs. The app follows the Clean Architecture pattern. GetIt is used for Dependency Injection (DI), and Bloc is used for state management.


## Screenshots
![Untitled design](https://github.com/a7medkhalaf/flutter_blog_app/assets/76059708/bc2f2bb3-13cf-4e20-b3d6-af4a91ed74c9)

## Features
* ``User Authentication``: Users can sign up, log in, and manage their accounts using Supabase.
* ``Add Blogs``: Users can create blogs by adding a picture, selecting one or more categories, writing a title, and adding content.
* ``View Blogs``: The home screen displays all blogs. When a user selects a blog, they can see the title, author, date, reading time, picture, and content.
* ``Caching``: Blogs are cached locally using Hive for offline access.
* ``State Management``: The app uses Bloc for managing the state of the application.
* ``Dependency Injection``: GetIt is used for DI to manage dependencies across the app.

## Getting Started
To run the Diary app locally on your machine, follow these steps:
1. Clone the repository: git clone https://github.com/a7medkhalaf/flutter_blog_app
2. Navigate to the project directory: cd flutter_blog_app
3. Install dependencies: flutter pub get
4. Run the app: flutter run
5. This project is a starting point for a Flutter application.
