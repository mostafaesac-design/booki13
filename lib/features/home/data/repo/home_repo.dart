import 'package:bookstore/core/networking/api_constants.dart';
import 'package:bookstore/core/networking/dio_service.dart';
import 'package:bookstore/features/home/data/models/slider_model.dart';

class HomeRepo {


static Future<SliderResponse?>? getSlider()async{
  try{
    final response=await DioService.dio?.get(ApiConstants.sliders);
    if(response?.statusCode==200){
      SliderResponse data=SliderResponse.fromJson(response?.data);
return data;
    }else{
      return null;

    }
  }catch(error){
    return null;
  }
}

}