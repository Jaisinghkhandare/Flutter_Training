import 'package:exercise01/feature/User/list/list_event.dart';
import '../model/UserModel.dart';

class AddUseEvent extends UserEvent{
  final User user;
  AddUseEvent(this.user);
}