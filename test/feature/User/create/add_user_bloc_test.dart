import 'package:bloc_test/bloc_test.dart';
import 'package:exercise01/feature/core/state/ui_state.dart';
import 'package:exercise01/feature/User/create/add_user_bloc.dart';
import 'package:exercise01/feature/User/create/add_user_event.dart';
import 'package:exercise01/feature/User/model/user_model.dart';
import 'package:exercise01/feature/User/model/User_enums.dart';
import 'package:exercise01/feature/core/service/api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late AddUserBloc addUserBloc;
  late MockApiService mockApiService;
  setUpAll(() {
    registerFallbackValue(
      User(
        id: 0,
        name: 'test',
        email: 'test@gmail.com',
        gender: Gender.male,
        status: Status.active,
      ),
    );
  });

  final testUser = User(
    id: 100,
    name: "John",
    email: "john@test.com",
    gender: Gender.male,
    status: Status.active,
  );

  setUp(() {
    mockApiService = MockApiService();
    addUserBloc = AddUserBloc(mockApiService);
  });

  group("AddUserBloc", () {

    blocTest<AddUserBloc, UiState<User>>(
      "Given API success When AddUseEvent is added Then emit [Loading, Success]",

      build: () {
        /// GIVEN
        when(() => mockApiService.createUser(any()))
            .thenAnswer((_) async => testUser);

        return addUserBloc;
      },

      act: (bloc) {
        /// WHEN
        bloc.add(AddUseEvent(testUser));
      },

      expect: () => [
        /// THEN
        Loading<User>(),
        Success<User>(testUser),
      ],

      verify: (_) {
        verify(() => mockApiService.createUser(any())).called(1);
      },
    );
  });
}