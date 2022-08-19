// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserState on _UserState, Store {
  Computed<List<dynamic>>? _$peopleComputed;

  @override
  List<dynamic> get people =>
      (_$peopleComputed ??= Computed<List<dynamic>>(() => super.people,
              name: '_UserState.people'))
          .value;

  late final _$usersAtom = Atom(name: '_UserState.users', context: context);

  @override
  Map<String, dynamic> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(Map<String, dynamic> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$avatarUserAtom =
      Atom(name: '_UserState.avatarUser', context: context);

  @override
  Uint8List? get avatarUser {
    _$avatarUserAtom.reportRead();
    return super.avatarUser;
  }

  @override
  set avatarUser(Uint8List? value) {
    _$avatarUserAtom.reportWrite(value, super.avatarUser, () {
      super.avatarUser = value;
    });
  }

  late final _$_searchUserAtom =
      Atom(name: '_UserState._searchUser', context: context);

  @override
  String get searchUser {
    _$_searchUserAtom.reportRead();
    return super.searchUser;
  }

  @override
  set searchUser(String value) {
    _$_searchUserAtom.reportWrite(value, super.searchUser, () {
      super.searchUser = value;
    });
  }

  late final _$_UserStateActionController =
      ActionController(name: '_UserState', context: context);

  @override
  dynamic setSearchTerm(String value) {
    final _$actionInfo = _$_UserStateActionController.startAction(
        name: '_UserState.setSearchTerm');
    try {
      return super.setSearchTerm(value);
    } finally {
      _$_UserStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initUsersListener() {
    final _$actionInfo = _$_UserStateActionController.startAction(
        name: '_UserState.initUsersListener');
    try {
      return super.initUsersListener();
    } finally {
      _$_UserStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
users: ${users},
avatarUser: ${avatarUser},
people: ${people}
    ''';
  }
}
