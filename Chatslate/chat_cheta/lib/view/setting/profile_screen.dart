import 'package:chat_cheta/utils/allimports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profilesrv = Get.put(ProfileServices());

  @override
  void initState() {
    super.initState();
    profilesrv.fetchUserData();
  }

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
                    "Profile",
                    style: TextStyle(color: textcolor, fontSize: 27),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Stack(
                children: [
                  GetBuilder<ProfileServices>(builder: (c) {
                    return CircleAvatar(
                      radius: 50, // Adjust the radius to set the desired size
                      backgroundColor: textcolor, // Set the background color
                      backgroundImage: c.image == null
                          ? (c.imagepath?.value == "" ||
                                  c.imagepath?.value == " " ||
                                  c.imagepath?.value == null
                              ? AssetImage(
                                  "assets/images/user.png",
                                )
                              : NetworkImage(c.imagepath!.value)
                                  as ImageProvider<Object>)
                          : FileImage(c.image!),
                    );
                  }),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        profilesrv.pickImage();
                      },
                      child: Icon(
                        Icons.add_circle,
                        color: buttoncolor,
                        size: 28.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    TextFormFieldWgt(
                      hintText: "Name",
                      borderRadius: 30,
                      controller: profilesrv.namecontroller,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFieldWgt(
                      hintText: "About",
                      borderRadius: 30,
                      controller: profilesrv.aboutuscontroller,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFieldWgt(
                      enable: false,
                      hintText: "Email",
                      borderRadius: 30,
                      controller: profilesrv.emailcontroller,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              GetBuilder<ProfileServices>(builder: (logic) {
                return logic.isloading == true.obs
                    ? CircularProgressIndicator(
                        color: buttoncolor,
                      )
                    : ElevatedButtonWidget(
                        onPressed: () {
                          if (profilesrv.namecontroller.text.isEmpty ||
                              profilesrv.aboutuscontroller.text.isEmpty ||
                              profilesrv.emailcontroller.text.isEmpty) {
                            // Display error message for empty fields
                            Utils.toastMessage("Error",
                                "Please fill in all fields", Colors.red);
                          } else {
                            final newName = profilesrv.namecontroller.text;
                            final newAbout = profilesrv.aboutuscontroller.text;
                            final newEmail = profilesrv.emailcontroller.text;
                            profilesrv.updateUserData(
                                newName, newAbout, newEmail);
                          }
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
