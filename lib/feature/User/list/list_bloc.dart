
//import 'package:api_learning/user_model.dart';
import 'package:exercise01/UiState.dart';
import 'package:exercise01/feature/User/list/list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../UiState.dart';
import '../../core/service/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/UserModel.dart';
import 'list_state.dart';

class UserBloc extends Bloc<UserEvent, UiState<List<User>>> {

  final ApiService apiService;
  Map<int, bool> favorites = {};


  UserBloc(this.apiService) : super(Initial()) {

    on<FetchUsersEvent>((event, emit) async {

      emit(Loading());

      try {
        final users = await apiService.apiCall();
        emit(Success(users!));
      } catch (e) {
        emit(Error(e.toString()));
      }
    });
  }








}

