import '../../../core/error/exceptions.dart';

abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ChangeOpacityState extends ExploreState {}

class ChangeBMapClickedState extends ExploreState {}

class SearchHotelsLoadingState extends ExploreState {}
class SearchHotelsSuccessState extends ExploreState {}

class ErrorState extends ExploreState {
  final PrimaryServerException exception;

  ErrorState({
    required this.exception,
  });
}
