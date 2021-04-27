import 'package:letus/app/app.locator.dart';
import 'package:letus/app/app.router.dart';
import 'package:letus/ui/authentication/authentication_viewmodel.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import 'login_view.form.dart';

class LoginViewModel extends AuthenticationViewModel {
  final FirebaseAuthenticationService _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  LoginViewModel() : super(successRoute: Routes.addressSelectionView);

  @override
  Future<FirebaseAuthenticationResult> runAuthentication() =>
      _firebaseAuthenticationService.loginWithEmail(
        email: emailValue!,
        password: passwordValue!,
      );

  void navigateToCreateAccount() =>
      navigationService.navigateTo(Routes.createAccountView);
}
