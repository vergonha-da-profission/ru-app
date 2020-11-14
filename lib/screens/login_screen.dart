import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Color(0xFFFFFF),
        child: ListView(
          children: [
            _MainImage(),
            Container(
              padding: _Const.formMargin,
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                'Bem vindo,',
                style: GoogleFonts.roboto(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF3c3c3c)),
              ),
            ),
            Container(
              padding: _Const.formMargin,
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                'Entre para continuar!',
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF939393),
                ),
              ),
            ),
            SizedBox(height: 60),
            MyCustomForm(),
          ],
        ),
      ),
    );
  }
}

class _MainImage extends StatelessWidget {
  const _MainImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .05),
        child: Container(
          height: _Const.imageWidth,
          width: _Const.imageHeight,
          child: Container(
            child: _Const.imageName.startsWith('http')
                ? Image.network(_Const.imageName)
                : Image.asset(_Const.imageName),
          ),
        ),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _Const.formMargin,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _UsernameInput(),
            SizedBox(height: 20),
            _PasswordInput(),
            _LoginFormButton(formKey: _formKey),
          ],
        ),
      ),
    );
  }
}

class _LoginFormButton extends StatelessWidget {
  const _LoginFormButton({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: _Const.buttonOutterPading,
        margin: EdgeInsets.only(top: 30),
        child: FlatButton(
          color: Color(_Const.buttonBackgroundColor),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Enviando informações')));
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
            height: _Const.buttonHeight,
            child: Center(
              child: Text(_Const.buttonText, style: _Const.buttonStyle),
            ),
          ),
        ),
      ),
    );
  }
}

abstract class _Const {
  static const buttonBackgroundColor = 0xFF939393;
  static const buttonOutterPading = const EdgeInsets.symmetric(vertical: 16.0);
  static const double buttonHeight = 60;
  static const String buttonText = "Entrar";
  static final buttonStyle = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xAA43414e),
  );

  static const double imageHeight = 150;
  static const double imageWidth = 100;
  static const String imageName =
      'https://avatars0.githubusercontent.com/u/71855737?s=400&u=76011f1a14e05ffb46bcf1e701c374300c4d1b54&v=4';
  static const formMargin = const EdgeInsets.symmetric(horizontal: 40);

  static const String passwordHint = 'Escreva sua senha';
  static const String loginHint = 'Login';

  static final inputHintStyle = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF939393),
  );
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _showText = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Senha',
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        StatefulBuilder(builder: (BuildContext context, setState) {
          return TextFormField(
            obscureText: !_showText,
            decoration: InputDecoration(
              enabledBorder: new UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF939393),
                  width: 1,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.orange,
                  width: 1,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _showText = !_showText),
                icon: Icon(
                  _showText
                      ? Icons.visibility_off_outlined
                      : Icons.remove_red_eye_outlined,
                  color: Color(_Const.buttonBackgroundColor),
                ),
              ),
              hintText: _Const.passwordHint,
              hintStyle: _Const.inputHintStyle,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Digite uma senha válida.';
              }
              return null;
            },
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
          );
        }),
      ],
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Usuário',
            style:
                GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500)),
        TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF939393),
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
                width: 1,
              ),
            ),
            hintText: _Const.loginHint,
            hintStyle: _Const.inputHintStyle,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Por favor, digite um idUFFS ou um CPF válido.';
            }
            return null;
          },
          textInputAction: TextInputAction.next,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
      ],
    );
  }
}
