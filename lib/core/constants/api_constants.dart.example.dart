class ApiConstants {
  // TODO: Get your API key from https://thecatapi.com/signup
  // Then rename this file to api_constants.dart and add your key
  static const String apiKey = 'YOUR_API_KEY_HERE';

  static const String baseUrl = 'https://api.thecatapi.com/v1';

  static const String breeds = '/breeds';
  static const String images = '/images/search';
  static const String imageById = '/images';

  static Map<String, String> get headers => {
    'x-api-key': apiKey,
    'Content-Type': 'application/json',
  };
}