import 'package:edc_v2/core/data/dummy_user.dart';
import 'package:edc_v2/features/auth/domain/repository/auth_repository.dart';
import 'package:edc_v2/features/auth/domain/repository/user_repository.dart';
import 'package:edc_v2/features/auth/presentation/bloc/user_event.dart';
import 'package:edc_v2/features/auth/presentation/bloc/user_state.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  

  UserBloc({required this.authRepository,required this.userRepository}) : super(UserState.initial()) {
    on<SignInWithGoogleEvent>(onSignInWithGoogleEvent);
    on<GetUserEvent>(onGetUserEvent);
    on<LogoutEvent>(onLogoutEvent);

}
  void onSignInWithGoogleEvent(
    SignInWithGoogleEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    
    if (kIsWeb) {
      // Use dummy user when running on web
      emit(state.copyWith(
        status: UserStatus.success,
        userEntity: dummyUser,
      ));
      return;
    }

    var result = await authRepository.signInWithGoogle();
    result.fold((l) {
      // If authentication fails, fall back to dummy user
      emit(state.copyWith(
        status: UserStatus.success,
        userEntity: dummyUser,
      ));
    }, (r) {
      emit(state.copyWith(status: UserStatus.success, userEntity: r));
    });
  }

  void onLogoutEvent(LogoutEvent event, Emitter<UserState> emit) async{
    emit(state.copyWith(status: UserStatus.loading));
    var result = await authRepository.logOut();
    result.fold((l) {
      emit(state.copyWith(status: UserStatus.error, errorMessage: l.errorMessage));
    }, (r){
      emit(state.copyWith(status: UserStatus.logOut));
    });
    
  }

  void onGetUserEvent(GetUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    
    if (kIsWeb) {
      // Use dummy user when running on web
      emit(state.copyWith(
        status: UserStatus.success,
        userEntity: dummyUser,
      ));
      return;
    }

    var result = await userRepository.getUser();
    result.fold((l) {
      // If there's an error, fall back to dummy user
      emit(state.copyWith(
        status: UserStatus.success,
        userEntity: dummyUser,
      ));
    }, (r) {
      emit(state.copyWith(status: UserStatus.success, userEntity: r));
    });
  }
}
