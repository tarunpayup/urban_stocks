import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ======================================================
// MAIN APP
// ======================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Signup Demo',
      home: const SignupScreen(),
    );
  }
}

// ======================================================
// SIGNUP SCREEN
// ======================================================

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

// ======================================================
// STATE
// ======================================================

class _SignupScreenState extends State<SignupScreen> {

  // ----------------------------------------------------
  // TEXT CONTROLLERS
  // ----------------------------------------------------

  TextEditingController nameController =
      TextEditingController();

  TextEditingController emailController =
      TextEditingController();

  TextEditingController mobileController =
      TextEditingController();

  TextEditingController passwordController =
      TextEditingController();

  TextEditingController confirmPasswordController =
      TextEditingController();

  // ----------------------------------------------------
  // STATE VARIABLES
  // ----------------------------------------------------

  bool isPasswordVisible = false;

  bool isConfirmPasswordVisible = false;

  bool receiveNotifications = false;

  bool acceptTerms = true;

  String? selectedGender;

  DateTime? selectedDate;

  // ----------------------------------------------------
  // DATE PICKER
  // ----------------------------------------------------

  Future<void> selectDate() async {

    DateTime? pickedDate = await showDatePicker(

      context: context,

      initialDate: DateTime(2000),

      firstDate: DateTime(1950),

      lastDate: DateTime.now(),

    );

    if (pickedDate != null) {

      setState(() {

        selectedDate = pickedDate;

      });

    }
  }

  // ----------------------------------------------------
  // SNACKBAR
  // ----------------------------------------------------

  void showMessage(String message) {

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(message),
      ),

    );
  }

  // ----------------------------------------------------
  // SIGNUP
  // ----------------------------------------------------

  void signup() {

    String name =
        nameController.text.trim();

    String email =
        emailController.text.trim();

    String mobile =
        mobileController.text.trim();

    String password =
        passwordController.text;

    String confirmPassword =
        confirmPasswordController.text;

    // --------------------------------------------------
    // VALIDATION
    // --------------------------------------------------

    if (name.isEmpty) {

      showMessage(
        "Please enter your name",
      );

      return;
    }

    if (email.isEmpty) {

      showMessage(
        "Please enter your email",
      );

      return;
    }

    if (mobile.isEmpty) {

      showMessage(
        "Please enter your mobile number",
      );

      return;
    }

    if (password.isEmpty) {

      showMessage(
        "Please enter your password",
      );

      return;
    }

    if (confirmPassword.isEmpty) {

      showMessage(
        "Please confirm your password",
      );

      return;
    }

    if (password != confirmPassword) {

      showMessage(
        "Passwords do not match",
      );

      return;
    }

    if (selectedGender == null) {

      showMessage(
        "Please select your gender",
      );

      return;
    }

    if (selectedDate == null) {

      showMessage(
        "Please select your date of birth",
      );

      return;
    }

    if (!acceptTerms) {

      showMessage(
        "Please accept Terms & Conditions",
      );

      return;
    }

    // --------------------------------------------------
    // SUCCESS
    // --------------------------------------------------

    showMessage(
      "Signup successful!",
    );
  }

  // ----------------------------------------------------
  // DISPOSE
  // ----------------------------------------------------

  @override
  void dispose() {

    nameController.dispose();

    emailController.dispose();

    mobileController.dispose();

    passwordController.dispose();

    confirmPasswordController.dispose();

    super.dispose();
  }

  // ====================================================
  // BUILD
  // ====================================================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // ==================================================
      // APP BAR
      // ==================================================

      appBar: AppBar(

        title: const Text(
          "Create Account",
        ),

        centerTitle: true,

      ),

      // ==================================================
      // SINGLE CHILD SCROLL VIEW
      // ==================================================

      body: SingleChildScrollView(

        child: Padding(

          padding: const EdgeInsets.all(16),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // ==========================================
              // HEADER
              // ==========================================

              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(

                  color: Colors.blue.shade50,

                  borderRadius:
                      BorderRadius.circular(15),

                ),

                child: Column(

                  children: [

                    const Icon(
                      Icons.person_add,
                      size: 60,
                      color: Colors.blue,
                    ),

                    const SizedBox(height: 10),

                    const Text(

                      "Create Your Account",

                      style: TextStyle(

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,

                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(

                      "Please enter your details",

                      style: TextStyle(

                        color:
                            Colors.grey.shade700,

                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================
              // PERSONAL INFORMATION
              // ==========================================

              Card(

                elevation: 3,

                child: Padding(

                  padding:
                      const EdgeInsets.all(16),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(

                        "Personal Information",

                        style: TextStyle(

                          fontSize: 20,

                          fontWeight:
                              FontWeight.bold,

                        ),
                      ),

                      const SizedBox(height: 20),

                      // FULL NAME
                      TextField(

                        controller:
                            nameController,

                        decoration:
                            const InputDecoration(

                          labelText:
                              "Full Name",

                          prefixIcon:
                              Icon(Icons.person),

                          border:
                              OutlineInputBorder(),

                        ),
                      ),

                      const SizedBox(height: 15),

                      // EMAIL
                      TextField(

                        controller:
                            emailController,

                        keyboardType:
                            TextInputType.emailAddress,

                        decoration:
                            const InputDecoration(

                          labelText:
                              "Email Address",

                          prefixIcon:
                              Icon(Icons.email),

                          border:
                              OutlineInputBorder(),

                        ),
                      ),

                      const SizedBox(height: 15),

                      // MOBILE
                      TextField(

                        controller:
                            mobileController,

                        keyboardType:
                            TextInputType.phone,

                        decoration:
                            const InputDecoration(

                          labelText:
                              "Mobile Number",

                          prefixIcon:
                              Icon(Icons.phone),

                          border:
                              OutlineInputBorder(),

                        ),
                      ),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================
              // ACCOUNT INFORMATION
              // ==========================================

              Card(

                elevation: 3,

                child: Padding(

                  padding:
                      const EdgeInsets.all(16),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(

                        "Account Information",

                        style: TextStyle(

                          fontSize: 20,

                          fontWeight:
                              FontWeight.bold,

                        ),
                      ),

                      const SizedBox(height: 20),

                      // PASSWORD
                      TextField(

                        controller:
                            passwordController,

                        obscureText:
                            !isPasswordVisible,

                        decoration:
                            InputDecoration(

                          labelText:
                              "Password",

                          prefixIcon:
                              const Icon(
                                Icons.lock,
                              ),

                          border:
                              const OutlineInputBorder(),

                          suffixIcon:

                              IconButton(

                            icon: Icon(

                              isPasswordVisible

                                  ? Icons.visibility

                                  : Icons.visibility_off,

                            ),

                            onPressed: () {

                              setState(() {

                                isPasswordVisible =
                                    !isPasswordVisible;

                              });

                            },

                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // CONFIRM PASSWORD
                      TextField(

                        controller:
                            confirmPasswordController,

                        obscureText:
                            !isConfirmPasswordVisible,

                        decoration:
                            InputDecoration(

                          labelText:
                              "Confirm Password",

                          prefixIcon:
                              const Icon(
                                Icons.lock,
                              ),

                          border:
                              const OutlineInputBorder(),

                          suffixIcon:

                              IconButton(

                            icon: Icon(

                              isConfirmPasswordVisible

                                  ? Icons.visibility

                                  : Icons.visibility_off,

                            ),

                            onPressed: () {

                              setState(() {

                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;

                              });

                            },

                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================
              // SELECTIONS
              // ==========================================

              Card(

                elevation: 3,

                child: Padding(

                  padding:
                      const EdgeInsets.all(16),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(

                        "Preferences",

                        style: TextStyle(

                          fontSize: 20,

                          fontWeight:
                              FontWeight.bold,

                        ),
                      ),

                      const SizedBox(height: 20),

                      // ----------------------------------
                      // GENDER
                      // ----------------------------------

                      const Text(

                        "Gender",

                        style: TextStyle(

                          fontSize: 16,

                          fontWeight:
                              FontWeight.bold,

                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(

                        children: [

                          // MALE
                          Expanded(

                            child: Row(

                              children: [

                                Radio<String>(

                                  value: "Male",

                                  groupValue:
                                      selectedGender,

                                  onChanged: (value) {

                                    setState(() {

                                      selectedGender =
                                          value;

                                      

                                    });

                                  },

                                ),

                                const Text(
                                  "Male",
                                ),

                              ],
                            ),
                          ),

                          // FEMALE
                          Expanded(

                            child: Row(

                              children: [

                                Radio<String>(

                                  value: "Female",

                                  groupValue:
                                      selectedGender,

                                  onChanged: (value) {

                                    setState(() {

                                      selectedGender =
                                          value;

                                    });

                                  },

                                ),

                                const Text(
                                  "Female",
                                ),

                              ],
                            ),
                          ),

                          // OTHER
                          Expanded(

                            child: Row(

                              children: [

                                Radio<String>(

                                  value: "Other",

                                  groupValue:
                                      selectedGender,

                                  onChanged: (value) {

                                    setState(() {

                                      selectedGender =
                                          value;

                                    });

                                  },

                                ),

                                const Text(
                                  "Other",
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 15),

                      // ----------------------------------
                      // DATE OF BIRTH
                      // ----------------------------------

                      const Text(

                        "Date of Birth",

                        style: TextStyle(

                          fontSize: 16,

                          fontWeight:
                              FontWeight.bold,

                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(

                        width: double.infinity,

                        padding:
                            const EdgeInsets.all(15),

                        decoration: BoxDecoration(

                          border:
                              Border.all(
                            color: Colors.grey,
                          ),

                          borderRadius:
                              BorderRadius.circular(5),

                        ),

                        child: Row(

                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [

                            Text(

                              selectedDate == null

                                  ? "Select your date of birth"

                                  : "${selectedDate!.day}/"
                                    "${selectedDate!.month}/"
                                    "${selectedDate!.year}",

                            ),

                            IconButton(

                              icon: const Icon(
                                Icons.calendar_month,
                              ),

                              onPressed:
                                  selectDate,

                            ),

                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      // ----------------------------------
                      // NOTIFICATIONS
                      // ----------------------------------

                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        children: [

                          const Expanded(

                            child: Column(

                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Text(

                                  "Notifications",

                                  style: TextStyle(

                                    fontSize: 16,

                                    fontWeight:
                                        FontWeight.bold,

                                  ),
                                ),

                                Text(

                                  "Receive application updates",

                                  style: TextStyle(

                                    color:
                                        Colors.grey,

                                  ),
                                ),

                              ],
                            ),
                          ),

                          Switch(

                            value:
                                receiveNotifications,

                            onChanged: (value) {

                              setState(() {

                                receiveNotifications =
                                    value;

                              print("Receive notifications: $receiveNotifications");
                              });

                            },

                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================
              // TERMS AND CONDITIONS
              // ==========================================

              Card(

                elevation: 3,

                child: Padding(

                  padding:
                      const EdgeInsets.all(10),

                  child: Row(

                    children: [

                      Checkbox(

                        value:
                            acceptTerms,

                        onChanged: (value) {

                          setState(() {

                            acceptTerms =
                                value ?? false;

                          });

                        },

                      ),

                      const Expanded(

                        child: Text(

                          "I agree to the Terms & "
                          "Conditions and Privacy Policy.",

                        ),
                      ),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ==========================================
              // SIGNUP BUTTON
              // ==========================================

              SizedBox(

                width: double.infinity,

                height: 52,

                child: ElevatedButton(

                  onPressed: signup,

                  child: const Text(

                    "CREATE ACCOUNT",

                    style: TextStyle(

                      fontSize: 16,

                      fontWeight:
                          FontWeight.bold,

                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}