import 'package:blood/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoOnboarding extends StatefulWidget {
  const PersonalInfoOnboarding({Key? key}) : super(key: key);

  @override
  State<PersonalInfoOnboarding> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfoOnboarding> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  int? bs;
  bool? isPregnant;
  bool? isSporty;
  double activityLevel = 5; // Default value on the slider

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          elevation: 0,
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splashIcon.png',
                scale: 8,
              ),
              const SizedBox(width: 10),
              const Text(
                'Donify',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 4),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Personal Info',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Tell us something more about you",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Full name is required';
                      }
                      return null;
                    },
                    controller: fullnameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                      hintText: 'Full Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'The username is required';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                      hintText: 'Pick a username',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'The email is required';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      hintText: 'mariorossi@gmail.com',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Age is required';
                      }
                      final int? age = int.tryParse(value);
                      if (age == null || age < 18 || age > 65) {
                        return 'Age must be between 18 and 65';
                      }
                      return null;
                    },
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      prefixIcon: const Icon(
                        Icons.accessibility,
                      ),
                      hintText: 'Age',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Weight is required';
                      }
                      final int? weight = int.tryParse(value);
                      if (weight == null || weight < 50) {
                        return 'Weight must be at least 50 kg to donate blood';
                      }
                      return null;
                    },
                    controller: weightController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      prefixIcon: const Icon(
                        Icons.scale,
                      ),
                      hintText: 'Weight',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: DropdownButtonFormField(
                    value: bs,
                    validator: (value) {
                      if (value == null) {
                        return 'Biological Sex is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2.0),
                      ),
                    ),
                    hint: Row(children: [
                      Icon(MdiIcons.genderMaleFemale),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Biological Sex")
                    ]),
                    items: [
                      DropdownMenuItem(
                        child: Text("Male"),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text("Female"),
                        value: 1,
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        bs = value ?? bs;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: Column(
                    children: [
                      Text('Do you regularly engage in physical activity? '),
                      Text(
                          'Rate on a scale from 1 to 10 where 1 = never and 10 = athlete.',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: Slider(
                    value: activityLevel,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: activityLevel.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        activityLevel = value;
                      });
                    },
                    activeColor: Colors.red,
                  ),
                ),
                if (bs == 1) // Show only if "Female" is selected
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 8.0),
                    child: CheckboxListTile(
                      title: Text("Think you might be pregnant?"),
                      value: isPregnant ?? false,
                      onChanged: (bool? value) {
                        setState(() {
                          isPregnant = value;
                        });
                        if (value == true) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Attention",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                    "Your generosity in considering blood donation is appreciated. However, due to your current condition, we advise waiting until after the birth to donate.",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      activeColor: Colors.red,
                    ),
                  ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final sp = await SharedPreferences.getInstance();
                          sp.setString('fullName', fullnameController.text);
                          sp.setString('name', nameController.text);
                          sp.setString('email', emailController.text);
                          sp.setString('age', ageController.text);
                          sp.setString('weight', weightController.text);
                          sp.setInt('bs', bs ?? 0);
                          sp.setBool('isPregnant', isPregnant ?? false);
                          sp.setBool('isSporty', isSporty ?? false);

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false,
                          );
                        } //_toHomePage

                        ;
                      },

                      color: const Color.fromARGB(255, 241, 96, 85),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 0, // Rimuove l'ombra
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ))));
  }
}
