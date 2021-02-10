import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

const MethodChannel _channel =
MethodChannel('android_app_retain');

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  _channel.invokeMethod('wakeFromBackground');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _statusText = "Waiting...";
  final String _finished = "Finished creating channel";
  final String _error = "Error while creating channel";


  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();



  Map<String, String> channelMap = {
    "id": "CHAT_MESSAGES",
    "name": "Chats",
    "description": "Chat notifications",
  };

  void _createNewChannel() async {

  }

  @override
  void initState() {
    super.initState();
    initializeFirebaseMessaging();
  }

  void initializeFirebaseMessaging() async {
   /* _firebaseMessaging.setconfigure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onBackgroundMessage: onBGMessage
    );*/

  /*      (message) async {
      await Firebase.initializeApp();
      _channel.invokeMethod('wakeFromBackground', message);
    }*/
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance.getAPNSToken().then((c) => print(c));
    _createNewChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _statusText,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewChannel,
        child: Icon(Icons.add),
      ),
    );
  }
}
