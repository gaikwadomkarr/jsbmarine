import 'package:jsbmarineversion1/models/login_response.dart';
import 'package:mobx/mobx.dart';

import '../models/user_details.dart';
part 'login_controller_mobx.g.dart';

class LoginControllerMobx = _LoginControllerMobxBase with _$LoginControllerMobx;

abstract class _LoginControllerMobxBase with Store {
  @observable
  bool showLoginLoader = false;
  @observable
  LoginDetails loginDetails = LoginDetails();
  @observable
  UserDetails userDetails = UserDetails();

  @action
  void updateLoginDetails(var data) {
    loginDetails = LoginDetails.fromJson(data);
  }

  @action
  void updateUserDetails(var data) {
    userDetails = UserDetails.fromJson(data);
  }
}
