import 'package:letus/api/firestore_api.dart';
import 'package:letus/services/user_service.dart';
import 'package:letus/ui/address_selection/address_selection_view.dart';
import 'package:letus/ui/authentication/create_account/create_account_view.dart';
import 'package:letus/ui/authentication/login/login_view.dart';
import 'package:letus/ui/startup/startup_view.dart';
import 'package:letus/ui/user/user_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartUpView),
    MaterialRoute(page: AddressSelectionView),
    MaterialRoute(page: CreateAccountView),
    MaterialRoute(page: UserView),
    MaterialRoute(page: LoginView, initial: true),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: FirestoreApi),
    Singleton(classType: FirebaseAuthenticationService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
