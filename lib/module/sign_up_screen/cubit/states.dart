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

  CreateUserSuccessState(this.uid);
}
class CreateUserErrorState extends SignupStates{
  final String error;

  CreateUserErrorState(this.error);
}