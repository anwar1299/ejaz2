import 'package:app/services/auth_exceptionHandler.dart';
import 'package:app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // form builder key
  static final GlobalKey<FormBuilderState> _fbKey =
      GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          // background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/s.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
              key: _fbKey,
              child: Column(
                children: [
                  // text as logo
                  Expanded(child: SizedBox()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Ejaz',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '   Be high-spirited and do not be    satisfied with'
                        ' anything but the top',
                        style: TextStyle(
                            color: Colors.grey.shade200, fontSize: 16),
                      ),
                    ],
                  ),

                  /// space
                  Expanded(child: SizedBox()),
                  FormBuilderTextField(
                    name: 'email',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    name: 'password',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(6),
                    ]),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        //borderSide: BorderSide.none,
                      ),
                      labelText: 'password',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonTheme(
                      minWidth: 180,
                      height: 50,
                      child: RaisedButton(
                        child: const Text('Login',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        onPressed: () async {
                          _fbKey.currentState?.save();
                          if (_fbKey.currentState!.validate()) {
                            // save data to FirebaseServecies
                            final state = await FirebaseServices()
                                .login(_fbKey.currentState?.value);
                            print(state);
                            if (state == AuthResultStatus.successful) {
                              // go to route /
                              Navigator.pushReplacementNamed(context, '/');
                            }
                          } else {
                            print("validation failed");
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.amber,
                        elevation: 5,
                      )),
                  // if user not register yet
                  const Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  Text(
                    'Not registered yet?',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                    ),
                  ),

                  TextButton(
                    child:
                        const Text('Register', style: TextStyle(fontSize: 16)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                  Expanded(child: SizedBox())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
