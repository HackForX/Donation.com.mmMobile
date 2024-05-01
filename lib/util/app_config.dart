/// Environments of WebSite
class AppConfig {
  static const String baseUrl = 'http://10.0.2.2:8000';
  // static const String baseUrl = 'https://social.ismarttouch.com';

  static const String endPoint = '$baseUrl/api/user';
  static const String signInUrl = '$endPoint/login';
  static const String signUpUrl = '$endPoint/register';
  static const String logOutUrl = '$endPoint/logout';
  static const String saduditharsUrl = '$endPoint/sadudithars';
  static const String natebanzayUrl = '$endPoint/natebanzay';
  static const String natebanzaysRequestedUrl = '$endPoint/natebanzays-requested';
  static const String natebanzaysRequestsUrl = '$endPoint/natebanzays-requests';
  static const String requestNatebanzayUrl = '$endPoint/request-natebanzay';

  static const String donorsUrl = '$endPoint/donors';
  static const String itemsUrl = '$endPoint/items';
  static const String categoriesUrl = '$endPoint/categories';
  static const String subCategoriesUrl = '$endPoint/categories';

  static const String citiesUrl = '$endPoint/cities';
  static const String townshipsUrl = '$endPoint/townships';
  static const String createNatebanzayUrl = '$endPoint/natebanzay';
  static const String registerDonorUrl = '$endPoint/request-donor';







}
