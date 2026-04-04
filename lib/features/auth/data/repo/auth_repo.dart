

import 'package:bookstore/core/networking/api_constants.dart';
import 'package:bookstore/core/networking/dio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {



  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioService.dio?.post(
        ApiConstants.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response?.statusCode == 200 &&
          response?.data["data"] != null &&
          response?.data["data"]["token"] != null) {

        await saveUserToken(response?.data["data"]["token"]);

        return true;

      } else {
        return false;
      }

    } catch (e) {
      return false;
    }
  }


 // static Future<bool> login({required String email,required String password})async{
 //
 //    try{
 //      final response=await DioService.dio?.post(ApiConstants.login,
 //          data: {
 //            "email":email,
 //            "password":password
 //          }
 //      );
 //      if(response?.statusCode==200){
 //        saveUserToken(response?.data["data"]["token"]);
 //        return true;
 //
 //      }else{
 //        return false;
 //      }
 //    }catch(e){
 //      return false;
 //
 //    }
 //  }


  static Future<void> saveUserToken(String token)async{
   final SharedPreferences prefs= await SharedPreferences.getInstance();
  prefs.setString("token", token);
  print("successfully");
  }
}