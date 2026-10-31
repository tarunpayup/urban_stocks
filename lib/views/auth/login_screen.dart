import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_market/core/utils/validators.dart';
import 'package:stock_market/core/widgets/custom_widgets.dart';
import 'package:stock_market/viewmodels/auth/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _handleLogin(LoginViewmodel vm) async{
    if(_formKey.currentState!.validate()){
      final success = await vm.login(
        _emailController.text.trim(), 
        _passwordController.text.trim()
        );

      if(success){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Successful"))
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error Occurred"))
        );        
      }  
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(vm.errorMessage))
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
      create: (_) => LoginViewmodel(),
      child: Consumer<LoginViewmodel>(
        builder: (context, vm, _){
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Urban Stock',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 35,),
                      const Text(
                        'Login to Continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                      ),
                      const SizedBox(height: 32,),
                      CustomTextField(
                        customController: _emailController, 
                        customLabel: "Email",
                        customKeyboardType: TextInputType.emailAddress,
                        customValidator: Validators.validateEmail,
                        ),
                        const SizedBox(height: 16,),
                      CustomTextField(
                        customController: _passwordController, 
                        customObscureText: vm.obscurePassword,
                        customLabel: "Password",
                        customKeyboardType: TextInputType.emailAddress,
                        customValidator: Validators.validatePassword,
                        customSuffixIcon: IconButton(
                            icon: Icon(
                              vm.obscurePassword? Icons.visibility_off : Icons.visibility
                            ),
                            onPressed: vm.togglePasswordVisibility,
                          ),
                        ),
                        const SizedBox(height: 24,),
                        CustomButton(
                          customText: "Login", 
                          customOnPressed: () => _handleLogin(vm),
                          isLoading: vm.state==ViewState.loading,
                          )

                    ],
                  ),
                  ),
                )
                ),
          );
        }
        
        ),
    
    );
  }
}