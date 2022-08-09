// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homepage_controller_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageController on _HomePageControllerBase, Store {
  late final _$homePageTitleAtom =
      Atom(name: '_HomePageControllerBase.homePageTitle', context: context);

  @override
  String get homePageTitle {
    _$homePageTitleAtom.reportRead();
    return super.homePageTitle;
  }

  @override
  set homePageTitle(String value) {
    _$homePageTitleAtom.reportWrite(value, super.homePageTitle, () {
      super.homePageTitle = value;
    });
  }

  @override
  String toString() {
    return '''
homePageTitle: ${homePageTitle}
    ''';
  }
}
