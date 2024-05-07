import 'package:blood/screens/HomePage.dart';
import 'package:flutter/material.dart';

class MultiFormPage extends StatefulWidget {
  const MultiFormPage({super.key});
  
  @override
  State <MultiFormPage> createState() => _MultiFormPage();
}

void _redirectToHomePage(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
}

class _MultiFormPage extends State <MultiFormPage> {
  int currentStep = 0;
  bool get isFirstStep => currentStep == 0;
  bool get isLaststep => currentStep == steps().length - 1;
  

  final name = TextEditingController();
  final age = TextEditingController();
  final company = TextEditingController();
  final role = TextEditingController();

  bool isComplete = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Flutter Stepper Widget')),
    body: Stepper(
    steps: steps(),
      currentStep: currentStep,
      onStepContinue: () {
        if (isLaststep){
          setState(() => isComplete = true);
          _redirectToHomePage(context); //rimanda alla homepage una volta
          //terminato di compilare il form
        } else {
          setState(() => currentStep+=1);
            
        }
        },
       onStepCancel: 
      isFirstStep ? null : () => setState(() => currentStep-=1),
      onStepTapped: (step) =>setState(() => currentStep = step),
      controlsBuilder: (context, details) => Padding(
        padding: const EdgeInsets.only(top : 32),
        child: Row(children: [
          Expanded(
            child: ElevatedButton(
              onPressed: details.onStepContinue,
              child:  Text(isLaststep ? 'Confirm': 'Next'),
            ),
            ),
            if (!isFirstStep) ...[
            const SizedBox(width:16),
            Expanded(
              child: ElevatedButton(
                onPressed: isFirstStep ? null : details.onStepCancel,
                child: const Text('Back'),
                ),
            )
        ],
        ],
        ) ,
      ),    
      
    ),
  );
  List<Step> steps()=>[
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >=0,
      title: Text('Personal'),
      content: Column(
        children: [
          TextFormField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Full name'),
          ),
          TextFormField(
            controller: age,
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
          )
        ],
      )
    ),
    Step(
       isActive: currentStep >=1,
      title: Text('Work'),
      content: Column(children: [
          TextFormField(
            controller: company,
            decoration: const InputDecoration(labelText: 'Company'),
          ),
      ],
          ),
    ),
    Step(
      isActive: currentStep >=2,
      title: Text('Complete'),
      content: Column(),
    ),
  ];
}
  




