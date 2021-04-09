import 'package:floating_action_button_example/page/new_message_page.dart';
import 'package:floating_action_button_example/widget/selector_widget.dart';
import 'package:floating_action_button_example/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Floating Action Button';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primaryColor: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  FloatingActionButtonLocation location = FloatingActionButtonLocation.endFloat;

  final locations = [
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.centerFloat,
    FloatingActionButtonLocation.startFloat,
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.startDocked,
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: SelectorWidget<FloatingActionButtonLocation>(
              title: 'Location',
              values: locations,
              toText: (location) => location.toString().split('.')[1],
              onChangedValue: (location) =>
                  setState(() => this.location = location),
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Share',
                onClicked: () => setState(() => index = 0),
              ),
              const SizedBox(height: 16),
              ButtonWidget(
                text: 'Navigation',
                onClicked: () => setState(() => index = 1),
              ),
              const SizedBox(height: 16),
              ButtonWidget(
                text: 'Message',
                onClicked: () => setState(() => index = 2),
              ),
            ],
          ),
        ),
        floatingActionButton: buildActionButton(),
        floatingActionButtonLocation: location,
        bottomNavigationBar: buildBottomBar(),
      );

  Widget buildActionButton() {
    switch (index) {
      case 0:
        return buildShareButton();
      case 1:
        return buildNavigateButton();
      case 2:
      default:
        return buildMessageButton();
    }
  }

  Widget buildBottomBar() => BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {},
      );

  Widget buildNavigateButton() => FloatingActionButton(
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
        onPressed: () {
          print('Pressed');
        },
      );

  Widget buildShareButton() => FloatingActionButton(
        child: Icon(Icons.share),
        backgroundColor: Colors.blue,
        onPressed: () {
          print('Pressed');
        },
      );

  Widget buildMessageButton() => FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        icon: Icon(Icons.message),
        label: Text('Message'),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewMessagePage(),
          ));
        },
      );
}
