import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/label_text_view.dart';
import 'package:movie_booking_app/widgets/text_field_label_view.dart';
import 'package:movie_booking_app/widgets/text_field_view.dart';
import 'package:movie_booking_app/widgets/welcome_text_view.dart';

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final List<String> tabList = ["Log In", "Sign In"];

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
            ),
            SignInMethodView(onTapView: () {},),
          ],
        ),
      ),
    );
  }

}

class TabBarSectionView extends StatefulWidget {
  final List<String> tabList;

  TabBarSectionView(
      {required this.tabList,});

  @override
  State<TabBarSectionView> createState() => _TabBarSectionViewState();
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
              UserInputLogInView(),
              UserInputSignInView(),
            ],
          ),
        ),
      ],
    );
  }
}

class UserInputLogInView extends StatefulWidget {

  @override
  State<UserInputLogInView> createState() => _UserInputLogInViewState();
}

class _UserInputLogInViewState extends State<UserInputLogInView> {
  final TextEditingController _emailTextController =
  new TextEditingController();
  final TextEditingController _passwordTextController =
  new TextEditingController();

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
                height: SIZED_BOX_HEIGHT_10,
              ),
              // SignInMethodView(
              //   onTapView: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInputSignInView extends StatefulWidget {

  @override
  State<UserInputSignInView> createState() => _UserInputSignInViewState();
}

class _UserInputSignInViewState extends State<UserInputSignInView> {
  final TextEditingController _emailTextController =
  new TextEditingController();

  final TextEditingController _nameTextController = new TextEditingController();

  final TextEditingController _phoneNumberTextController =
  new TextEditingController();

  final TextEditingController _passwordTextController =
  new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            //UserInputSignInView(isVisible: widget.isVisible,),
            SizedBox(
              height: SIZED_BOX_HEIGHT_10,
            ),
            // SignInMethodView(
            //   onTapView: () {},
            // ),
          ]),
    );
  }
}

class SignInMethodView extends StatelessWidget {
  final Function onTapView;

  SignInMethodView({required this.onTapView});

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
            onTap: () {},
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
            onTap: () {
              onTapView();
            },
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
