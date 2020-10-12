class User {
  final String uId;
  final String userName;
  final String email;
  final String avatarUrl;

  User({
    this.uId,
    this.userName,
    this.email,
    this.avatarUrl,
  });

  Map<String, dynamic> toFirebase() => {
        'uId': this.uId,
        'avatarUrl': this.avatarUrl ??
            'https://firebasestorage.googleapis.com/v0/b/irla-app.appspot.com/o/account_photo_placeholder.png?alt=media',
        'userName': this.userName,
        'email': this.email,
      };

  factory User.fromFirebase(Map<String, dynamic> data) {
    return User(
      uId: data['uId'],
      userName: data['userName'],
      email: data['email'],
      avatarUrl: data['avatarUrl'],
    );
  }
}
