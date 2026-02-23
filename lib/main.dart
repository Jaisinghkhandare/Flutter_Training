import 'dart:io';
import 'package:exercise01/feature/User/create/add_user_event.dart';
import 'package:exercise01/feature/User/favorite/User_favorite_bloc.dart';
import 'package:exercise01/feature/User/list/list_bloc.dart';
import 'package:exercise01/feature/User/list/list_event.dart';
import 'package:exercise01/screens/ListingUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'UiState.dart';
import 'feature/User/create/add_user_bloc.dart';
import 'feature/User/favorite/User_favorite_event.dart';
import 'feature/core/service/api.dart';

import 'package:flutter/material.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'feature/User/create/add_user_bloc.dart';
import 'feature/User/create/add_user_event.dart';
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
        BlocProvider(
          create: (_) => UserFavoriteBloc()
            ..add(LoadFavoritesEvent()),
        ),

      ], child: UserScreen(),)
    );
  }
}
