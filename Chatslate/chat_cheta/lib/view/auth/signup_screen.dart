
import 'package:chat_cheta/utils/allimports.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signupsvc = Get.put(SignupServices());

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
                        image: AssetImage(appimage), fit: BoxFit.cover),
                ),
              ),
              Text(
                "Sign Up",
                style: TextStyle(color: textcolor, fontSize: 40),
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: signupsvc.formkey,
                  child: Column(
                    children: [
                      TextFormFieldWgt(
                        borderRadius: 30,
                        hintText: "Name",
                        controller: signupsvc.namecontroller,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWgt(
                        borderRadius: 30,
                        hintText: "Email",
                        controller: signupsvc.emailcontroller,
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
                        controller: signupsvc.passwordcontroller,
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
                height: 60,
              ),
              GetBuilder<SignupServices>(builder: (logic) {
                return logic.isloading == true.obs
                    ? CircularProgressIndicator(
                        color: buttoncolor,
                      )
                    : ElevatedButtonWidget(
                        onPressed: () {
                          signupsvc.IsSignup();
                        },
                        buttonborderRadius: 30,
                        buttonWidth: 180,
                        buttonHeight: 50,
                        buttonBackgroundColor: buttoncolor,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: textcolor, fontSize: 18),
                        ),
                      );
              },
              ),
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
