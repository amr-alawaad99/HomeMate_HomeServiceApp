abstract class NewOrderStates {}

class NewOrderInitialState extends NewOrderStates{}

class NewOrderSelectServiceState extends NewOrderStates{}
class NewOrderPickImageState extends NewOrderStates{}
class NewOrderClearPickedImageState extends NewOrderStates{}
class NewOrderUploadImageToFirebaseState extends NewOrderStates{}