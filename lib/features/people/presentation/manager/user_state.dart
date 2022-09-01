import 'dart:typed_data';
import 'package:bagi_chat/core/common/picture_selector.dart';
import 'package:bagi_chat/core/utils/utils.dart';
import 'package:bagi_chat/features/people/domain/people_domain.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import '../../../../injection_container.dart';

part 'user_state.g.dart';

class UserState = _UserState with _$UserState;

abstract class _UserState with Store {
  _UserState({
    GetConcretePeople? peopleUseCase,
    GetConcretePerson? personUseCase,
    PostConcreteEditProfile? editProfileUseCase,
    PostConcreteUpdatePicture? updatePicUseCase,
  })  : peopleUseCase = peopleUseCase ?? sl(),
        personUseCase = personUseCase ?? sl(),
        editProfileUseCase = editProfileUseCase ?? sl(),
        updatePicUseCase = updatePicUseCase ?? sl();
  GetConcretePeople peopleUseCase;
  GetConcretePerson personUseCase;
  PostConcreteUpdatePicture updatePicUseCase;
  PostConcreteEditProfile editProfileUseCase;

  @observable
  List<Person> users = ObservableList<Person>();

  @action
  void initUsersListener() {
    peopleUseCase().toIterable().single
        .listen((event) => {users.assignAll(event), logger.d(event)});
  }

  void createOrUpdateUserInFirestore(String userName) async {
    var res = await editProfileUseCase(
        EditProfParams(name: userName, picUrl: _avatarUrl));
    if (res.isRight()) logger.d(res.toIterable().single);
  }

  String? _avatarUrl;

  @observable
  Uint8List? avatarUser;

  var selector = PictureSelector();

  void _uploadImage() async {
    if (avatarUser == null) return;
    var res = await updatePicUseCase(avatarUser!);
    if (res.isRight()) _avatarUrl = res.toIterable().single;
    logger.d(_avatarUrl);
  }

  void fromCamera() async =>
      {avatarUser = await selector.fromCamera(), _uploadImage()};

  void fromGallery() async =>
      {avatarUser = await selector.fromGallery(), _uploadImage()};
}
