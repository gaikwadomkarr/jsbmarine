// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginControllerMobx on _LoginControllerMobxBase, Store {
  late final _$showLoginLoaderAtom =
      Atom(name: '_LoginControllerMobxBase.showLoginLoader', context: context);

  @override
  bool get showLoginLoader {
    _$showLoginLoaderAtom.reportRead();
    return super.showLoginLoader;
  }

  @override
  set showLoginLoader(bool value) {
    _$showLoginLoaderAtom.reportWrite(value, super.showLoginLoader, () {
      super.showLoginLoader = value;
    });
  }

  late final _$showGetBranchLoaderAtom = Atom(
      name: '_LoginControllerMobxBase.showGetBranchLoader', context: context);

  @override
  bool get showGetBranchLoader {
    _$showGetBranchLoaderAtom.reportRead();
    return super.showGetBranchLoader;
  }

  @override
  set showGetBranchLoader(bool value) {
    _$showGetBranchLoaderAtom.reportWrite(value, super.showGetBranchLoader, () {
      super.showGetBranchLoader = value;
    });
  }

  late final _$loginDetailsAtom =
      Atom(name: '_LoginControllerMobxBase.loginDetails', context: context);

  @override
  LoginDetails get loginDetails {
    _$loginDetailsAtom.reportRead();
    return super.loginDetails;
  }

  @override
  set loginDetails(LoginDetails value) {
    _$loginDetailsAtom.reportWrite(value, super.loginDetails, () {
      super.loginDetails = value;
    });
  }

  late final _$userDetailsAtom =
      Atom(name: '_LoginControllerMobxBase.userDetails', context: context);

  @override
  UserDetails get userDetails {
    _$userDetailsAtom.reportRead();
    return super.userDetails;
  }

  @override
  set userDetails(UserDetails value) {
    _$userDetailsAtom.reportWrite(value, super.userDetails, () {
      super.userDetails = value;
    });
  }

  late final _$getBranchNameAsyncAction =
      AsyncAction('_LoginControllerMobxBase.getBranchName', context: context);

  @override
  Future<String> getBranchName(List<dynamic> data) {
    return _$getBranchNameAsyncAction.run(() => super.getBranchName(data));
  }

  late final _$_LoginControllerMobxBaseActionController =
      ActionController(name: '_LoginControllerMobxBase', context: context);

  @override
  void updateLoginDetails(dynamic data) {
    final _$actionInfo = _$_LoginControllerMobxBaseActionController.startAction(
        name: '_LoginControllerMobxBase.updateLoginDetails');
    try {
      return super.updateLoginDetails(data);
    } finally {
      _$_LoginControllerMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateUserDetails(dynamic data) {
    final _$actionInfo = _$_LoginControllerMobxBaseActionController.startAction(
        name: '_LoginControllerMobxBase.updateUserDetails');
    try {
      return super.updateUserDetails(data);
    } finally {
      _$_LoginControllerMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showLoginLoader: ${showLoginLoader},
showGetBranchLoader: ${showGetBranchLoader},
loginDetails: ${loginDetails},
userDetails: ${userDetails}
    ''';
  }
}
