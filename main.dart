import 'package:app/constants/constants.dart';
import 'package:app/ui/pages/profile_screen.dart';
import 'package:app/ui/pages/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';

import 'ui/pages/bootom_bar_item_data.dart';
import 'ui/pages/home_page.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//void main() {
//runApp( MyApp());
//}
// id, name, email, password, phone, date of birth, level
// id, password
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedInUser = false;
  @override
  initState() {
    super.initState();
    final id = auth.currentUser?.uid;
    print(id);

    if (id != null) {
      loggedInUser = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // check if user is logged in return true else false
    void getCurrentUser() {
      //check to see if the user is logged into firebase from a previous session
      final user = FirebaseAuth.instance.currentUser;

      //if the user is logged in, go to the profile page
      if (user != null) {
        loggedInUser = true;
      }
      //otherwise the user is not logged in, and we need them to authenticate
      else {
        loggedInUser = false;
      }
    }

    // TODO: implement build
    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context) {
          return MaterialApp(
            title: 'Ejaz',
            theme: ThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.teal, // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Colors.blueGrey, // body text color
              ),
              primaryColor: Colors.teal,
              accentColor: Colors.amber,
              appBarTheme: AppBarTheme(
                backgroundColor: kSecondaryColor,
                centerTitle: true,
                titleTextStyle: TextStyle(
                  color: Colors.teal,
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: ScreenUtil().setSp(16),
                ),
                hintStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: ScreenUtil().setSp(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: Colors.white,
                hourMinuteColor: Colors.teal,
                dialBackgroundColor: Colors.white,
                dialHandColor: Colors.amber,
                hourMinuteTextColor: Colors.white,
                dayPeriodTextColor: Colors.amber,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.amber,
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setSp(8),
                    horizontal: ScreenUtil().setSp(16),
                  ),
                ),
              ),
            ),
            locale: Locale('en'),

            localizationsDelegates: const [
              FormBuilderLocalizations.delegate,
            ],
            //home: NavigationScreen(),
            debugShowCheckedModeBanner: false,

            initialRoute: loggedInUser ? '/' : '/login',
            routes: routes,
          );
        });
  }
}

class NavigationScreen extends StatefulWidget {
  int selectedIdx = 0;
  final List<BottomBarItemData> screens = [
    BottomBarItemData(
        '',
        Icon(Icons.home),
        HomePage(
          title: 'Home',
        )),
    BottomBarItemData((''), Icon(Icons.search), SearchScreen()),
    BottomBarItemData((''), Icon(Icons.person), ProfileScreen()),
  ];

  NavigationScreen({Key? key}) : super(key: key);
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.selectedIdx,
          onTap: (idx) => setState(() {
            widget.selectedIdx = idx;
          }),
          items: widget.screens
              .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.label))
              .toList(),
        ),
        body: IndexedStack(
          index: widget.selectedIdx,
          children: [...widget.screens.map((e) => e.screen).toList()],
        ));
  }
}
