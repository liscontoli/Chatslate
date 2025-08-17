import 'package:chat_cheta/utils/allimports.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final logoutsrvc = Get.put(LogoutServices());

  late int selectedLanguageIndex;
  late SharedPreferences sharedPreferences;

  Future<void> initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    selectedLanguageIndex =
        sharedPreferences.getInt('selectedLanguageIndex') ?? 0;
    print(selectedLanguageIndex.toString() + "Farhan");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Settings",
                  style: TextStyle(color: textcolor, fontSize: 27),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButtonWidget(
                    onPressed: () {
                      Get.to(ProfileScreen());
                    },
                    buttonborderRadius: 30,
                    buttonWidth: 180,
                    buttonHeight: 50,
                    buttonBackgroundColor: buttoncolor,
                    child: Text(
                      "Profile",
                      style: TextStyle(color: textcolor, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () {
                      Get.to(LanguageScreen(
                        selected: selectedLanguageIndex,
                      ));
                    },
                    buttonborderRadius: 30,
                    buttonWidth: 180,
                    buttonHeight: 50,
                    buttonBackgroundColor: buttoncolor,
                    child: Text(
                      "Languages",
                      style: TextStyle(color: textcolor, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () {
                      logoutsrvc.logout(context);
                    },
                    buttonborderRadius: 30,
                    buttonWidth: 180,
                    buttonHeight: 50,
                    buttonBackgroundColor: buttoncolor,
                    child: Text(
                      "Logout",
                      style: TextStyle(color: textcolor, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
