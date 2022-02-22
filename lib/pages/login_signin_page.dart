import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/network/responses/error_response.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/label_text_view.dart';
import 'package:movie_booking_app/widgets/text_field_label_view.dart';
import 'package:movie_booking_app/widgets/text_field_view.dart';
import 'package:movie_booking_app/widgets/welcome_text_view.dart';

class LogInSignInPage extends StatefulWidget {
  @override
  State<LogInSignInPage> createState() => _LogInSignInPageState();
}

class _LogInSignInPageState extends State<LogInSignInPage> {
  final List<String> tabList = ["Log In", "Sign In"];

  CinemaModel cinemaModel = CinemaModelImpl();

  String? name;
  String? email;
  String? googleToken;
  String? facebookToken;

  _registerWithEmail(String name, String email, String phoneNumber, String password, String googleAccessToken, String facebookAccessToken) {
    cinemaModel
        .registerWithEmail(name, email, phoneNumber, password, googleAccessToken, facebookAccessToken)
        .then((successMsg) {
      _showToast("SignIn Successful!");
      _navigateToHomePage(context);
    }).catchError((error) {
      handleError(context, error);
    });
  }

  _logInWithEmail(String email, String password) {
    cinemaModel.logInWithEmail(email, password).then((successMsg) {
      _showToast("LogIn Successful!");
      _navigateToHomePage(context);
    }).catchError((error) {
      handleError(context, error);
    });
  }

  _registerWithGoogle() {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        "email",
        "https://www.googleapis.com/auth/contacts.readonly",
      ],
    );
    googleSignIn.signIn().then((googleAccount) {
      googleAccount?.authentication.then((authentication) {
        setState(() {
          name = googleAccount.displayName;
          email = googleAccount.email;
          googleToken = googleAccount.id;
        });
      });
    });
  }

  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //
  // Future<void> _signInWithGoogle(BuildContext context) async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //  
  //   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //   if (googleSignInAccount != null) {
  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  //     final AuthCredential authCredential = GoogleAuthProvider.credential(
  //         idToken: googleSignInAuthentication.idToken,
  //         accessToken: googleSignInAuthentication.accessToken);
  //
  //     UserCredential result = await firebaseAuth.signInWithCredential(authCredential);
  //     User? user = result.user;
  //     name = user?.displayName;
  //     email = user?.email;
  //
  //     print("Google Access Token>>> ${googleSignInAuthentication.accessToken}");
  //     print(user?.email);
  //     print(user?.displayName);
  //
  //     //_navigateToHomePage(context);
  //   }
  // }

  _registerWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      setState(() {
        name = userData["name"].toString();
        email = userData["email"].toString();
        facebookToken = loginResult.accessToken?.userId;

        print("FacebookUserName>>> ${userData["name"].toString()}");
      });
    } else {
      print("LoginStatus>>> ${loginResult.status}");
      print("Message>>>> ${loginResult.message}");
    }
  }
  
  _logInWithGoogle() {
    cinemaModel.logInWithGoogle(googleToken ?? "")
        .then((user) {
         if (user != null) {
           _navigateToHomePage(context);
         }
    }).catchError((error) => debugPrint(error.toString()));
  }

  _logInWithFacebook() {
    cinemaModel.logInWithFacebook(facebookToken ?? "")
        .then((user) {
      if (user != null) {
        _navigateToHomePage(context);
      }
    }).catchError((error) => debugPrint(error.toString()));
  }

  _showToast(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  void handleError(BuildContext context, dynamic error) {
    if (error is DioError) {
    try {
    ErrorResponse errorResponse = ErrorResponse.fromJson(error.response!.data);
    showErrorAlert(context, errorResponse.message.toString());
    } on Error catch (e) {
      showErrorAlert(context, e.toString());
   }
    } else {
    showErrorAlert(context, error.toString());
    }
  }

  void showErrorAlert(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(left: MARGIN_20, right: MARGIN_20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: SIZED_BOX_HEIGHT_50,
            ),
            WelcomeTextView(Colors.black),
            SizedBox(
              height: SIZED_BOX_HEIGHT_10,
            ),
            LabelTextView(
              LOGIN_SIGNIN_LABEL_TEXT,
              LABEL_TEXT_COLOR,
            ),
            SizedBox(
              height: SIZED_BOX_HEIGHT_40,
            ),
            //TabBarSection(tabList),
            TabBarSectionView(
              tabList: tabList,
              onTapRegisterView: (String name, String email, String phoneNumber,
                  String password, String googleAccessToken, String facebookAccessToken) =>
                  _registerWithEmail(name, email, phoneNumber, password, googleAccessToken, facebookAccessToken),
              onTapLogInView: (String email, String password) =>
                  _logInWithEmail(email, password),
              onTapFacebookSignIn: () => _registerWithFacebook(),
              onTapFacebookLogIn: () => _logInWithFacebook(),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToHomePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}

class TabBarSectionView extends StatefulWidget {
  final List<String> tabList;
  final Function(String name, String email, String phoneNumber, String password, String googleAccessToken, String facebookAccessToken) onTapRegisterView;
  final Function(String email, String password) onTapLogInView;

  final Function onTapFacebookSignIn;
  final Function onTapFacebookLogIn;

  TabBarSectionView(
      {required this.tabList,
        required this.onTapRegisterView,
        required this.onTapLogInView,
      required this.onTapFacebookSignIn,
      required this.onTapFacebookLogIn});

  @override
  State<TabBarSectionView> createState() =>
      _TabBarSectionViewState();
}

class _TabBarSectionViewState extends State<TabBarSectionView>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.tabList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TabBar(
            labelColor: SPLASH_SCREEN_BACKGROUND_COLOR,
            indicatorColor: SPLASH_SCREEN_BACKGROUND_COLOR,
            unselectedLabelColor: TAB_BAR_UNSELECTED_LABEL_COLOR,
            controller: _tabController,
            tabs: widget.tabList
                .map(
                  (tab) => Tab(
                    child: Text(tab),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_10,
        ),
        Container(
          height: TAB_BAR_VIEW_CONTAINER_HEIGHT,
          child: TabBarView(
            controller: _tabController,
            children: [
              UserInputLogInView(onTapView: widget.onTapLogInView,),
              UserInputSignInView(onTapView: widget.onTapRegisterView,),
            ],
          ),
        ),
      ],
    );
  }

}

class UserInputLogInView extends StatefulWidget {
  final Function(String email, String password) onTapView;

  UserInputLogInView({required this.onTapView});

  @override
  State<UserInputLogInView> createState() => _UserInputLogInViewState();
}

class _UserInputLogInViewState extends State<UserInputLogInView> {

  final TextEditingController _emailTextController = new TextEditingController();
  final TextEditingController _passwordTextController = new TextEditingController();

  String? idToken;
  String? googleToken;

  CinemaModel cinemaModel = CinemaModelImpl();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldLabelView("Email"),
          TextFieldView(
            hintText: "LilyJohnson@gmail.com",
            textInputType: TextInputType.emailAddress,
            textStyle: TextStyle(
              color: TEXT_FIELD_HINT_COLOR,
              fontSize: TEXT_FIELD_HINT_TEXT_SIZE,
            ),
            textEditingController: _emailTextController,
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_40,
          ),
          TextFieldLabelView("Password"),
          TextFieldView(
            hintText: "................",
            textInputType: TextInputType.text,
            textStyle: TextStyle(
              color: TEXT_FIELD_HINT_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: PASSWORD_HINT_TEXT_SIZE,
            ),
            textEditingController: _passwordTextController,
            obsecureText: true,
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_10,
          ),
          Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextFieldLabelView("Forgot Password ?"),
            ),
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_30,
          ),
          GestureDetector(
            onTap: () async {
              final LoginResult loginResult = await FacebookAuth.instance.login();
              if (loginResult.status == LoginStatus.success) {
                final userData = await FacebookAuth.instance.getUserData(fields: 'email, name');
                print("FacebookUserName>>> ${userData["name"].toString()}");
                print("FacebookToken>>>> ${loginResult.accessToken.toString()}");
              } else {
                print("LoginStatus>>> ${loginResult.status}");
                print("Message>>>> ${loginResult.message}");
                print("FacebookToken>>>> ${loginResult.accessToken}");
              }
              cinemaModel.logInWithFacebook(loginResult.accessToken.toString()).then((value) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomePage()));
              });
            },
            child:  IconAndTextInRowView(
              Image.asset(
                'assets/images/facebook.png',
                height: FACEBOOK_IMAGE_HEIGHT,
                width: FACEBOOK_IMAGE_WIDTH,
              ),
              "Sign in with facebook",
            ),
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_20,
          ),
          GestureDetector(
            onTap: () {
              GoogleSignIn().signIn().then((value) {
                idToken = value?.id ?? "";
                print("GoogleId>> $idToken");
                value?.authentication.then((data) {
                  setState(() {
                    googleToken = data.idToken;
                    print("GoogleToken>>> $googleToken");
                    _emailTextController.text = value.email;
                  });
                  cinemaModel.logInWithGoogle(googleToken ?? "1212").then((value) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomePage()));
                  }).catchError((error) => debugPrint(error.toString()));
                }).catchError((error) => debugPrint((error.toString())));
              });
            },
            child: IconAndTextInRowView(
                Image.asset(
                  'assets/images/google.png',
                  height: GOOGLE_IMAGE_HEIGHT,
                  width: GOOGLE_IMAGE_WIDTH,
                ),
                "Sign in with google"),
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_20,
          ),
          GestureDetector(
            onTap: () =>
                widget.onTapView(_emailTextController.text, _passwordTextController.text),
            child: Container(
              height: LOGIN_SIGNIN_PAGE_CONTAINER_HEIGHT,
              decoration: BoxDecoration(
                color: SPLASH_SCREEN_BACKGROUND_COLOR,
                borderRadius: BorderRadius.all(
                  Radius.circular(BORDER_RADIUS),
                ),
              ),
              child: Center(
                child: Text(
                  CONFIRM_TEXT,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInputSignInView extends StatefulWidget {

  final Function(String name, String email, String phoneNumber, String password, String googleAccessToken, String facebookAccessToken) onTapView;

  UserInputSignInView({required this.onTapView});

  @override
  State<UserInputSignInView> createState() => _UserInputSignInViewState();
}

class _UserInputSignInViewState extends State<UserInputSignInView> {
  final TextEditingController _emailTextController = new TextEditingController();

  final TextEditingController _nameTextController = new TextEditingController();

  final TextEditingController _phoneNumberTextController = new TextEditingController();

  final TextEditingController _passwordTextController = new TextEditingController();

  String? idToken;
  String? googleToken;
  String? facebookToken;

  CinemaModel cinemaModel = CinemaModelImpl();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldLabelView("Email"),
              TextFieldView(
                hintText: "LilyJohnson@gmail.com",
                textInputType: TextInputType.emailAddress,
                textStyle: TextStyle(
                  color: TEXT_FIELD_HINT_COLOR,
                  fontSize: TEXT_FIELD_HINT_TEXT_SIZE,
                ),
                textEditingController: _emailTextController,
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_40,
              ),
              TextFieldLabelView("Password"),
              TextFieldView(
                hintText: "................",
                textInputType: TextInputType.text,
                textStyle: TextStyle(
                  color: TEXT_FIELD_HINT_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: PASSWORD_HINT_TEXT_SIZE,
                ),
                textEditingController: _passwordTextController,
                obsecureText: true,
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_40,
              ),
              TextFieldLabelView("Name"),
              TextFieldView(
                hintText: "LilyJohnson",
                textInputType: TextInputType.name,
                textStyle: TextStyle(
                  color: TEXT_FIELD_HINT_COLOR,
                  fontSize: TEXT_FIELD_HINT_TEXT_SIZE,
                ),
                textEditingController: _nameTextController,
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_40,
              ),
              TextFieldLabelView("Phone"),
              TextFieldView(
                hintText: "09-400031542",
                textInputType: TextInputType.phone,
                textStyle: TextStyle(
                  color: TEXT_FIELD_HINT_COLOR,
                  fontSize: TEXT_FIELD_HINT_TEXT_SIZE,
                ),
                textEditingController: _phoneNumberTextController,
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_10,
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextFieldLabelView("Forgot Password ?"),
                ),
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_30,
              ),
              GestureDetector(
                onTap: () async{
                  final LoginResult loginResult = await FacebookAuth.instance.login();
                  if (loginResult.status == LoginStatus.success) {
                    final userData = await FacebookAuth.instance.getUserData();
                    setState(() {
                      _nameTextController.text = userData["name"].toString();
                      _emailTextController.text = userData["email"] ?? "";
                      facebookToken = loginResult.accessToken.toString();

                      print("FacebookToken>>> $facebookToken");
                    });
                  } else {
                    print("LoginStatus>>> ${loginResult.status}");
                    print("Message>>>> ${loginResult.message}");
                  }
                },
                  child: IconAndTextInRowView(
                    Image.asset(
                      'assets/images/facebook.png',
                      height: FACEBOOK_IMAGE_HEIGHT,
                      width: FACEBOOK_IMAGE_WIDTH,
                    ),
                    "Sign in with facebook",
                  ),
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
              // GestureDetector(
              //   onTap: () => widget.onTapGoogleSignIn(),
              //   child: IconAndTextInRowView(
              //       Image.asset(
              //         'assets/images/google.png',
              //         height: GOOGLE_IMAGE_HEIGHT,
              //         width: GOOGLE_IMAGE_WIDTH,
              //       ),
              //       "Sign in with google"),
              // ),
              GestureDetector(
                onTap: () {
                  GoogleSignIn googleSignIn = GoogleSignIn(
                    scopes: [
                      "email",
                      "https://www.googleapis.com/auth/contacts.readonly",
                    ],
                  );
                  googleSignIn.signIn().then((googleAccount) {
                    googleAccount?.authentication.then((authentication) {
                      setState(() {
                        _nameTextController.text = googleAccount.displayName ?? "";
                        _emailTextController.text = googleAccount.email;
                        idToken = googleAccount.id;
                        googleAccount.authentication.then((data) {
                          googleToken = data.idToken;
                        }).catchError((error) => debugPrint(error.toString()));
                      });
                    }).catchError((error) => debugPrint(error.toString()));
                  });
                },
                child: IconAndTextInRowView(
                    Image.asset(
                      'assets/images/google.png',
                      height: GOOGLE_IMAGE_HEIGHT,
                      width: GOOGLE_IMAGE_WIDTH,
                    ),
                    "Sign in with google"),
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
              GestureDetector(
                onTap: () =>
                    widget.onTapView(_nameTextController.text, _emailTextController.text, _phoneNumberTextController.text, _passwordTextController.text, "1212", "78987"),
                child: Container(
                  height: LOGIN_SIGNIN_PAGE_CONTAINER_HEIGHT,
                  decoration: BoxDecoration(
                    color: SPLASH_SCREEN_BACKGROUND_COLOR,
                    borderRadius: BorderRadius.all(
                      Radius.circular(BORDER_RADIUS),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      CONFIRM_TEXT,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInMethodView extends StatelessWidget {
  final Function onTapView;
  final Function onTapGoogleSignIn;
  final Function onTapFacebookSignIn;

  SignInMethodView({required this.onTapView, required this.onTapGoogleSignIn, required this.onTapFacebookSignIn});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextFieldLabelView("Forgot Password ?"),
            ),
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_30,
          ),
          GestureDetector(
            onTap: onTapFacebookSignIn(),
            child: IconAndTextInRowView(
              Image.asset(
                'assets/images/facebook.png',
                height: FACEBOOK_IMAGE_HEIGHT,
                width: FACEBOOK_IMAGE_WIDTH,
              ),
              "Sign in with facebook",
            ),
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_20,
          ),
          GestureDetector(
            onTap: onTapGoogleSignIn(),
            child: IconAndTextInRowView(
                Image.asset(
                  'assets/images/google.png',
                  height: GOOGLE_IMAGE_HEIGHT,
                  width: GOOGLE_IMAGE_WIDTH,
                ),
                "Sign in with google"),
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_20,
          ),
          GestureDetector(
            onTap: onTapView(),
            child: Container(
              height: LOGIN_SIGNIN_PAGE_CONTAINER_HEIGHT,
              decoration: BoxDecoration(
                color: SPLASH_SCREEN_BACKGROUND_COLOR,
                borderRadius: BorderRadius.all(
                  Radius.circular(BORDER_RADIUS),
                ),
              ),
              child: Center(
                child: Text(
                  CONFIRM_TEXT,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignInMethodLabelView extends StatelessWidget {
  final String label;

  SignInMethodLabelView(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class IconAndTextInRowView extends StatelessWidget {
  final Image image;
  final String signInMethodLabel;

  IconAndTextInRowView(this.image, this.signInMethodLabel);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: LOGIN_SIGNIN_PAGE_CONTAINER_HEIGHT,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: PADDING_18),
            child: image,
          ),
          SignInMethodLabelView(signInMethodLabel),
        ],
      ),
    );
  }
}
