import 'package:exercise01/UiState.dart';
import 'package:exercise01/feature/User/create/add_user_event.dart';
import 'package:exercise01/feature/core/service/api.dart';
//import 'package:exercise01/model/UserModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../list/list_event.dart';
import '../model/UserModel.dart';

class AddUserBloc extends Bloc<AddUseEvent,UiState<User>>{
  final ApiService apiService;
  //User user = new User(name: 'jais', email: 'jais@gmail.com', gender: 'Male', status: 'Active');
  AddUserBloc(this.apiService):super(Initial()){
    on<AddUseEvent>((event, emit) async {
      print('****** event $event added to the bloc');
      emit(Loading());
      try {
        print('**** Before API call');
        User user = await apiService.createUser(event.user);
        print("user added");
        emit(Success(user));
      } catch (e) {
        emit(Error(e.toString()));
      }
    });
  }
}

