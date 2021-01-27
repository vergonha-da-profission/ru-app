import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ru/bloc/authentication/authentication_bloc.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user =
        BlocProvider.of<AuthenticationBloc>(context, listen: false).user;

    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) => Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              _ProfileImageSection(
                maxHeight: constraints.maxHeight,
              ),
              SizedBox(height: 15),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15),
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          Expanded(
                            child: ListView(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 200,
                                  child: _ProfileSectionItem(
                                    icon: Icons.person_outline,
                                    name: _user.fullName,
                                  ),
                                ),
                                _ProfileSectionItem(
                                    icon: Icons.addchart_rounded,
                                    name: _user.email),
                                _ProfileSectionItem(
                                    icon: Icons.email_outlined,
                                    name: _user.iduffs),
                                _ProfileSectionItem(
                                  icon: Icons.assignment_ind_outlined,
                                  name: _user.formatedCpf,
                                ),
                                TextButton(
                                    onPressed: () =>
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(new LoggedOut()),
                                    child: Text('Sair'))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileSectionItem extends StatelessWidget {
  const _ProfileSectionItem({
    Key key,
    @required this.icon,
    @required this.name,
  }) : super(key: key);

  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 35,
              ),
              SizedBox(width: 10),
              Text(
                name,
                overflow: TextOverflow.fade,
                style: GoogleFonts.roboto(
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileImageSection extends StatelessWidget {
  const _ProfileImageSection({Key key, @required this.maxHeight})
      : super(key: key);

  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final _user =
        BlocProvider.of<AuthenticationBloc>(context, listen: false).user;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: this.maxHeight * .3,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(150),
              bottomRight: Radius.circular(150),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: this.maxHeight * .05,
          ),
          height: 200,
          width: 200,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: _user.profilePicture,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        )
      ],
    );
  }
}
