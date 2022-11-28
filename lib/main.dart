import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '/firebase_options.dart';

bool setBackgroundCallback = true;

// ==== Main ============================================================
void main() async {
	print('════ main running ══════════════════════════════════════════════════════════════════════');
	WidgetsFlutterBinding.ensureInitialized();

	await Firebase.initializeApp(
		options: DefaultFirebaseOptions.currentPlatform
	);

	FirebaseMessaging fbMessenger = FirebaseMessaging.instance;

	if( Platform.isIOS ){
		await _applePermissions( fbMessenger );
	}

	print('════ Set foregroundRouter ══════════════════════════════════════════════════════════════');
	FirebaseMessaging.onMessage.listen( foregroundRouter );

	// toggle setBackgroundCallback to show the FlutterJNI.loadLibrary issue.
	if( setBackgroundCallback ){
		print('════ Set backgroundRouter ══════════════════════════════════════════════════════════════');
		FirebaseMessaging.onBackgroundMessage( backgroundRouter );
	}

	String? fbToken = await fbMessenger.getToken();
	print(fbToken);

	runApp(const TwiceApp());
}

// ==== foregroundRouter ======================================================
Future<void> foregroundRouter( RemoteMessage message ) async {
	print('════ foregroundRouter running ══════════════════════════════════════════════════════════');
}

// ==== backgroundRouter ======================================================
Future<void> backgroundRouter( RemoteMessage message ) async {
	print('════ backgroundRouter running ══════════════════════════════════════════════════════════');
}

// _applePermissions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Future<void> _applePermissions( FirebaseMessaging fbMessenger ) async {
	print('════ _applePermissions running ═════════════════════════════════════════════════════════');

	NotificationSettings fbSettings = await fbMessenger.requestPermission(
		alert: true
		, announcement: false
		, badge: true
		, carPlay: false
		, criticalAlert: false
		, provisional: false
		, sound: true
	);
}

// ==== TwiceApp ==============================================================
class TwiceApp extends StatelessWidget {
	const TwiceApp({super.key});

	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			theme: ThemeData(
				primarySwatch: Colors.blue,
			),
			home: const Home()
		);
	}
}

// ==== Home ==================================================================
class Home extends StatelessWidget {
  const Home({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Firetwice Demo'),
			),
			body: const Center( child: Text('App Started') )
		);
	}
}
