import 'package:chat_cheta/utils/allimports.dart';

class ReciverProfileScreen extends StatefulWidget {
  final String image;
  final String name;
  final String email;
  final String about;

  const ReciverProfileScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.email,
      required this.about});

  @override
  State<ReciverProfileScreen> createState() => _ReciverProfileScreenState();
}

class _ReciverProfileScreenState extends State<ReciverProfileScreen> {
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
            CircleAvatar(
              radius: 50, // Adjust the radius to set the desired size
              backgroundColor: textcolor, // Set the background color
              backgroundImage: widget.image == "" || widget.image == " "
                  ? AssetImage('assets/images/user.png')
                  : NetworkImage(widget.image) as ImageProvider<Object>,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              widget.name,
              style: TextStyle(
                  color: buttoncolor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.about,
              style: TextStyle(
                  color: buttoncolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.email,
              style: TextStyle(
                  color: buttoncolor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButtonWidget(
              onPressed: () {
                Get.back();
              },
              buttonborderRadius: 30,
              buttonWidth: 180,
              buttonHeight: 50,
              buttonBackgroundColor: buttoncolor,
              child: Text(
                "Open Chat",
                style: TextStyle(color: textcolor, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
