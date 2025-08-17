import 'package:chat_cheta/utils/allimports.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = Get.put(ContactServices());
  final chatController = Get.put(ChatService());
  GetContactModel? model;
  @override
  void initState() {
    controller.getContactsForChats();
    super.initState();
  }

  void getUser() async {
    model = await controller.getSingleUser();
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingScreen()),
                          );
                        },
                        child: Icon(
                          Icons.more_vert,
                          size: 30,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactScreen()),
                        );
                      },
                      child: Icon(
                        Icons.perm_contact_cal,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chats",
                    style: TextStyle(color: textcolor, fontSize: 27),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    height: h - 230,
                    child: GetBuilder<ContactServices>(builder: (controller) {
                      if (controller.isLoading.value) {
                        return Container(
                          height: h - 320,
                          child: Center(
                            child: CircularProgressIndicator(color: textcolor),
                          ),
                        );
                      } else if (controller.contactlist.isEmpty ||
                          controller.contactlist == null ||
                          controller.contactlist.length == 0 ||
                          controller.contactlist == []) {
                        return Container(
                          height: h - 320,
                          child: Center(child: Text("No Chats")),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: controller.contactlist.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                var model = await controller.getSingleUser();
                                controller.updateReadeStatus();
                                controller.getContacts();
                                currentUser =
                                    controller.contactlist[index].name!;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      model: controller.contactlist[index],
                                      currentUserLocale: model.locale!,
                                      userEmail:
                                          controller.contactlist[index].email!,
                                    ),
                                  ),
                                );
                              },
                              child: GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Delete Chat'),
                                        content: Text(
                                            'Are you sure you want to delete this chat?'),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Delete'),
                                            onPressed: () {
                                              // Perform the delete operation here
                                              final chatcontroller =
                                                  Get.put(ChatService());
                                              chatcontroller.deleteUserChats(
                                                  controller.contactlist[index]
                                                      .email);
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 0.01,
                                      top: 10),
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
                                          backgroundColor:
                                              appcolor, // Set the background color
                                          backgroundImage: controller
                                                          .contactlist[index]
                                                          .image ==
                                                      "" ||
                                                  controller.contactlist[index]
                                                          .image ==
                                                      " " ||
                                                  controller.contactlist[index]
                                                          .image ==
                                                      null
                                              ? AssetImage(
                                                  'assets/images/user.png')
                                              : NetworkImage(controller
                                                      .contactlist[index].image
                                                      .toString())
                                                  as ImageProvider<Object>,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  controller.contactlist[index]
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
                                            FutureBuilder(
                                              future:
                                                  controller.getSingleUser(),
                                              builder: (context, snapshot2) {
                                                if (snapshot2.data == null) {
                                                  return Container();
                                                } else {
                                                  return StreamBuilder(
                                                    stream: chatController
                                                        .getLastMessage(
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .email!,
                                                            controller
                                                                .contactlist[
                                                                    index]
                                                                .email!),
                                                    builder:
                                                        (context, snapshot1) {
                                                      if (snapshot1.data ==
                                                          null) {
                                                        return Container();
                                                      } else {
                                                        return FutureBuilder(
                                                          future: translate(
                                                            snapshot1.data?.messageBody ==
                                                                        "" ||
                                                                    snapshot1
                                                                            .data
                                                                            ?.messageBody ==
                                                                        null
                                                                ? "say hi to ${controller.contactlist[index].name}"
                                                                : snapshot1.data
                                                                        ?.messageBody ??
                                                                    "",
                                                            snapshot2.data
                                                                    ?.locale ??
                                                                "en",
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot.data ==
                                                                null) {
                                                              return Container();
                                                            } else {
                                                              return Text(
                                                                  snapshot
                                                                      .data!,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ));
                                                            }
                                                          },
                                                        );
                                                      }
                                                    },
                                                  );
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      StreamBuilder(
                                        stream: chatController.getLastMessage(
                                            FirebaseAuth
                                                .instance.currentUser!.email!,
                                            controller
                                                .contactlist[index].email!),
                                        builder: (context, snapshot) {
                                          return Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                snapshot.data?.isRead ==
                                                            false &&
                                                        snapshot.data!
                                                                .senderEmail!
                                                                .toLowerCase() !=
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .email
                                                                ?.toLowerCase()
                                                    ? Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration: BoxDecoration(
                                                            color: appcolor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                      )
                                                    : Text(
                                                        controller
                                                                    .contactlist[
                                                                        index]
                                                                    .lastMessage ==
                                                                ""
                                                            ? ""
                                                            : DateFormat(
                                                                    'MM-dd-yy')
                                                                .format(DateTime.parse(controller
                                                                    .contactlist[
                                                                        index]
                                                                    .lastMessageDate
                                                                    .toString())),
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButtonWidget(
                onPressed: () {
                  Get.to(ContactScreen());
                },
                buttonborderRadius: 30,
                buttonWidth: 180,
                buttonHeight: 50,
                buttonBackgroundColor: buttoncolor,
                child: Text(
                  "New",
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
