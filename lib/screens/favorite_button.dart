  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';

  import '../feature/User/favorite/User_favorite_bloc.dart';
  import '../feature/User/favorite/User_favorite_event.dart';
  import '../feature/core/state/ui_state.dart';

  class FavoriteButton extends StatelessWidget {
    final int userId;

    const FavoriteButton({required this.userId});

    @override
    Widget build(BuildContext context) {
      return BlocBuilder<UserFavoriteBloc, UiState<Set<int>>>(
        buildWhen: (previous, current) {
          if (previous is Success<Set<int>> &&
              current is Success<Set<int>>) {
            final prevFav = previous.data.contains(userId);
            final currFav = current.data.contains(userId);
            return prevFav != currFav;
          }
          return true;
        },
        builder: (context, state) {
          bool isFav = false;

          if (state is Success<Set<int>>) {
            isFav = state.data.contains(userId);
          }

          return IconButton(
            onPressed: () {
              context.read<UserFavoriteBloc>().add(
                ToggleFavoriteEvent(userId),
              );
            },
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          );
        },
      );
    }
  }