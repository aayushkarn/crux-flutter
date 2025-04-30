import 'package:avatar_plus/avatar_plus.dart';
import 'package:crux/api/api_handler.dart';
import 'package:crux/api/profile_model.dart';
import 'package:crux/services/auth_provider.dart';
import 'package:crux/widgets/utils/message_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserProfile> profile;
  final double coverHeight = 150;
  final double profileSize = 150;

  // Fetch the profile on init
  void _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    // Navigator.of(
    //   context,
    // ).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  void initState() {
    super.initState();
    profile = getProfile(context); // Assuming `getProfile` fetches user data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("crux"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              FutureBuilder<UserProfile>(
                future: profile,
                builder: (context, snapshot) {
                  // Show loading spinner while waiting for data
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: MessageTemplate(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }

                  // Handle errors if the future fails
                  if (snapshot.hasError) {
                    return MessageTemplate(
                      child: Center(child: Text('Error: ${snapshot.error}')),
                    );
                  }

                  // If we have data, display the user's profile
                  if (snapshot.hasData) {
                    final userProfile = snapshot.data!;

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          buildTop(userProfile),

                          Container(
                            margin: EdgeInsets.only(top: 10),

                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Column(
                                children: [
                                  userName(userProfile.name),
                                  Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),

                                  // Text("${userProfile.email}"),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16.0,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                            158,
                                            158,
                                            158,
                                            0.3,
                                          ),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Email",
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "${userProfile.email}",
                                              style: TextStyle(
                                                fontFamily: 'public_sans',
                                                fontSize: 26,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              "Verification Status",
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 20,
                                              ),
                                            ),
                                            (userProfile.userVerified) == 1
                                                ? Icon(
                                                  Icons.verified,
                                                  color: Colors.blue,
                                                  size: 30,
                                                )
                                                : Icon(
                                                  Icons.no_accounts,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  logoutButton(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // If there's no data available, show a default message
                  return MessageTemplate(
                    child: Center(child: Text('No Profile Data Available')),
                  );
                },
              ),
              // IconButton(
              //   onPressed: _logout,
              //   icon: const Icon(Icons.logout, color: Colors.white),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTop(userProfile) {
    final double topProfile = coverHeight - profileSize / 2;
    final double bottomHeight = profileSize / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottomHeight),
          child: backCover(),
        ),
        // backCover(),
        Positioned(
          top: topProfile,
          child: Column(
            children: [
              buildProfilePic(userProfile.avatarid),
              // userName(userProfile.name),
            ],
          ),
        ),
      ],
    );
  }

  Widget backCover() => Container(height: coverHeight, color: Colors.black);

  Widget buildProfilePic(avatarid) => Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 6),
    ),
    child: AvatarPlus(
      "${avatarid}",
      height: profileSize,
      width: profileSize, // Display name or fallback text
    ),
  );

  Widget userName(name) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 7),
    child: Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: 'Kanit',
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        SizedBox(width: 7),
      ],
    ),
  );

  Widget logoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _logout,
        child: Text(
          "Logout",
          style: TextStyle(
            fontFamily: 'Lato',

            fontSize: 17,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}


// Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color.fromRGBO(
//                                     169,
//                                     169,
//                                     169,
//                                     0.5,
//                                   ), // Grey with 50% opacity
//                                   spreadRadius: 5, // Spread the shadow
//                                   blurRadius: 10, // Blurriness of the shadow
//                                   offset: Offset(0, 4), // Shadow position
//                                 ),
//                               ],
//                               shape: BoxShape.circle,
//                               border: Border.all(color: Colors.white, width: 5),
//                             ),
//                             child: AvatarPlus(
//                               "${userProfile.email == '' ? userProfile.name : userProfile.email}",
//                               height: 150,
//                               width: 150, // Display name or fallback text
//                             ),
//                           ),
//                         ),
//                         Text(
//                           userProfile.name ?? 'No Name Provided',
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                         ),
//                         Text(
//                           userProfile.email ?? 'No Email Provided',
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                       ],
//                     );