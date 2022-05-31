import 'package:flutter/material.dart';
import '../resources/dimens.dart';

class PageTabSectionView extends StatelessWidget {
  final List<String> tabList;

  const PageTabSectionView({
    Key? key,
    required this.tabList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Color.fromRGBO(30, 31, 48, 1.0),
      unselectedLabelColor: Color.fromRGBO(30, 31, 48, 1.0),
      indicatorWeight: 2.0,
      labelStyle: TextStyle(
        fontSize: FONT_SIZE_18,
        fontWeight: FontWeight.bold,
      ),
      labelColor: Color.fromRGBO(30, 31, 48, 1.0),
      labelPadding: const EdgeInsets.only(
        bottom: MARGIN_CARD_MEDIUM_2,
      ),
      tabs: tabList.map((e) => Text(e)).toList(),
    );
  }
}
