import 'package:mobx/mobx.dart';
part 'homepage_controller_mobx.g.dart';

class HomePageController = _HomePageControllerBase with _$HomePageController;

abstract class _HomePageControllerBase with Store {
  @observable
  String homePageTitle = "New Reading";
}
