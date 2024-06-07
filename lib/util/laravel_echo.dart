// import 'package:laravel_echo_null/laravel_echo_null.dart';
// import 'package:pusher_client_fixed/pusher_client_fixed.dart';

// class PusherConfig{
//   static const appId="";
//   static const key="";
//   static const secret="";
//   static const cluster="";
//   static const hostEndPoint="";
//   static const hostAuthEndPoint="";
//   static const port=6001;
// }


//  PusherClient createPusherClient(String token){
//   PusherOptions options=PusherOptions(
//     wsPort: PusherConfig.port,
//     encrypted: true,
//     host: PusherConfig.hostEndPoint,
//     cluster: PusherConfig.cluster,
//     auth: PusherAuth(PusherConfig.hostAuthEndPoint,headers: {
//       "Authorization": "Bearer $token",
//       "Content-Type":"application/json",
//       "Accept":"application/json"
//     })
//   );

//   PusherClient pusherClient=PusherClient(PusherConfig.key, options);
//   return pusherClient;
//  }

//  Echo createLaravelEcho(String token){
//   return Echo();
//  }