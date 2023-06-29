abstract class GoogleMapsStates{}

class GoogleMapsInitState extends GoogleMapsStates{}


class LocationPermissionAllowedState extends GoogleMapsStates{}
class LocationPermissionDeniedState extends GoogleMapsStates{}
class LocationPermissionDeniedForeverState extends GoogleMapsStates{}
class LocationPermissionChangedState extends GoogleMapsStates{}


class GetUserLocationSuccessState extends GoogleMapsStates{}
class GetPinnedAddressSuccessState extends GoogleMapsStates{}