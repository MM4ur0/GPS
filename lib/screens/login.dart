import 'package:flutter/material.dart';
import 'package:flutter_text_box/flutter_text_box.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "", pass = "";
  bool term = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/fondo1.jpg"), fit: BoxFit.cover),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        _login(),
        _botonesAccion(context),
      ]),
    ));
  }
}

final key = GlobalKey<FormState>();

Widget _login() {
  return Center(
    child: Form(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextBoxLabel(
            label: "Usuario",
            hint: "Ingrese su nombre de usuario",
            errorText: "El campo es requerido !",
            onSaved: (String value) {},
          ),
          const SizedBox(height: 16),
          TextBoxLabel(
            label: "Contraseña",
            hint: "Ingrese su contraseña",
            errorText: "El campo es requerido !",
            obscure: true,
            onSaved: (String value) {},
          ),
          //const SizedBox(height: 16),
          CheckboxListTileFormField(
            title: const Text('Recordar Contraseña'),
            autovalidateMode: AutovalidateMode.always,
            contentPadding: const EdgeInsets.all(1),
          ),
        ],
      ),
    ),
  );
}

Widget _botonesAccion(BuildContext context) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ElevatedButton(
            onPressed: () {
              final state = key.currentState;
              Navigator.pushNamed(context, '/home');
              if (state!.validate()) {}
            },
            child: const Text("Ingresar")),
        ElevatedButton(onPressed: () {}, child: const Text("Salir")),
      ],
    ),
  );
}
