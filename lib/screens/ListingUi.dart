import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../UiState.dart';
import '../feature/User/list/Bloc.dart';
import '../feature/User/list/user_event.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    print("heheheh");
    // User user=new User(name: 'jais', email: 'jais@gmail.com', gender: 'Male', status: 'Active');
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: BlocBuilder<UserBloc, UiState<List<User>>>(
        builder: (context, state) {
          if (state is Initial)
          {
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
            print("Users count: ${state.data.length}");
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final user = state.data[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: user.isActive ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      user.status.toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            );
          }
          if (state is Error) {
            return Center(
              child: Text(state.message),
            );
          }
          return const Center(
            child: Text("Press button to load users"),
          );
        },
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showUserDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }