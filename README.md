# News-Lokal
A Flutter app that displays news and allows sorting by country.
## Features
- Uses `env` to hide the API key.
- Uses `cached_network_image` to cache the images and make them load faster.
- Beautiful flat UI.
- Uses `provider` to manage the state.
- Changing the country from the drop-down will change the news.

## Getting Started
- Clone the repository to your local machine.
- Run `flutter pub get` to install the dependencies.
- Create a `.env` file in the root directory and add the following line
```makefile
KEY=your_api_key_here
```
Replace `your_api_key_here` with your actual API key.
- Run the app using `flutter run`.
- Changing the country from the drop-down will change the news.

## Dependencies
- `http` - HTTP client for Flutter.
- `cached_network_image` - Caching library for images in Flutter.
- `flutter_dotenv` - Library for loading environment variables in Flutter.

## Screenshots
