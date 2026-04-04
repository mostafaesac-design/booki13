part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class SliderLoadingState extends HomeState {}
final class SliderSuccessState extends HomeState {



}
final class SliderErrorState extends HomeState {}
