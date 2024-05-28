import 'package:blood/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  int? bs;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  void _loadPrefs() async {
    final sp = await SharedPreferences.getInstance();
    // Use a default value if the key doesn't exist
    String bioS = sp.getString('bs') ?? "";
    String age = sp.getString('age') ?? "";
    String name = sp.getString('name') ?? "";
    String weight = sp.getString('weight') ?? "";
    setState(() {
      bs = int.tryParse(bioS);
      ageController.text = age;
      nameController.text = name;
      weightController.text = weight;
    });
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
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25,  color: Colors.red,),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Info about you for a tailored experience",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        prefixIcon: const Icon(
                          Icons.person,
                        ),
                        hintText: 'Name',
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
                        // Aggiungi eventuali altre condizioni di validazione qui, ad esempio, per controllare che l'età sia compresa in un intervallo specifico
                        return null;
                      },
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        prefixIcon: const Icon(
                          Icons.person_outline,
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
                        return null;
                      },
                      controller: weightController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        prefixIcon: const Icon(
                          Icons.fitness_center,
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
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
                        bs = value ?? bs;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final sp = await SharedPreferences.getInstance();
                          await sp.setString('bs', bs.toString());
                          await sp.setString('age', ageController.text.toString());
                          await sp.setString(
                              'name', nameController.text.toString());
                          await sp.setString(
                              'weight', weightController.text.toString());
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 12)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent)),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
