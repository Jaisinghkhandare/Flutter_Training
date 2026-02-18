import 'package:exercise01/feature/User/list/user_event.dart';
import 'package:exercise01/model/UserModel.dart';

class AddUseEvent extends UserEvent{
  final User user;
  AddUseEvent(this.user);
}