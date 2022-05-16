import 'package:flutter/src/widgets/framework.dart';
import 'package:notes_app/bloc/user/userRepository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final userRepository = UserRepository();
  final BehaviorSubject<void> _subject = BehaviorSubject<void>();

  loginUser(var userName, var password, BuildContext context) async {
    var loginResponse =
        (await userRepository.loginUser(userName, password, context));
    _subject.sink.add(loginResponse);
  }

  registerUser(var userName, var password, BuildContext context) async {
    var registerResponse =
        (await userRepository.registerUser(userName, password, context));
    _subject.sink.add(registerResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<void> get subject => _subject;
}

final userBloc = UserBloc();
