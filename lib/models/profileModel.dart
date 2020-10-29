import 'package:yommie/provider/rest.dart';

class ProfileModel {
  userProfile(jsons, context){
    try {
      var value = GetAPI.providers(jsons, 'user-profile.php');
      var statusCode = value[0];
      var response = value[1];
      if (statusCode == 200) {
        print(response);
      } else {
        print(response);
      }
    } catch (e) {
    }
  }
}