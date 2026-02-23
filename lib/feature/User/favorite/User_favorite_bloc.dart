import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../UiState.dart';
import 'User_favorite_event.dart';

class UserFavoriteBloc extends Bloc<UserFavoriteEvent, UiState<Set<int>>> {

  static const String _key = "favorite_users";
  final Set<int> _favorites = {};

  UserFavoriteBloc() : super(Initial()) {

    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);

    add(LoadFavoritesEvent());
  }

  Future<void> _onLoadFavorites(
      LoadFavoritesEvent event,
      Emitter<UiState<Set<int>>> emit,
      ) async {

    emit(Loading());

    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList(_key);

    if (savedList != null) {
      _favorites
        ..clear()
        ..addAll(
          savedList
              .map((e) => int.tryParse(e))
              .whereType<int>(),
        );
    }

    emit(Success(Set.from(_favorites)));
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteEvent event,
      Emitter<UiState<Set<int>>> emit,
      ) async {

    if (_favorites.contains(event.userId)) {
      _favorites.remove(event.userId);
    } else {
      _favorites.add(event.userId);
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      _key,
      _favorites.map((e) => e.toString()).toList(),
    );

    emit(Success(Set.from(_favorites)));
  }
}