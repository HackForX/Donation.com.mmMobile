/// Environments of WebSite
class AppConfig {
  // static const String baseUrl = 'http://10.0.2.2:8000'; 
  // static const String baseUrl = 'http://127.0.0.1:8000'; 



  static const String baseUrl = 'https://backend.donation.com.mm';
  static const String endPoint = '$baseUrl/api/user';
  static const String signInUrl = '$endPoint/login';
  static const String appleSignInUrl = '$endPoint/apple-login';


  static const String signUpUrl = '$endPoint/register';
  static const String checkUserExistenceUrl = '$endPoint/checkExist';
  static const String forgotPasswordUrl = '$endPoint/forgot-password';
  static const String resetPasswordUrl = '$endPoint/reset-password';
  static const String logOutUrl = '$endPoint/logout';
  static const String saduditharsUrl = '$endPoint/sadudithars';
  static const String historyUrl = '$endPoint/sadudithars/history';
  static const String natebanzayUrl = '$endPoint/natebanzay';
  static const String shareNatebanzaysUrl = '$endPoint/natebanzays-requested';
  static const String getNatebanzaysUrl = '$endPoint/natebanzays-requests';
  static const String requestNatebanzayUrl = '$endPoint/request-natebanzay';
  static const String donorsUrl = '$endPoint/donors';
  static const String profileUrl = '$endPoint/me';
  static const String contactUrl = '$endPoint/contacts';
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

  static const String natebanzayCommentsUrl='$endPoint/natebanzay-comments';
  static const String natebanzayLikesUrl = '$endPoint/natebanzay-likes';
  static const String natebanzayViewsUrl = '$endPoint/natebanzay-views';
  static const String notificationsUrl = '$endPoint/notifications';
  static const String chatUrl = '$endPoint/natebanzay-chat';
  static const String sendMessageUrl = '$endPoint/send-message';


  static const String   messagesUrl = '$endPoint/get-messages';

  static const String saveTokenUrl = '$endPoint/save-token';
  static const String natebanzayRequestsUrl = '$endPoint/natebanzay-requests';







  static const String registerDonorUrl = '$endPoint/request-donor';







}
