import 'package:chat_cheta/utils/allimports.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final controller = Get.put(ContactServices());
  @override
  void initState() {
    controller.getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appcolor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    "Contacts",
                    style: TextStyle(color: textcolor, fontSize: 27),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormFieldWgt(
                  hintText: "Search",
                  borderRadius: 30,
                  onChanged: (val) {
                    controller.searchContacts(val);
                  },
                  sufixicon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GetBuilder<ContactServices>(
                init: ContactServices(),
                builder: (controller) {
                  if (controller.isLoading.value) {
                    return Container(
                      height: h - 320,
                      child: Center(
                        child: CircularProgressIndicator(color: textcolor),
                      ),
                    );
                  } else if (controller.searchedlist.isEmpty ||
                      controller.searchedlist == null ||
                      controller.searchedlist.length == 0 ||
                      controller.searchedlist == []) {
                    return Container(
                      height: h - 320,
                      child: Center(child: Text("No Contacts")),
                    );
                  } else {
                    return Container(
                      height: h - 320,
                      child: ListView.builder(
                          itemCount: controller.searchedlist.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                var model = await controller.getSingleUser();
                                controller.updateReadeStatus();
                                controller.getContacts();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      model: controller.searchedlist[index],
                                      currentUserLocale: model.locale!,
                                      userEmail:
                                          controller.searchedlist[index].email!,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 0.01, top: 10),
                                height: 80,
                                width: 500,
                                decoration: BoxDecoration(
                                  color: buttoncolor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(width: 1),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3,
                                          bottom: 3,
                                          left: 10,
                                          right: 10),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: appcolor,
                                        backgroundImage: controller
                                                        .list[index].image ==
                                                    "" ||
                                                controller.list[index].image ==
                                                    " " ||
                                                controller.list[index].image ==
                                                    null
                                            ? AssetImage(
                                                "assets/images/user.png")
                                            : NetworkImage(controller
                                                    .list[index].image
                                                    .toString())
                                                as ImageProvider<Object>,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                controller.searchedlist[index]
                                                        .name ??
                                                    "",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  controller.searchedlist[index]
                                                          .email ??
                                                      "",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButtonWidget(
                onPressed: () {
                  Get.to(NewContactScreen());
                },
                buttonborderRadius: 30,
                buttonWidth: 180,
                buttonHeight: 50,
                buttonBackgroundColor: buttoncolor,
                child: Text(
                  "Add Contacts",
                  style: TextStyle(color: textcolor, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
