class Friend {
  final String id;
  final String name;
  final String status; // can be 'Online', 'Offline', etc.
  final String avatarURL;

  Friend({
    required this.id,
    required this.name,
    required this.status,
    required this.avatarURL,
  });

  factory Friend.toJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      avatarURL: json['avatarURL'],
    );
  }
}
