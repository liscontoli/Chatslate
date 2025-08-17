import 'package:chat_cheta/utils/allimports.dart';

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({Key? key}) : super(key: key);

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New Contact",
                    style: TextStyle(color: textcolor, fontSize: 27),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormFieldWgt(
                        hintText: "Name",
                        borderRadius: 30,
                        controller: nameController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormFieldWgt(
                        hintText: "Email",
                        controller: emailController,
                        borderRadius: 30,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              GetBuilder<ContactServices>(builder: (logic) {
                return logic.loading == true.obs
                    ? CircularProgressIndicator(
                        color: buttoncolor,
                      )
                    : ElevatedButtonWidget(
                        onPressed: () {
                          final controller = Get.put(ContactServices());
                          controller
                              .isUserExist(emailController.text)
                              .then((value) {
                            if (value) {
                              controller.createContact(
                                  emailController.text, nameController.text);
                              controller.createChatHead(
                                  emailController.text, nameController.text);
                            }
                          });
                        },
                        buttonborderRadius: 30,
                        buttonWidth: 180,
                        buttonHeight: 50,
                        buttonBackgroundColor: buttoncolor,
                        child: Text(
                          "Save",
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
