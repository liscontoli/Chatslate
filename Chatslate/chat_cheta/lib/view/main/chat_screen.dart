
import 'package:chat_cheta/utils/allimports.dart';

import '../../utils/bubbleSpecialTree.dart';
import '../../utils/messagebarwgt.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({
    Key? key,
    required this.userEmail,
    required this.currentUserLocale,
    required this.model,
  }) : super(key: key);
  String userEmail, currentUserLocale;
  GetContactModel model;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
  double calculateContainerHeight(int messageCount) {
    final singleMessageHeight =
        58.0; // Adjust this value according to your message container height
    final extraHeight = 40.0; // Additional height for padding and spacing

    return messageCount * singleMessageHeight + extraHeight;
  }
}

class _ChatScreenState extends State<ChatScreen> {
  ChatService service = ChatService();
  var user = FirebaseAuth.instance.currentUser;
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appcolor,
      appBar: PreferredSize(
          child: Container(
            margin: EdgeInsets.only(top: 38),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                GestureDetector(
                  onTap: () {
                    Get.to(ReciverProfileScreen(
                      image: widget.model.image!,
                      name: widget.model.name!,
                      email: widget.userEmail,
                      about: widget.model.aboutus!,
                    ));
                  },
                  child: Container(
                    height: 70,
                    width: w - 60,
                    decoration: BoxDecoration(
                      color: buttoncolor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 3, bottom: 3, left: 10, right: 10),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: appcolor,
                            backgroundImage: widget.model.image == "" ||
                                    widget.model.image == " " ||
                                    widget.model.image == null
                                ? AssetImage('assets/images/user.png')
                                : NetworkImage(widget.model.image.toString())
                                    as ImageProvider<Object>,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.model.name ?? "",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(widget.model.aboutus ?? "",
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
                ),
              ],
            ),
          ),
          preferredSize: Size(100, 140)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),

              // Row(
              //   children: [
              //     Padding(
              //       padding:
              //           const EdgeInsets.only(top: 10, left: 10, right: 10),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           GestureDetector(
              //               onTap: () {
              //                 Navigator.pop(context);
              //               },
              //               child: Icon(Icons.arrow_back)),
              //         ],
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Get.to(ReciverProfileScreen(
              //           image: widget.model.image!,
              //           name: widget.model.name!,
              //           email: widget.userEmail,
              //           about: widget.model.aboutus!,
              //         ));
              //       },
              //       child: Container(
              //         height: 70,
              //         width: w - 60,
              //         decoration: BoxDecoration(
              //           color: buttoncolor,
              //           borderRadius: BorderRadius.circular(20),
              //           border: Border.all(width: 1),
              //         ),
              //         child: Row(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(
              //                   top: 3, bottom: 3, left: 10, right: 10),
              //               child: CircleAvatar(
              //                 radius: 30,
              //                 backgroundColor: appcolor,
              //                 backgroundImage: widget.model.image == "" ||
              //                         widget.model.image == " " ||
              //                         widget.model.image == null
              //                     ? AssetImage('assets/images/user.png')
              //                     : NetworkImage(widget.model.image.toString())
              //                         as ImageProvider<Object>,
              //               ),
              //             ),
              //             Expanded(
              //               flex: 3,
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Row(
              //                     children: [
              //                       Text(
              //                         widget.model.name ?? "",
              //                         style: TextStyle(
              //                             color: Colors.black,
              //                             fontSize: 17,
              //                             fontWeight: FontWeight.bold),
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(
              //                     height: 5,
              //                   ),
              //                   Row(
              //                     children: [
              //                       Text(widget.model.aboutus ?? "",
              //                           style: TextStyle(
              //                             color: Colors.white,
              //                           )),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              SizedBox(
                height: 10,
              ),
              StreamBuilder<List<ChatModel>>(
                  stream: service.getMessagesInRealTime(
                      widget.userEmail, user!.email),
                  builder: (context, snapshot) {
                    return Container(
                      height: h - 190,
                      color: buttoncolor.withOpacity(0.3),
                      child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: ((context, index) {
                          List<ChatModel> list = [];
                          list.addAll(snapshot.data ?? []);

                          bool isDeleted = list[index].deletedBy?.length == 0
                              ? false
                              : list[index].deletedBy?.any((element) =>
                                      (element.userEmail ==
                                          FirebaseAuth
                                              .instance.currentUser?.email)) ??
                                  false;
                          if (list[index].senderEmail != user!.email) {
                            final controller = Get.put(ChatService());
                            controller.updateMessage(
                                snapshot.data![index].snapshotId.toString());
                          }
                          if (!isDeleted) {
                            if (list[index].senderEmail == user!.email) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    BubbleSpecialThree(
                                      tail: false,
                                      text: list[index].messageBody ?? "",
                                      delivered: true,
                                      color: textcolor,
                                      dateTime: list[index].dateTime!,
                                      textStyle: TextStyle(
                                          fontSize: 16, color: buttoncolor),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        FutureBuilder(
                                          future: translate(
                                              list[index]
                                                  .messageBody
                                                  .toString(),
                                              widget.currentUserLocale,
                                              otherUserLang:
                                                  list[index].senderLocale!),
                                          builder: (context, snapshot) {
                                            if (snapshot.data == null) {
                                              return Container();
                                            } else {
                                              return BubbleSpecialThree(
                                                tail: false,
                                                text: snapshot.data.toString(),
                                                color: chatcolor,
                                                dateTime: list[index].dateTime!,
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: buttoncolor),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            return Container();
                          }
                        }),
                      ),
                    );
                  }),

              MessageBar(
                textController: messageController,
                onpress: (){
                  if (messageController.text.isNotEmpty ||
                                  messageController.text != "") {
                                service.addChat(
                                  ChatModel(
                                    fcmToken: widget.model.fcmToken,
                                    senderLocale: widget.model.locale,
                                    dateTime: DateTime.now().toIso8601String(),
                                    messageBody: messageController.text,
                                    reciverEmail: widget.model.email,
                                    senderEmail: user!.email,
                                    timeSpan: DateTime.now().millisecondsSinceEpoch,
                                  ),
                                  widget.model,
                                );
                                messageController.text = "";
                              } else {
                                print("Empty");
                              }
                },
              )

              // Container(
              //   height: 10,
              //   width: w,
              //   child: Expanded(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 5),
              //           child: TextFormFieldWgt(
              //
              //             keyboardType: TextInputType.multiline,
              //             maxline: 5,
              //             hintText: "Message",
              //             borderRadius: 30,
              //             controller: messageController,
              //           ),
              //         ),
              //         GestureDetector(
              //           onTap: () {
              //             if (messageController.text.isNotEmpty ||
              //                 messageController.text != "") {
              //               service.addChat(
              //                 ChatModel(
              //                   fcmToken: widget.model.fcmToken,
              //                   senderLocale: widget.model.locale,
              //                   dateTime: DateTime.now().toIso8601String(),
              //                   messageBody: messageController.text,
              //                   reciverEmail: widget.model.email,
              //                   senderEmail: user!.email,
              //                   timeSpan: DateTime.now().millisecondsSinceEpoch,
              //                 ),
              //                 widget.model,
              //               );
              //               messageController.text = "";
              //             } else {
              //               print("Empty");
              //             }
              //           },
              //           child: Icon(
              //             Icons.send,
              //             size: 30,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
