import 'dart:io';
import 'package:exercise01/feature/User/create/bloc/add_user_event.dart';
import 'package:exercise01/feature/User/list/Bloc.dart';
import 'package:exercise01/feature/User/list/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'UiState.dart';
import 'feature/User/create/bloc/add_user_bloc.dart';
import 'feature/User/list/api.dart';
import 'model/UserModel.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/UserModel.dart';
import 'feature/User/create/bloc/add_user_bloc.dart';
import 'feature/User/create/bloc/add_user_event.dart';
//bloc
//create user using goRest floating button
//textfiled
//Dialog
//add user branch
//dev -- > feat/adduser
//Form Builder -- used in app
//edit -- edit user
//api service , Ui ,
//bloc,data,ui
//git checkout -b feature/add-user
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(ApiService(httpClient: http.Client())),
        ),
        BlocProvider(create: (_)=>AddUserBloc(ApiService(httpClient: http.Client())),
        ),

      ], child: UserScreen(),)
    );
  }
}

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



  void showUserDialog(BuildContext context) {

    final _formKey = GlobalKey<FormBuilderState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Add User"),

          content: FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// Name
                  FormBuilderTextField(
                    name: 'name',
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Email
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Gender
                  FormBuilderRadioGroup<String>(
                    name: 'gender',
                    options: const [
                      FormBuilderFieldOption(value: 'Male'),
                      FormBuilderFieldOption(value: 'Female'),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Status
                  FormBuilderRadioGroup<String>(
                    name: 'status',
                    options: const [
                      FormBuilderFieldOption(value: 'Active'),
                      FormBuilderFieldOption(value: 'Inactive'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          actions: [

            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {

                _formKey.currentState?.save();

                final data = _formKey.currentState?.value;

                /// SEND EVENT TO BLOC
                context.read<AddUserBloc>().add(
                  AddUseEvent(
                    User(
                      name: data?['name'] ?? '',
                      email: data?['email'] ?? '',
                      gender: (data?['gender'] ?? 'Male').toLowerCase(),
                      status: (data?['status'] ?? 'Active').toLowerCase(),
                    ),
                  ),
                );
                context.read<UserBloc>().add(FetchUsersEvent());
                Navigator.pop(dialogContext);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }



}
