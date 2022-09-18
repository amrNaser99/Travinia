import 'package:bloc/bloc.dart';
import 'package:travinia/presentation/home/bloc/home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
}
