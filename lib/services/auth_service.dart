class AuthService {
  Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return email == 'test@example.com' && password == '123456';
  }
}