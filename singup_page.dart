import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../services/auth_exceptionHandler.dart';
import '../../services/firebase_services.dart';

class SingupPage extends StatelessWidget {
  const SingupPage({Key? key}) : super(key: key);

  // form builder state key
  static final GlobalKey<FormBuilderState> _fbKey =
      GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(title: Text("Singup page")),
      body: SingleChildScrollView(
        child: Stack(children: [
          // SVG background
          Positioned(
            left: 0,
            top: 0,
            child: SvgPicture.asset('assets/background.svg'),
          ),
          FormBuilder(
            key: _fbKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  // logo
                  Image.asset(
                    "assets/image/m.jpeg",
                    height: 180,
                  ),
                  // space
                  SizedBox(height: 20),
                  // id
                  FormBuilderTextField(
                    name: "id",
                    decoration: InputDecoration(labelText: "ID"),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric()
                      ],
                    ),
                  ),
                  // space
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    name: "name",
                    decoration: InputDecoration(labelText: "Name"),
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()],
                    ),
                  ),
                  // space
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    name: "email",
                    decoration: InputDecoration(labelText: "Email"),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                        // create regex for @**.uqu.edu.sa
                      ],
                    ),
                  ),
                  // space
                  SizedBox(height: 20),
                  // phone number
                  FormBuilderTextField(
                    name: "phoneNumber",
                    decoration: InputDecoration(labelText: "Phone number"),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric()
                      ],
                    ),
                  ),
                  // space
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    name: "password",
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6)
                        // must have text and number
                      ],
                    ),
                  ),
                  // space
                  SizedBox(height: 20),
                  FormBuilderTextField(
                    name: "password_confirmation",
                    decoration:
                        InputDecoration(labelText: "Password confirmation"),
                    obscureText: true,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()],
                    ),
                  ),
                  // space
                  SizedBox(height: 20),
                  // date of birth
                  FormBuilderDateTimePicker(
                    name: "dob",
                    decoration: InputDecoration(labelText: "Date of birth"),
                    initialDate: DateTime.now(),
                    inputType: InputType.date,
                    // format: DateFormat("yyyy-MM-dd"),
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()],
                    ),
                  ),
                  // space
                  SizedBox(height: 20),
                  // level
                  // FormBuilderDropdown(
                  //   name: "role",
                  //   decoration: InputDecoration(labelText: "Role"),
                  //   // initialValue: "1",
                  //   hint: Text("Select Role"),
                  //   validator: FormBuilderValidators.compose(
                  //     [FormBuilderValidators.required()],
                  //   ),
                  //   items: [
                  //     "supervisor",
                  //   ].map((String value) {
                  //     return DropdownMenuItem(
                  //       value: value,
                  //       child: Text("Role $value"),
                  //     );
                  //   }).toList(),
                  // ),
                  // space
                  SizedBox(height: 20),
                  // level Phd, Master, Bachelor
                  FormBuilderDropdown(
                    name: "level",
                    decoration: InputDecoration(labelText: "Level"),
                    // initialValue: "1",
                    hint: Text("Select level"),
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()],
                    ),
                    items: ["PhD", "Master", "Bachelor"].map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text("Level $value"),
                      );
                    }).toList(),
                  ),
                  // space
                  SizedBox(height: 20),
                  RaisedButton(
                    color: Colors.amber,
                    padding: EdgeInsets.all(15),
                    onPressed: () async {
                      _fbKey.currentState?.save();
                      if (_fbKey.currentState!.validate()) {
                        // show progress dialog
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        // save data to FirebaseServecies
                        final state = await FirebaseServices()
                            .register(_fbKey.currentState?.value);

                        if (state == AuthResultStatus.successful) {
                          // go to route /
                          Navigator.pushReplacementNamed(context, '/');
                        }
                      } else {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.error(
                            message:
                                "Something went wrong. Please check your credentials and try again",
                          ),
                        );
                      }
                    },
                    child: Text("Register"),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
