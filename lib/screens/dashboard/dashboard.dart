import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ru/bloc/authentication/authentication_bloc.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DefaultTabController(
            // The number of tabs / content sections to display.
            length: 3,
            child: Container(), // Complete this code in the next step.
          ),
          Container(
            child: Column(
              children: [
                _ProfilePicture(),
                _UserName(),
                _QrCode(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserName extends StatelessWidget {
  const _UserName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user =
        BlocProvider.of<AuthenticationBloc>(context, listen: false).user;

    return Container(
      margin: const EdgeInsets.only(top: 15, left: 5),
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      alignment: Alignment.center,
      child: Text(
        _user.fullName,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          fontSize: 33,
        ),
      ),
    );
  }
}

class _QrCode extends StatelessWidget {
  const _QrCode({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user =
        BlocProvider.of<AuthenticationBloc>(context, listen: false).user;

    return Container(
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.width * .7,
      child: CachedNetworkImage(
        imageUrl: _user.qrCodeUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user =
        BlocProvider.of<AuthenticationBloc>(context, listen: false).user;

    return Container(
      margin: EdgeInsets.only(top: 25),
      width: MediaQuery.of(context).size.width * .35,
      height: MediaQuery.of(context).size.width * .35,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: _user.profilePicture,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
