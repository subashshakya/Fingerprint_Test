import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LocalAuthentication auth = LocalAuthentication();

  bool _canCheckBiometrics = false;
  List<BiometricType> _availableBiometrics = [];
  String _authorized = 'notAuthorized';

  Future _cancheckBiometrics() async {
    bool canCheckBiometrics = false;

    try {
      //canCheckBiometrics retruns a boolean value to check if there is hardware support
      //for using the biometrics
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics = [];
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future _authenticate() async {
    bool authenticate = false;

    try {
      authenticate = await auth.authenticate(
        localizedReason: 'Touch the fingerprint sensor',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      print('is working???');
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    setState(() {
      _authorized = authenticate ? 'Authorized' : 'Not Authorized';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checking Biometrics')),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Can Check Biometrics? $_canCheckBiometrics'),
            ElevatedButton(
                onPressed: _cancheckBiometrics,
                child: Text('Check biometrics')),
            SizedBox(width: 0.0, height: 50.0),
            Text('Available Biometrics? $_availableBiometrics'),
            ElevatedButton(
                onPressed: _getAvailableBiometrics,
                child: Text('Get Available Biometrics')),
            SizedBox(width: 0.0, height: 50.0),
            Text('Current State $_authorized'),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('Authenticate'),
            )
          ],
        )),
      ),
    );
  }
}
