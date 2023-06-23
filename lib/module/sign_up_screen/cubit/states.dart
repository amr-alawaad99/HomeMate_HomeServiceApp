abstract class SignupStates{}

class SignupInitState extends SignupStates{}


class PasswordVisibilityChangeState extends SignupStates{}

class CheckboxToggleChangeState extends SignupStates{}
class CheckboxChangeOnButtonClick extends SignupStates{}


class IsSelectedChangeState extends SignupStates{}

class SelectedServiceChangeState extends SignupStates{}


class CreateUserLoadingState extends SignupStates{}
class CreateUserSuccessState extends SignupStates{
  final String uid;


  CreateUserSuccessState(this.uid,);
}
class CreateUserErrorState extends SignupStates{
  final String error;

  CreateUserErrorState(this.error);
}

class UsernameCheckingLoadingState extends SignupStates{}
class UsernameCheckingSuccessState extends SignupStates{}
class UsernameCheckingErrorState extends SignupStates{
  final String error;

  UsernameCheckingErrorState(this.error);
}


class UserAlreadyExistsState extends SignupStates{
  final String uid;

  UserAlreadyExistsState(this.uid);
}
class UserDoesNotExistsState extends SignupStates{}
