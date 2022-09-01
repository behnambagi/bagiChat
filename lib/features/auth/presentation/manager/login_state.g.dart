// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginState on _LoginState, Store {
  late final _$credentialIdAtom =
      Atom(name: '_LoginState.credentialId', context: context);

  @override
  Observable<String> get credentialId {
    _$credentialIdAtom.reportRead();
    return super.credentialId;
  }

  @override
  set credentialId(Observable<String> value) {
    _$credentialIdAtom.reportWrite(value, super.credentialId, () {
      super.credentialId = value;
    });
  }

  late final _$sendCodeAsyncAction =
      AsyncAction('_LoginState.sendCode', context: context);

  @override
  Future sendCode(String number) {
    return _$sendCodeAsyncAction.run(() => super.sendCode(number));
  }

  late final _$verifyNumberAsyncAction =
      AsyncAction('_LoginState.verifyNumber', context: context);

  @override
  Future<bool> verifyNumber(String code) {
    return _$verifyNumberAsyncAction.run(() => super.verifyNumber(code));
  }

  @override
  String toString() {
    return '''
credentialId: ${credentialId}
    ''';
  }
}
