abstract class UserFavoriteEvent {}
class LoadFavoritesEvent extends UserFavoriteEvent {

}
class ToggleFavoriteEvent extends UserFavoriteEvent {
  final int userId;

  ToggleFavoriteEvent(this.userId);
}