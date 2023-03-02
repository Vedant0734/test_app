import 'package:bgi_test_app/models/user.dart';
import '../../services/auth.dart';
import '../../services/remote_server.dart';

class AuthenticationRepository {

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final RemoteServerService _remoteServerService = RemoteServerService();
  
  Future<User> signIn(String userId, String password) async {
    try {
      final result = await _remoteServerService.signIn(userId, password);
      return User.fromJson(result);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<User> signUp(String userId, String password) async {
    try {
      final result = await _remoteServerService.signUp(userId, password);
      return User.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }
}