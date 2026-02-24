abstract class UserFavoriteEvent {}
class LoadFavoritesEvent extends UserFavoriteEvent {

}
class LoadFav extends UserFavoriteEvent{}
class ToggleFavoriteEvent extends UserFavoriteEvent {
  final int userId;

  ToggleFavoriteEvent(this.userId);
}