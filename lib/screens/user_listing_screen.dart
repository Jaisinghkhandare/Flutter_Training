import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../UiState.dart';
import '../feature/User/create/add_user_bloc.dart';
import '../feature/User/favorite/User_favorite_bloc.dart';
import '../feature/User/favorite/User_favorite_event.dart';
import '../feature/User/list/list_bloc.dart';
import '../feature/User/list/list_event.dart';
import '../feature/User/model/UserModel.dart';
import 'add_user_ui.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List"),
          actions: [
          IconButton(
          icon: Icon(Icons.favorite),
      onPressed: () {

      },
    ),
    ],
    ),
      body: BlocListener<AddUserBloc, UiState>(
        listener: (context, addState) {

          if (addState is Success) {
            context.read<UserBloc>().add(FetchUsersEvent());

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User Added Successfully")),
            );
          }

          if (addState is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(addState.message)),
            );
          }
        },

        child: BlocBuilder<UserBloc, UiState<List<User>>>(
          builder: (context, state) {

            if (state is Initial) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<UserBloc>().add(FetchUsersEvent());
                  },
                  child: const Text("Fetch Users"),
                ),
              );
            }

            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is Success<List<User>>) {

              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {

                  final user = state.data[index];

                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: user.isActive
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            user.status.name.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),

                        BlocBuilder<UserFavoriteBloc, UiState<Set<int>>>(
                          builder: (context, favState) {

                            bool isFav = false;

                            if (favState is Success<Set<int>>) {
                              isFav = favState.data.contains(user.id);
                            }

                            return IconButton(
                              onPressed: () {
                                context.read<UserFavoriteBloc>().add(
                                  ToggleFavoriteEvent(user.id),
                                );
                              },
                              icon: Icon(
                                isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            if (state is Error) {
              return Center(child: Text(state.message));
            }

            return const Center(
              child: Text("Press button to load users"),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showUserDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}