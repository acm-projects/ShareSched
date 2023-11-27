import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/user_model.dart';
class Friend {
  static String? id = '1';
  static String email = 'roshanaldrin@gmail.com';
  static String username = 'xor';
  static String password = 'password12';
  static String? avatarURL =
      'https://images-ext-2.discordapp.net/external/YsCYJaiMfN5jYAiXQCki5mhOHlcvTwb5qwpnlUf6-fE/%3Fsize%3D128/https/cdn.discordapp.com/avatars/94487068729679872/9917684b0587481351ef72462ca57175.png?width=160&height=160';
  static Schedule schedule = Schedule(courses: [], id: '123');
}

class Friend2 {
  static String? id = '2';
  static String email = 'johndoe@gmail.com';
  static String username = 'AlphaZero';
  static String password = 'password12';
  static String? avatarURL =
      'https://community.thriveglobal.com/wp-content/uploads/2019/10/shutterstock_678583375.jpg';
  static Schedule schedule = Schedule(courses: [], id: '345');
}

class Friend3 {
  static String? id = '3';
  static String email = 'johndoe@gmail.com';
  static String username = 'Stockfish';
  static String password = 'password12';
  static String? avatarURL =
      'https://upload.wikimedia.org/wikipedia/commons/8/89/Stockfish_icon_%282010-2020%29.png';
  static Schedule schedule = Schedule(courses: [], id: '345');
}

final friendsProvider = StateProvider<List<UserModel>>((ref) => [
      UserModel(
          username: Friend.username,
          email: Friend.email,
          password: Friend.password,
          schedule: Friend.schedule,
          avatarURL: Friend.avatarURL),
      UserModel(
          username: Friend2.username,
          email: Friend2.email,
          password: Friend2.password,
          schedule: Friend2.schedule,
          avatarURL: Friend2.avatarURL),
      UserModel(
          username: Friend3.username,
          email: Friend3.email,
          password: Friend3.password,
          schedule: Friend3.schedule,
          avatarURL: Friend3.avatarURL),
    ]);
