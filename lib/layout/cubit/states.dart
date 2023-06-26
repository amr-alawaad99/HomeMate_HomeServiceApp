abstract class LayoutStates{}

class LayoutInitState extends LayoutStates{}


class ChatChangeBottomNavState extends LayoutStates{}

class GetUserDataLoadingState extends LayoutStates{}

class TextChangedState extends LayoutStates{}

class SignOutSuccessState extends LayoutStates{}
class GetUserDataSuccessState extends LayoutStates{
  final bool isUser;
  GetUserDataSuccessState(this.isUser);
}
class GetUserDataErrorState extends LayoutStates{
  final String error;
  GetUserDataErrorState(this.error);
}

class GetProfileImageSuccessState extends LayoutStates{}
class GetProfileImageErrorState extends LayoutStates{}


class UploadProfilePicLoadingState extends LayoutStates{}
class UploadProfilePicSuccessState extends LayoutStates{}
class UploadProfilePicErrorState extends LayoutStates{
  final String error;

  UploadProfilePicErrorState(this.error);
}

class UpdateUserDataErrorState extends LayoutStates{
  final String error;

  UpdateUserDataErrorState(this.error);
}

class ChangeCurrentPositionSuccessState extends LayoutStates{}



class AppointmentChangeSelectedState extends LayoutStates{}
class SuppliersChangeSelectedState extends LayoutStates{}

////////////////////////


class NewOrderSelectServiceState extends LayoutStates{}

class NewOrderPickImageState extends LayoutStates{}
class NewOrderPickErrorImageState extends LayoutStates{}
class NewOrderClearPickedImageState extends LayoutStates{}


class NewOrderUploadImageToFirebaseLoadingState extends LayoutStates{}
class NewOrderUploadImageToFirebaseSuccessState extends LayoutStates{}


class NewOrderUploadAllImageToFirebaseSuccessState extends LayoutStates{}

class UploadOrderLoadingState extends LayoutStates{}
class UploadOrderSuccessState extends LayoutStates{}
class UploadOrderErrorState extends LayoutStates{

}
class GetOrderDataLoadingState extends LayoutStates{}
class GetOrderDataSuccessState extends LayoutStates{}
class GetOrderDataErrorState extends LayoutStates{
  final String error;

  GetOrderDataErrorState(this.error);
}



class VerificationCodeSentSuccessState extends LayoutStates{
  final String verificationId;

  VerificationCodeSentSuccessState(this.verificationId);
}
class VerificationCodeSentErrorState extends LayoutStates{
  final String error;

  VerificationCodeSentErrorState(this.error);
}


class VerificationSuccessState extends LayoutStates{}
class VerificationErrorState extends LayoutStates{}

//////// upload  offer to firebase

class UploadOfferLoadingState extends LayoutStates{}
class UploadOfferSuccessState extends LayoutStates{}
class UploadOfferErrorState extends LayoutStates{}