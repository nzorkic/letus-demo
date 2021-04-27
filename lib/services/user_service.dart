import 'package:letus/api/firestore_api.dart';
import 'package:letus/app/app.logger.dart';
import 'package:letus/app/app.locator.dart';
import 'package:letus/models/application_models.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class UserService {
  final log = getLogger('UserService');

  final _firestoreApi = locator<FirestoreApi>();
  final _firebaseAuthService = locator<FirebaseAuthenticationService>();

  User? _currentUser;

  User get currentUser => _currentUser!;

  Future<void> syncUserAccount() async {
    final firebaseUserId = _firebaseAuthService.firebaseAuth.currentUser!.uid;

    log.v('Syncing user $firebaseUserId...');

    final userAccount = await _firestoreApi.getUser(userId: firebaseUserId);

    if (userAccount != null) {
      log.v('User account exists. Saving is a current user.');
      _currentUser = userAccount;
    }
  }

  Future<void> syncOrCreateuserAccount({required User user}) async {
    log.i('User: $user');

    await syncUserAccount();

    if (_currentUser == null) {
      log.v('User not found. Creating a new user...');
      _firestoreApi.createUser(user: user);
      _currentUser = user;
      log.v('_currentUser has been saved.');
    }
  }
}
