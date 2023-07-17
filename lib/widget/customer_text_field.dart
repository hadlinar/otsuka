import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum INPUT_TYPE {
  PERSEN,
  TEXT,
}

class CustomTextField extends FormField<String> {
  CustomTextField({
    required String label,
    FocusNode? focusNode,
    String? hint,
    Widget? suffixIcon,
    bool? obsecureText,
    TextEditingController? controller,
    ValueChanged<String>? onChange,
    int maxLines = 1,
    int maxLength = 100,
    bool showCounterText = false,
    INPUT_TYPE inputType = INPUT_TYPE.TEXT,
    double padding = 10,
    TextInputType keyboardType = TextInputType.text,
  }) : super(builder: (FormFieldState<String> state) {
    void onChangedHandler(String value) {
      if (onChange != null) {
        onChange(value);
      }
      state.didChange(value);
    }

    return Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: SizedBox(
          child: TextFormField(
            keyboardType: inputType == INPUT_TYPE.PERSEN
                ? TextInputType.phone
                : keyboardType,
            style: TextStyle(fontSize: 15, fontFamily: 'medium'),
            onChanged: onChangedHandler,
            controller: controller,
            maxLines: maxLines,
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLength),
            ],
            obscureText: obsecureText ?? false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 5,left: 7,top: 5),
                counterText: showCounterText
                    ? "${controller?.text.length}/$maxLength"
                    : null,
                labelText: label,
                hintText: hint,
                alignLabelWithHint: true,border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide()
            ),
                suffixIcon: suffixIcon ?? null
            ),validator: (value) {
            if (inputType == INPUT_TYPE.PERSEN) {
              if (int.parse(value!) < 0 || int.parse(value) > 100) {
                return "Masukkan input 0 hingga 100";
              }
              return null;
            }
            return null;
          },
          ),
        )
    );});
}