import 'package:myapp/models/schedule.dart';
import 'package:myapp/repositories/user_respository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/user_model.dart';

final userModelProvider = StateProvider(
  (ref) => UserModel(
      username: 'test',
      password: '....',
      email: 'test@gmail.com',
      schedule: Schedule(id: '1', courses: []),
      avatarURL: ''),
);
