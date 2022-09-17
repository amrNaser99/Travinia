import 'package:bloc/bloc.dart';
import 'package:travinia/core/app/blocs/app_state.dart';


class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());


}
