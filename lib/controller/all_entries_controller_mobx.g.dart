// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_entries_controller_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AllEntriesControllerMobx on _AllEntriesControllerMobxBase, Store {
  late final _$allConnectionsLoaderAtom = Atom(
      name: '_AllEntriesControllerMobxBase.allConnectionsLoader',
      context: context);

  @override
  bool get allConnectionsLoader {
    _$allConnectionsLoaderAtom.reportRead();
    return super.allConnectionsLoader;
  }

  @override
  set allConnectionsLoader(bool value) {
    _$allConnectionsLoaderAtom.reportWrite(value, super.allConnectionsLoader,
        () {
      super.allConnectionsLoader = value;
    });
  }

  late final _$allconnectionsAtom = Atom(
      name: '_AllEntriesControllerMobxBase.allconnections', context: context);

  @override
  List<MeterReadingRecord> get allconnections {
    _$allconnectionsAtom.reportRead();
    return super.allconnections;
  }

  @override
  set allconnections(List<MeterReadingRecord> value) {
    _$allconnectionsAtom.reportWrite(value, super.allconnections, () {
      super.allconnections = value;
    });
  }

  late final _$_AllEntriesControllerMobxBaseActionController =
      ActionController(name: '_AllEntriesControllerMobxBase', context: context);

  @override
  void updateAllConnections(List<MeterReadingRecord> data) {
    final _$actionInfo =
        _$_AllEntriesControllerMobxBaseActionController.startAction(
            name: '_AllEntriesControllerMobxBase.updateAllConnections');
    try {
      return super.updateAllConnections(data);
    } finally {
      _$_AllEntriesControllerMobxBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allConnectionsLoader: ${allConnectionsLoader},
allconnections: ${allconnections}
    ''';
  }
}
