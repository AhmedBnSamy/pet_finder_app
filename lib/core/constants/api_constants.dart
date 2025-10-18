class ApiConstants {
  // TODO: استبدل بـ API Key الخاص بك من thecatapi.com
  static const String apiKey = 'YOUR_API_KEY_HERE';

  static const String baseUrl = 'https://api.thecatapi.com/v1';

  // Endpoints
  static const String breeds = '/breeds';
  static const String images = '/images/search';
  static const String imageById = '/images';

  // Headers
  static Map<String, String> get headers => {
    'live_fGv9ELcaHZHXtFJ9IpqYdm3mf5JrAInzeYi1cXNglNGDMauAGpwaxbG66PtK9FRx': apiKey,
    'Content-Type': 'application/json',
  };
}