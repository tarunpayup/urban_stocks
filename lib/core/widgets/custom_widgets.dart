import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController customController;
  final String customLabel;
  final bool customObscureText;
  final Widget? customSuffixIcon;
  final TextInputType customKeyboardType;
  final String? Function(String?)? customValidator;

  const CustomTextField({
    super.key,
    required this.customController,
    required this.customLabel,
    this.customObscureText = false,
    this.customSuffixIcon,
    this.customKeyboardType = TextInputType.text,
    this.customValidator
  });

  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: customController,
      obscureText: customObscureText,
      keyboardType: customKeyboardType,
      validator: customValidator,
      decoration: InputDecoration(
        labelText: customLabel,
        suffixIcon: customSuffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        )
      ),
    );
  }


}

class CustomButton extends StatelessWidget{
  final String customText;
  final VoidCallback customOnPressed;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.customText,
    required this.customOnPressed,
    this.isLoading = false
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading? null:customOnPressed, 
        child: isLoading
        ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        ): Text(customText, style: const TextStyle(fontSize: 16),)
        ),
    );
  }
}