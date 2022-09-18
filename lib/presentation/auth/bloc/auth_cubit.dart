import 'package:bloc/bloc.dart';
import 'package:travinia/presentation/auth/bloc/auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
}
