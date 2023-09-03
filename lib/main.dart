import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //package to use DateFormat

void main() {
  runApp(const FormValidationApp());
}

class FormValidationApp extends StatelessWidget {
  const FormValidationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FormValidationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormValidationPage extends StatefulWidget {
  const FormValidationPage({super.key});

  @override
  State<FormValidationPage> createState() => _FormValidationPageState();
}

class _FormValidationPageState extends State<FormValidationPage> {
  String? gender;
  final TextEditingController _datePicker = TextEditingController(); //controllers to display the submitted values
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _skillInterestController = TextEditingController();
  late String selectedValue = 'Student'; //student is default selected in the dropdown
  List<String> options = ['Student', 'Intern', 'Employed', 'Unemployed']; //array of items in drop down
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //key for from validation

  void _fieldChecker() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(                     //navigator to go to next page
        context,
        MaterialPageRoute(   //route is like to create a new page
          builder: (context) => SubmissionDetails(
            firstName: _firstNameController.text,   // values that will display with controllers
            middleName: _middleNameController.text,
            lastName: _lastNameController.text,
            dob: _datePicker.text,
            phone: _phoneController.text,
            email: _emailController.text,
            address: _addressController.text,
            gender: gender ?? 'Not specified',
            selectedValue: selectedValue,
            skillInterest: _skillInterestController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Validation Form',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,  //auto validates the field before submission
                  controller: _firstNameController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      labelText: 'FirstName',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Firstname';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _middleNameController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      labelText: 'MiddleName',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _lastNameController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      labelText: 'LastName',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (value) {
                    if (value!.isEmpty) {  //gives an error msg if the field is empty
                      return 'Please enter your LastName';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _datePicker,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_today_outlined),
                    labelText: 'DOB',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onTap: () async {
                    DateTime? pickdate = await showDatePicker( //to display a calender to select date
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));
                    if (pickdate != null) {
                      setState(() {
                        _datePicker.text =
                            DateFormat('dd-MM-yyyy').format(pickdate); //to set format
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your date of birth';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _phoneController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.call),
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Mobile number';
                    }
                    if (value.length != 10) {
                      return 'Please enter a 10-digit phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.mail),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    RegExp emailRegExp = RegExp(                                 //reg Exp to evaluate email of the type 'name@gmail.com' and 'clg mail id'
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegExp.hasMatch(value)) {
                      return 'please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _addressController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.location_on),
                      labelText: 'Address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 0, 0),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                              activeColor: Colors.black,
                              value: 'Male',
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              }),
                          const Text('Male')
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Radio(
                                activeColor: Colors.black,
                                value: 'Female',
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                }),
                            const Text('Female')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0.1, 0, 0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: DropdownButtonFormField<String>(                 //dropdown widget
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        value: selectedValue,
                        onChanged: (newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                        items: options.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Select an Option',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _skillInterestController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.interests),
                      labelText: 'Skill/Interest',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your skill/Interest';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: _fieldChecker,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber)),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class SubmissionDetails extends StatelessWidget {   //about the next page
  const SubmissionDetails(
      {super.key, required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.dob,
      required this.phone,
      required this.email,
      required this.address,
      required this.gender,
      required this.selectedValue,
      required this.skillInterest});
  final String firstName;
  final String middleName;
  final String lastName;
  final String dob;
  final String phone;
  final String email;
  final String address;
  final String gender;
  final String selectedValue;
  final String skillInterest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Validation Form',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name: $firstName'), //displays the values from the controllers
            Text('Middle Name: $middleName'),
            Text('Last Name: $lastName'),
            Text('DOB: $dob'),
            Text('Phone: $phone'),
            Text('Email: $email'),
            Text('Address: $address'),
            Text('Gender: $gender'),
            Text('Selected Value: $selectedValue'),
            Text('Skill/Interest: $skillInterest'),
          ],
        ),
      ),
    );
  }
}
