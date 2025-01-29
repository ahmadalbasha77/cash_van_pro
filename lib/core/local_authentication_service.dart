import 'dart:developer';

import 'package:local_auth/local_auth.dart';

class LocalAuthenticationService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    final bool isDeviceSupported = await auth.isDeviceSupported();

    if (isDeviceSupported) {
      try {
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to access this feature',
          options: const AuthenticationOptions(
            biometricOnly: true,
          ),
        );
        if (didAuthenticate) {
          return didAuthenticate;
        } else {}
        return didAuthenticate;
      } catch (e) {
        log('$e');
      }
    } else {}
    return false;
  }
}
