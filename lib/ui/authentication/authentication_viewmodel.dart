import 'package:letus/app/app.locator.dart';
import 'package:letus/app/app.logger.dart';
import 'package:letus/exceptions/firestore_api_exception.dart';
import 'package:letus/models/application_models.dart';
import 'package:letus/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class AuthenticationViewModel extends FormViewModel {
  final log = getLogger('AuthenticationViewModel');

  final userService = locator<UserService>();
  final navigationService = locator<NavigationService>();

  final firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  final String successRoute;

  AuthenticationViewModel({required this.successRoute});

  @override
  void setFormStatus() {}

  Future<FirebaseAuthenticationResult> runAuthentication();

  Future saveData() async {
    log.i('values:$formValueMap');

    try {
      final FirebaseAuthenticationResult result =
          await runBusyFuture(runAuthentication(), throwException: true)
              as FirebaseAuthenticationResult;

      await _handleAuthenticationResponse(result);
    } on FirestoreApiException catch (e) {
      log.e(e.toString());
      setValidationMessage(e.toString());
    }
  }

  Future<void> useGoogleAuthentication() async {
    final result = await firebaseAuthenticationService.signInWithGoogle();
    await _handleAuthenticationResponse(result);
  }

  Future<void> useAppleAuthentication() async {
    final result = await firebaseAuthenticationService.signInWithApple(
      appleClientId: '',
      appleRedirectUri:
          'https://boxtout-production.firebaseapp.com/__/auth/handler',
    );
    await _handleAuthenticationResponse(result);
  }

  Future<void> _handleAuthenticationResponse(
      FirebaseAuthenticationResult authResult) async {
    if (authResult.hasError || authResult.user == null) {
      log.v(
          'User is ${authResult.user}. ${authResult.hasError ? 'There was an error as well.' : 'There were no errors'}');
      setValidationMessage(authResult.errorMessage);
      notifyListeners();
      return;
    }

    final user = authResult.user!;

    await userService.syncOrCreateuserAccount(
      user: User(
        id: user.uid,
        email: user.email,
      ),
    );

    navigationService.replaceWith(successRoute);
  }
}
