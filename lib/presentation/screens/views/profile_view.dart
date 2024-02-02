import 'package:flutter/material.dart';
import 'package:reper/config/theme/app_colors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return Scaffold(
      body: Column( 
        children: <Widget>[
          SizedBox(
            height: 230,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      height: 165,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color.fromRGBO(108, 93, 211, 0.26),
                              Color.fromRGBO(19, 16, 31, 0.8)
                            ],
                            begin: FractionalOffset.bottomLeft,
                            end: FractionalOffset.topRight,
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: colors.scaffoldBackgroundColor,
                      radius: 70,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/img/userProfile.jpg'),
                      radius: 65,
                    ),
                  ],
                ),
                Positioned(
                  top: 30,
                  right: 20,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    width: 86,
                    height: 29,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        alignment: Alignment.centerRight,
                        scale: 30,
                        image: AssetImage('assets/img/notas-musicales.png'),
                      ),
                      color: const Color.fromRGBO(241,144,0,1),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(
                      'Premium',
                      style: TextStyle(
                        color: colors.colorScheme.onSurface, 
                        fontWeight: FontWeight.bold,
                        fontSize: 10
                      ),
                    ),  
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 20,),
        const   Padding(
          padding:EdgeInsets.symmetric(
            horizontal: 30
          ),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Joix',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 15,),
                          Text(
                            'Miembro desde',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            '1 de febrero de 2024',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10
                            ),
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]
          ),
        ),
        SizedBox(height: 10,),
        const   Padding(
          padding:EdgeInsets.symmetric(
            horizontal: 30
          ),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Theme Mode',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                            ),
                          ),
                          SizedBox(height: 15,),
                          Text(
                            'Notifications',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: 15,),
                          Icon(
                            Icons.dark_mode
                          ),
                          SizedBox(height: 15,),
                          Icon(
                            Icons.dark_mode
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]
          ),
        )
        ],
      ),
    );
  }
}
