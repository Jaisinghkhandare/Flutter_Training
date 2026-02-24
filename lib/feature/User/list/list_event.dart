abstract class UserEvent {}

class FetchUsersEvent extends UserEvent {}
class FetchfavEvent extends UserEvent{}

class DeleteUserEvent extends UserEvent {
  final int userId;
  DeleteUserEvent(this.userId);
}