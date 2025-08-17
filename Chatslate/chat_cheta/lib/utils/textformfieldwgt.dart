import 'package:chat_cheta/utils/allimports.dart';

class TextFormFieldWgt extends StatelessWidget {
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
  final int? maxline;

  const TextFormFieldWgt({
    Key? key,
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
    this.autofocus = false,
    this.keyboardType,
    this.iconPress,
    this.maxline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      controller: controller,
      onChanged: onChanged,
      showCursor: true,
      validator: validator,
      keyboardType: keyboardType,
      cursorColor: buttoncolor,
      style: TextStyle(color: Colors.black, fontSize: 20),
      decoration: InputDecoration(
        filled: true,
        fillColor: textcolor,
        contentPadding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: buttoncolor, width: 2),
        ),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 18),
        suffixIcon: sufixicon,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: buttoncolor, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: buttoncolor, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: buttoncolor, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
