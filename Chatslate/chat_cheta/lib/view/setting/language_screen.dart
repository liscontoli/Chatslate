import 'package:chat_cheta/utils/allimports.dart';

class LanguageScreen extends StatefulWidget {
  final int selected;
  const LanguageScreen({Key? key, required this.selected}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedLanguageIndex = widget.selected;
    filteredLanguageList = languagelist;
  }

  List languagelist = [
    {"displayName": "English", "locale": "en"},
    {"displayName": "Spanish", "locale": "es"},
    {"displayName": "Urdu", "locale": "ur"},
    {"displayName": "Arabic", "locale": "ar"},
    {"displayName": "Portuguese", "locale": "pt"},
    {"displayName": "German", "locale": "de"},
    {"displayName": "Hindi", "locale": "hi"},
    {"displayName": "Persian", "locale": "fa"},
    {"displayName": "Bengali", "locale": "bn"},
    {"displayName": "French", "locale": "fr"},
    {"displayName": "Italian", "locale": "it"},
    {"displayName": "Russian", "locale": "ru"},
    {"displayName": "Japanese", "locale": "ja"},
    {"displayName": "Chinese", "locale": "zh-TW"},
    {"displayName": "Korean", "locale": "ko"},
    {"displayName": "Turkish", "locale": "tr"},
    {"displayName": "Dutch", "locale": "nl"},
    {"displayName": "Swedish", "locale": "sv"},
    {"displayName": "Norwegian", "locale": "no"},
    {"displayName": "Greek", "locale": "el"},
    {"displayName": "Romanian", "locale": "ro"},
    {"displayName": "Tamil", "locale": "ta"},
    {"displayName": "Telugu", "locale": "te"},
    {"displayName": "Ukrainian", "locale": "uk"},
    {"displayName": "Polish", "locale": "pl"},
    {"displayName": "Indonesian", "locale": "id"},
    {"displayName": "Danish", "locale": "da"},
    {"displayName": "Finnish", "locale": "fi"},
    {"displayName": "Czech", "locale": "cs"},
    {"displayName": "Slovak", "locale": "sk"},
    {"displayName": "Hungarian", "locale": "hu"},
    {"displayName": "Bulgarian", "locale": "bg"},
    {"displayName": "Croatian", "locale": "hr"},
    {"displayName": "Serbian", "locale": "sr"},
    {"displayName": "Slovenian", "locale": "sl"},
    {"displayName": "Albanian", "locale": "sq"},
    {"displayName": "Estonian", "locale": "et"},
    {"displayName": "Latvian", "locale": "lv"},
    {"displayName": "Lithuanian", "locale": "lt"},
    {"displayName": "Vietnamese", "locale": "vi"},
    {"displayName": "Thai", "locale": "th"},
    {"displayName": "Malay", "locale": "ms"},
    {"displayName": "Swahili", "locale": "sw"},
    {"displayName": "Hebrew", "locale": "he"},
    {"displayName": "Kannada", "locale": "kn"},
    {"displayName": "Malayalam", "locale": "ml"},
    {"displayName": "Gujarati", "locale": "gu"},
    {"displayName": "Icelandic", "locale": "is"},
    {"displayName": "Pashto", "locale": "ps"},
    {"displayName": "Swedis", "locale": "sv"},
    {"displayName": "Lao", "locale": "lo"},
    {"displayName": "Nepali", "locale": "ne"},
    {"displayName": "Marathi", "locale": "mr"},
    {"displayName": "Hausa", "locale": "ha"},
    {"displayName": "Maori", "locale": "mi"},
    {"displayName": "Yoruba", "locale": "yo"},
    {"displayName": "Afrikaans", "locale": "af"},
    {"displayName": "Irish", "locale": "ga"},
    {"displayName": "Basque", "locale": "eu"},
    {"displayName": "Welsh", "locale": "cy"},
    {"displayName": "Armenian", "locale": "hy"},
    {"displayName": "Georgian", "locale": "ka"},
    {"displayName": "Azerbaijani", "locale": "az"},
    {"displayName": "Kurdish", "locale": "ku"},
    {"displayName": "Kazakh", "locale": "kk"},
    {"displayName": "Kyrgyz", "locale": "ky"},
    {"displayName": "Uzbek", "locale": "uz"},
    {"displayName": "Tajik", "locale": "tg"},
    {"displayName": "Pashto", "locale": "ps"},
    {"displayName": "Amharic", "locale": "am"},
    {"displayName": "Oromo", "locale": "om"},
    {"displayName": "Somali", "locale": "so"},
    {"displayName": "Maltese", "locale": "mt"},
    {"displayName": "Haitian Creole", "locale": "ht"},
    {"displayName": "Luxembourgish", "locale": "lb"},
    {"displayName": "Malay", "locale": "ms"},
    {"displayName": "Catalan", "locale": "ca"},
  ];
  List filteredLanguageList = [];
  SharedPreferences? sharedPreferences;

  late int selectedLanguageIndex;

  Future<void> removeIndex() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.remove('selectedLanguageIndex');
  }

  Future<void> saveSelectedLanguageIndex(int index) async {
    sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences!.setInt('selectedLanguageIndex', index);
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
                    "Language",
                    style: TextStyle(color: textcolor, fontSize: 27),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Choose the language you want to",
                style: TextStyle(color: buttoncolor, fontSize: 15),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "receive your messages in",
                style: TextStyle(color: buttoncolor, fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormFieldWgt(
                  hintText: "Search",
                  borderRadius: 30,
                  sufixicon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onChanged: (val) {
                    if (val == null || val == "") {
                      filteredLanguageList = languagelist;
                    } else {
                      filteredLanguageList = languagelist
                          .where((e) => e['displayName']
                              .toString()
                              .toLowerCase()
                              .contains(val.toLowerCase()))
                          .toSet()
                          .toList();
                    }
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: h - 370,
                width: 220,
                child: ListView.builder(
                    itemCount: filteredLanguageList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLanguageIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          height: 55,
                          width: 10,
                          decoration: BoxDecoration(
                            color: selectedLanguageIndex == index
                                ? Colors.black
                                : buttoncolor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              filteredLanguageList[index]["displayName"],
                              style: TextStyle(
                                  color: selectedLanguageIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButtonWidget(
                onPressed: () {
                  saveSelectedLanguageIndex(selectedLanguageIndex);
                  final controller = Get.put(ProfileServices());
                  controller.updateUserLocale(
                      filteredLanguageList[selectedLanguageIndex]["locale"]);
                  Get.offAll(MainScreen());
                },
                buttonborderRadius: 30,
                buttonWidth: 180,
                buttonHeight: 50,
                buttonBackgroundColor: buttoncolor,
                child: Text(
                  "Save",
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
