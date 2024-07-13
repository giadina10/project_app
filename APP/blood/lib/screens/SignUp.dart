import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:blood/provider/FeaturesProvider.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  int? bs;
  bool? isPregnant;
  bool? isSporty;
  double activityLevel = 5; 
  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  void _loadPrefs() async {
    final featuresProvider = Provider.of<FeaturesProvider>(context, listen: false);
    await featuresProvider.loadPrefs(); // Carica le preferenze
    setState(() {
      fullnameController.text = featuresProvider.fullName;
      nameController.text = featuresProvider.name;
      emailController.text = featuresProvider.email;
      ageController.text = featuresProvider.age;
      weightController.text = featuresProvider.weight;
      bs = featuresProvider.bs;
      isPregnant = featuresProvider.isPregnant;
      isSporty = featuresProvider.isSporty;
      activityLevel = featuresProvider.activityLevel;
      isLoading = false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), 
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 186, 235, 232),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
           title: Padding(
            padding: const EdgeInsets.only(left: 55.0), // per far si che icona+scritta siano in posizione centrale 
            child: Row(
              children: [
                Image.asset(
                  'assets/images/splashIcon.png',
                  scale: 10,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Donify',
                  style: TextStyle(
                    fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator()) 
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
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
                          color: Color.fromARGB(255, 0, 0, 0),
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
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 186, 235, 232),
                                  width: 2.0),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 186, 235, 232),
                                  width: 2.0),
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
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 186, 235, 232),
                                  width: 2.0),
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
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 186, 235, 232),
                                  width: 2.0),
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
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 186, 235, 232),
                                  width: 2.0),
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
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 186, 235, 232),
                                  width: 2.0),
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
                            Text(
                                'Do you regularly engage in physical activity? '),
                            Text(
                              'Rate on a scale from 1 to 10 where 1 = never and 10 = athlete.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
                          activeColor: Color.fromARGB(255, 186, 235, 232),
                        ),
                      ),
                      if (bs == 1)
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
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                        "Your generosity in considering blood donation is appreciated. However, due to your current condition, we advise waiting until after the birth to donate.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "OK",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 247, 143, 139),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            activeColor: Color.fromARGB(255, 186, 235, 232),
                          ),
                        ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final sp =
                                    await SharedPreferences.getInstance();
                                sp.setString('fullName', fullnameController.text);
                                sp.setString('name', nameController.text);
                                sp.setString('email', emailController.text);
                                sp.setString('age', ageController.text);
                                sp.setString('weight', weightController.text);
                                sp.setInt('bs', bs ?? 0);
                                sp.setBool('isPregnant', isPregnant ?? false);
                                sp.setBool('isSporty', isSporty ?? false);
                                sp.setDouble('activityLevel', activityLevel);

                                // Chiama la funzione updatePreferences del FeaturesProvider
                                Provider.of<FeaturesProvider>(context,
                                        listen: false)
                                    .updatePreferences({
                                  'fullName': fullnameController.text,
                                  'name': nameController.text,
                                  'email': emailController.text,
                                  'age': ageController.text,
                                  'weight': weightController.text,
                                  'bs': bs ?? 0,
                                  'isPregnant': isPregnant ?? false,
                                  'isSporty': isSporty ?? false,
                                  'activityLevel': activityLevel,
                                });

                                Navigator.pop(context); // Torna alla schermata precedente
                              }
                            },
                            color: Color.fromARGB(255, 186, 235, 232),
                            // Cambia il colore del bottone
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 0, // Rimuove l'ombra
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.black),
                             
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
} 