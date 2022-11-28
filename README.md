# firetwice

Test project to figure out why FlutterJNI.loadLibrary called more than once

I/flutter ( 9470): === backgroundRouter =============================
W/FlutterJNI( 9470): FlutterJNI.loadLibrary called more than once

I have already determined that FirebaseMessaging.onBackgroundMessage( backgroundRouter ); was the cause of the two main instances
That issue was fixed ( rolled back feature ) in a FlutterFire update.  The double FlutterJNI.loadLibrary is also a issue coming
from the onBackgroundMessage calling feature.

This aims to be a min project to demo the issue

There are two Firebase files missing from the repo.  Follow the FlutterFire docs to place these to files.  Below are the file locations
* {root}/android/app/**google-services.json**
* {root}/lib/**firebase_options.dart**
