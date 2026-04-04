import 'package:bloc/bloc.dart';
import 'package:bookstore/features/home/data/models/slider_model.dart';
import 'package:bookstore/features/home/data/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getSlider()async{
    emit(SliderLoadingState());
    final response=await HomeRepo.getSlider();
    if(response!=null){
      emit(SliderSuccessState());
    }
  }

}
