import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

import '../feature/core/service/api.dart';
import '../feature/core/state/ui_state.dart';
import '../feature/User/create/add_user_bloc.dart';
import '../feature/User/create/add_user_event.dart';
import '../feature/User/model/user_model.dart';
import '../feature/User/model/User_enums.dart';


Future<bool?> showUserDialog(BuildContext context) async {
  final formKey = GlobalKey<FormBuilderState>();

  return await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return BlocProvider(
        create: (_)=>AddUserBloc(ApiService(httpClient: http.Client())),
        child: BlocListener<AddUserBloc, UiState>(
          listener: (context, state) {

            if (state is Success) {
              Navigator.pop(dialogContext, true);
            }

            if (state is Error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: AlertDialog(
            title: const Text("Add User"),

            content: FormBuilder(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration:
                      const InputDecoration(labelText: 'Name'),
                    ),

                    const SizedBox(height: 12),

                    FormBuilderTextField(
                      name: 'email',
                      decoration:
                      const InputDecoration(labelText: 'Email'),
                    ),

                    const SizedBox(height: 12),

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
                onPressed: () =>
                    Navigator.pop(dialogContext, false),
                child: const Text("Cancel"),
              ),
              BlocBuilder<AddUserBloc, UiState>(
                builder: (context, state) {
                  final isLoading = state is Loading;

                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                      formKey.currentState?.save();
                      final data =
                          formKey.currentState?.value;

                      final user = User(
                        id: 0,
                        name: data?['name'] ?? '',
                        email: data?['email'] ?? '',
                        gender: data?['gender'] ??
                            Gender.male,
                        status: data?['status'] ??
                            Status.active,
                      );

                      context
                          .read<AddUserBloc>()
                          .add(AddUseEvent(user));
                    },
                    child: isLoading
                        ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2),
                    )
                        : const Text("Submit"),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}