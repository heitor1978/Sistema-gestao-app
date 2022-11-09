import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sistemagestao_app/Services/AuthService/auth_service.dart';
import 'package:sistemagestao_app/Theme/theme.dart';
import 'package:sistemagestao_app/Widgets/export_all_widget.dart';
import 'package:sistemagestao_app/Services/Validators/user_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService auth = AuthService();
  bool loading = false;

  String? email = "", senha = "";

  _login(BuildContext context) async {
    setState(() => loading = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await auth.login(email!, senha!, context);
      } on AuthException catch (e) {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } else {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: primaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
        preferredSize: const Size.fromHeight(0),
      ),
      body: Stack(children: [
        Form(
          key: _formKey,
          child: Center(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        // FUNÇÃO DE COLOCAR BORDA NA LOGO DA FOTO
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                          width: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(7),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 25.0,
                                spreadRadius: 0.1,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/chiquinho-logo.png',
                            height: 250,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height:
                      20, // precisa resolver está questão ////////////////////////////////////////////////
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorCard,
                        borderRadius: BorderRadius.circular(15)),
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: CustomTextField(
                            labelText: "Email",
                            placeholder: "colaborador@email.com",
                            inputType: TextInputType.emailAddress,
                            onSaved: (value) => email = value,
                            validator: (value) =>
                                UserValidator.validarEmail(value!),
                          ),
                        ),
                        CustomTextField(
                          labelText: "Senha",
                          placeholder: "********",
                          obscureText: true,
                          onSaved: (value) => senha = value,
                          validator: (value) =>
                              UserValidator.validarSenha(value!),
                        ),
                      ],
                    ),
                  ),
                ),
                (loading)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : CustomTextButton(
                        buttonText: "Entrar",
                        onPressed: () => _login(context),
                      ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
