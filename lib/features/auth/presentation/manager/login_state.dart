import 'package:bagi_chat/features/auth/domain/repositories/auth_repository.dart';
import 'package:bagi_chat/features/auth/domain/use_cases/get_concreate_auth.dart';
import 'package:mobx/mobx.dart';
import '../../../../injection_container.dart';

part 'login_state.g.dart';


class LoginState = _LoginState  with _$LoginState;

abstract class _LoginState with Store{
  _LoginState({
    GetConcreteSendCode? useCaseSendCode,
    PostConcreteLogin? useCaseLogin,
  }):useCaseSendCode = useCaseSendCode??sl(),
        useCaseLogin = useCaseLogin??sl();
GetConcreteSendCode useCaseSendCode;
PostConcreteLogin useCaseLogin;

@observable
var credentialId = Observable<String>('');

  @action
  void sendCode(String number) async {
    var res = await useCaseSendCode(ParamsSendCode(number: number));
    if(res.isRight()) credentialId.value = res.toIterable().first;
  }

  @action
  Future<bool> verifyNumber(String code) async {
   var res =  await useCaseLogin(
       VerifyLoginParams(credentialId: credentialId.value, code: code));
   if(res.isRight()) return true;
   return false;
  }
}