abstract class SignInStates{}

class SignInInitialState extends SignInStates{}

class PasswordVisibilityChangeState extends SignInStates{}


class LoginLoadingState extends SignInStates{}
class LoginSuccessState extends SignInStates{
  final String uid;

  LoginSuccessState(this.uid);
}
class LoginErrorState extends SignInStates{
  final String error;
  LoginErrorState(this.error);
}


class UserAlreadyExistsState extends SignInStates{
  final String uid;

  UserAlreadyExistsState(this.uid);
}
class UserDoesNotExistsState extends SignInStates{}

///state mode change
class AppChangeModeState extends SignInStates{}