import 'package:chat_cheta/utils/allimports.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(appimage), fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Log In or Sign Up",
                  style: TextStyle(color: buttoncolor, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                ElevatedButtonWidget(
                  onPressed: () {
                    Get.to(LoginScreen());
                  },
                  buttonborderRadius: 30,
                  buttonWidth: 180,
                  buttonHeight: 50,
                  buttonBackgroundColor: buttoncolor,
                  child: Text(
                    "Log In",
                    style: TextStyle(color: textcolor, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                ElevatedButtonWidget(
                  onPressed: () {
                    Get.to(SignUpScreen());
                  },
                  buttonborderRadius: 30,
                  buttonWidth: 180,
                  buttonHeight: 50,
                  buttonBackgroundColor: buttoncolor,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: textcolor, fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Text(
                  "Engineered by",
                  style: TextStyle(color: buttoncolor, fontSize: 15),
                ),
                Container(
                  height: 70,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/applicatte_logo.png"),
                          fit: BoxFit.cover)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
