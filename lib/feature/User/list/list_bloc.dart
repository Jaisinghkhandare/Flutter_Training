import 'package:exercise01/feature/core/state/ui_state.dart';
import 'package:exercise01/feature/User/list/list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service/api.dart';

import '../model/user_model.dart';

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
    on<FetchfavEvent>((event ,emit)async
    {

    });

    on<DeleteUserEvent>((event, emit) async {
      try {
        await apiService.deleteUser(event.userId);
        add(FetchUsersEvent());
      } catch (e) {
        emit(Error(e.toString()));
      }
    });
  }
}

