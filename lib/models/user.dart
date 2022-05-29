import 'dart:math';

class User {
  final String name;
  final String photoUrl;
  User(this.name, this.photoUrl);

  factory User.me() => User('Guilherme Galambas (Eu)', 'assets/example/me.jpg');
  factory User.random() => [
        User('Talant Dujshebaev', 'assets/example/talant_dujshebaev.jpg'),
        User('Raúl González', 'assets/example/raul_gonzalez.jpg'),
        User('Paulo Pereira', 'assets/example/paulo_pereira.jpg')
      ][Random().nextInt(3)];

  @override
  String toString() => name;
}
