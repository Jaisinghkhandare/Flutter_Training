
//import 'package:api_learning/user_model.dart';
import 'package:exercise01/UiState.dart';
import 'package:exercise01/feature/User/list/user_event.dart';
import 'package:exercise01/model/UserModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../UiState.dart';
import 'api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UiState<List<User>>> {

  final ApiService apiService;

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

