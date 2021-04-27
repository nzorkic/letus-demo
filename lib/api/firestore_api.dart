import 'package:letus/app/app.logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letus/exceptions/firestore_api_exception.dart';
import 'package:letus/models/application_models.dart';

class FirestoreApi {
  final log = getLogger('FirestoreApi');

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser({required User user}) async {
    log.i('user: $user');

    try {
      final userDocument = usersCollection.doc(user.id);
      await userDocument.set(user.toJson());
      log.v('User created at ${userDocument.path}');
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new user.',
        devDetails: '$error',
      );
    }
  }

  Future<User?> getUser({required String userId}) async {
    log.i('userId: $userId');

    if (userId.isEmpty) {
      throw FirestoreApiException(message: 'Your userId is empty.');
    }

    final userDoc = await usersCollection.doc(userId).get();

    if (!userDoc.exists) {
      log.v('User with id $userId does not exist.');
      return null;
    }

    final userData = userDoc.data();
    log.v('User found. Data: $userData');

    return User.fromJson(userData!);
  }
}
