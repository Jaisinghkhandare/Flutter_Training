import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../feature/User/create/add_user_bloc.dart';
import '../feature/User/create/add_user_event.dart';
import '../feature/User/list/list_bloc.dart';
import '../feature/User/list/list_event.dart';
import '../feature/User/model/UserModel.dart';
import '../feature/User/model/User_enums.dart';

Future<bool> showUserDialog(BuildContext context) async {
  final _formKey = GlobalKey<FormBuilderState>();

  return await showDialog(
    context: context,
    builder: (dialogContext) {
      return
        AlertDialog(
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
                  decoration: const InputDecoration(labelText: 'Name'),
                ),

                const SizedBox(height: 12),

                /// Email
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                ),

                const SizedBox(height: 12),

                /// Gender ENUM
                FormBuilderRadioGroup<Gender>(
                  name: 'gender',
                  options: const [
                    FormBuilderFieldOption(
                      value: Gender.male,
                      child: Text("Male"),
                    ),
                    FormBuilderFieldOption(
                      value: Gender.female,
                      child: Text("Female"),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Status ENUM
                FormBuilderRadioGroup<Status>(
                  name: 'status',
                  options: const [
                    FormBuilderFieldOption(
                      value: Status.active,
                      child: Text("Active"),
                    ),
                    FormBuilderFieldOption(
                      value: Status.inactive,
                      child: Text("Inactive"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        actions: [

          TextButton(
            onPressed: () => Navigator.pop(dialogContext,false),
            child: const Text("Cancel"),
          ),

          ElevatedButton(
            onPressed: () {

              _formKey.currentState?.save();
              final data = _formKey.currentState?.value;

              final user = User(
                id: 0,
                name: data?['name'] ?? '',
                email: data?['email'] ?? '',
                gender: data?['gender'] ?? Gender.male,
                status: data?['status'] ?? Status.active,
              );

              /// SEND EVENT TO BLOC
              print('*** Saving user, adding event to the bloc');
              final addUserBloc = context.read<AddUserBloc>();
              print('***** AddUserBloc is ${addUserBloc}');
              context.read<AddUserBloc>().add(
                AddUseEvent(user),
              );
              print('***** popping after event has been added');
              Navigator.pop(dialogContext,true);
            },
            child: const Text("Submit"),
          ),
        ],
      );
    },
  );
}