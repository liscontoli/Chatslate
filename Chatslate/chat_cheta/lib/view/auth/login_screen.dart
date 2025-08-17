import 'package:chat_cheta/utils/allimports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final signinsvc = Get.put(SignInServices());
  bool _isValidEmail(String value) {
    final emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(emailRegex);
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(appimage), fit: BoxFit.cover)),
              ),
              Text(
                "Sign In",
                style: TextStyle(color: textcolor, fontSize: 40),
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: signinsvc.formkeyy,
                  child: Column(
                    children: [
                      TextFormFieldWgt(
                        borderRadius: 30,
                        hintText: "Email",
                        controller: signinsvc.emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                          } else if (!_isValidEmail(value)) {
                            return Utils.toastMessage("Error",
                                "Please enter a valid email", Colors.red);
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PwdTextFormFieldWgt(
                        borderRadius: 30,
                        hintText: "Password",
                        controller: signinsvc.passwordcontroller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              GetBuilder<SignInServices>(builder: (logic) {
                return logic.isloading == true.obs
                    ? CircularProgressIndicator(
                        color: buttoncolor,
                      )
                    : ElevatedButtonWidget(
                        onPressed: () {
                          signinsvc.IsSignIn();
                        },
                        buttonborderRadius: 30,
                        buttonWidth: 180,
                        buttonHeight: 50,
                        buttonBackgroundColor: buttoncolor,
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: textcolor, fontSize: 18),
                        ),
                      );
              }),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
