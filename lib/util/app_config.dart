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
  static const String shareNatebanzaysUrl = '$endPoint/natebanzays-requested';
  static const String getNatebanzaysUrl = '$endPoint/natebanzays-requests';
  static const String requestNatebanzayUrl = '$endPoint/request-natebanzay';
  static const String donorsUrl = '$endPoint/donors';
  static const String itemsUrl = '$endPoint/items';
  static const String categoriesUrl = '$endPoint/categories';
  static const String subCategoriesUrl = '$endPoint/categories';

 

  static const String citiesUrl = '$endPoint/cities';
  static const String townshipsUrl = '$endPoint/townships';
  static const String createNatebanzayUrl = '$endPoint/natebanzay';
  static const String editNatebanzayUrl = '$endPoint/natebanzay';

  static const String saduditharCommentsUrl='$endPoint/sadudithar-comments';
  static const String saduditharLikesUrl = '$endPoint/sadudithar-likes';
  static const String saduditharViewsUrl = '$endPoint/sadudithar-views';
  static const String notificationsUrl = '$endPoint/notifications';
  static const String chatUrl = '$endPoint/natebanzay-chat';
  static const String sendMessageUrl = '$endPoint/send-message';


  static const String messagesUrl = '$endPoint/get-messages';

  static const String saveTokenUrl = '$endPoint/save-token';
  static const String natebanzayRequestsUrl = '$endPoint/natebanzay-requests';







  static const String registerDonorUrl = '$endPoint/request-donor';







}
