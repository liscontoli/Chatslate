
import 'package:chat_cheta/utils/allimports.dart';


class PwdTextFormFieldWgt extends StatefulWidget {
  final double? fontSize;
  final String? hintText;
  final String? labelText;
  final double? height;
  final void Function()? iconPress;
  final double? width;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? autofocus;
  final Color? fontColor;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? enable;
  final Icon? sufixicon;

  const PwdTextFormFieldWgt({   Key? key,
    this.sufixicon,
    this.fontSize,
    this.controller,
    this.validator,
    this.margin,
    this.height,
    this.borderRadius,
    this.padding,
    this.onChanged,
    this.fontColor,
    this.hintText,
    this.width,
    this.enable,
    this.labelText,
    this.autofocus=false,
    this.keyboardType,
    this.iconPress, }) : super(key: key);

  @override
  State<PwdTextFormFieldWgt> createState() => _PwdTextFormFieldWgtState();
}

class _PwdTextFormFieldWgtState extends State<PwdTextFormFieldWgt> {
  bool isPaasword = true;
  @override
  Widget build(BuildContext context){
    return  TextFormField(
      enabled: widget.enable,
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      obscureText: isPaasword,
      cursorColor: buttoncolor,
      style: TextStyle(color: Colors.black,fontSize: 20),
      decoration: InputDecoration(
        filled: true,
        fillColor: textcolor,
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: buttoncolor, width: 2),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 18),
        suffixIcon: GestureDetector(
          onTap: () {
    setState(() {
    isPaasword =! isPaasword;
    });
    },
      child: Icon(isPaasword ? Icons.visibility :Icons.visibility_off,
        color:  buttoncolor,
        size: 24,
      ),
    ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: buttoncolor,width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder:OutlineInputBorder(
          borderSide: BorderSide(color: buttoncolor,width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}