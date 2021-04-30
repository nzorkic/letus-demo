import 'package:letus/app/app.locator.dart';
import 'package:letus/app/app.logger.dart';
import 'package:letus/app/app.router.dart';
import 'package:letus/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// "BUSINESS LOGIC" AND VIEW STATE

class StartUpViewModel extends BaseViewModel {
  final log = getLogger('StartUpViewModel');
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();

  Future<void> runStartupLogic() async {
    if (_userService.hasLoggedInUser) {
      log.v('We have a user session on disk. Sync the user profile ...');
      await _userService.syncUserAccount();

      final currentUser = _userService.currentUser;
      log.v('User sync complete. User profile: $currentUser');

      _navigationService.navigateTo(Routes.userView);
    } else {
      log.v('No user on disk, navigate to the LoginView');
      _navigationService.replaceWith(Routes.loginView);
    }
  }
}
