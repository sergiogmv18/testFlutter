import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:test/style.dart';

 /* Pin code custom 
  * @author  SVM        - 20220708
  * @version 1.0        - 20220708    - initial release
  * @param   <Funtion>  - onCompleted - know that the values are complete
  * @param   <Funtion>  - onChanged   - move in status prior to being written complete
  * @param   <Funtion>  - validator   - validate the inserted value
  * @return <Component> - PinCodeCustom  
  */
class PinCodeCustom extends StatelessWidget {
  final Function(String)? onCompleted;
  final String? Function(String?)?  validator;
  final Function(String) onChanged;
  const PinCodeCustom({Key? key, this.onCompleted, this.validator, required this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      mainAxisAlignment: MainAxisAlignment.center,
      pastedTextStyle: const TextStyle(
        color:  Color.fromARGB(255, 70, 70, 70),
        fontWeight: FontWeight.bold,
      ),
      length: 6,
      obscureText: true,
      obscuringCharacter: '*',
      blinkWhenObscuring: true,
      animationType: AnimationType.scale,
      validator: validator,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(0),
        fieldHeight: 50,
        fieldWidth: 40,
        fieldOuterPadding:  const EdgeInsets.fromLTRB(7, 0, 7, 0),
        inactiveColor: CustomColors().frontColor,
        activeFillColor: CustomColors().aiAqua,
        activeColor: CustomColors().frontColor,
        selectedFillColor: CustomColors().aiAqua,
        selectedColor: CustomColors().frontColor,
        inactiveFillColor: Colors.white,
      ),
      cursorColor: CustomColors().frontColor,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      boxShadows: const [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.black12,
          blurRadius: 10,
        )
      ],
      onCompleted: onCompleted,
      onChanged: onChanged,
    );
  }
}



