abstract class LayoutStates{}

class LayoutInitState extends LayoutStates{}


class ChatChangeBottomNavState extends LayoutStates{}

class GetUserDataLoadingState extends LayoutStates{}

class SignOutSuccessState extends LayoutStates{}
class GetUserDataSuccessState extends LayoutStates{}
class GetUserDataErrorState extends LayoutStates{
  final String error;
  GetUserDataErrorState(this.error);
}