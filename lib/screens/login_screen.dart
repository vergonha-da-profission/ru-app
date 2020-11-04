import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        // color: Color(#f5b461),
        color: Color(0xFF868686),
        // width: double.infinity,
        child: ListView(
          // mainAxisSize: MainAxisSize.max,
          // scrollDirection: Axis.vertical,
          children: [
            _MainImage(),
            SizedBox(height: 40),
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
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .06),
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
        margin: _Const.buttonOutterMargin,
        child: FlatButton(
          color: Color(_Const.buttonBackgroundColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_Const.buttonRadius),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Enviando informações')));
            }
          },
          child: Container(
            width: _Const.buttonWidth,
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
  static const buttonBackgroundColor = 0xFFfed9ca;
  static const buttonRadius = 60.0;
  static const buttonOutterPading = const EdgeInsets.symmetric(vertical: 16.0);
  static const buttonOutterMargin = const EdgeInsets.only(bottom: 20);
  static const double buttonWidth = 70;
  static const double buttonHeight = 50;
  static const String buttonText = "Entrar";
  static final buttonStyle = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xAA43414e),
  );

  static const double imageHeight = 200;
  static const double imageWidth = 200;
  static const String imageName =
      'https://avatars0.githubusercontent.com/u/71855737?s=400&u=76011f1a14e05ffb46bcf1e701c374300c4d1b54&v=4';
  static const formMargin = const EdgeInsets.symmetric(horizontal: 40);

  static const String passwordHint = 'Senha';
  static const String loginHint = 'Login';

  static final inputHintStyle = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFFfed9ca),
  );
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _showText = false;

    return StatefulBuilder(builder: (BuildContext context, setState) {
      return TextFormField(
        obscureText: !_showText,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.lock_outline_rounded,
            color: Color(_Const.buttonBackgroundColor),
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
    });
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        icon: Icon(
          Icons.person_outline_outlined,
          color: Color(0xFFfed9ca),
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
    );
  }
}
