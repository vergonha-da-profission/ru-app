import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _ProfileSectionItem(
                              icon: Icons.person_outline, name: 'Guilherme'),
                          _ProfileSectionItem(
                              icon: Icons.addchart_rounded, name: '1721101026'),
                          _ProfileSectionItem(
                              icon: Icons.email_outlined,
                              name: 'guilherme.silva97'),
                          _ProfileSectionItem(
                            icon: Icons.assignment_ind_outlined,
                            name: '123.123.123-12',
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
      width: double.infinity,
      child: Row(
        children: [
          Icon(
            icon,
            size: 35,
          ),
          SizedBox(width: 10),
          Text(
            name,
            style: GoogleFonts.roboto(fontSize: 22),
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
            child: Image.network(
              'http://placekitten.com/200/300',
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
