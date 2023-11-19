import 'package:flutter/material.dart';
import 'package:todos/config/themes/apptheme.dart';
import 'package:todos/widgets/bottom_titles.dart';

class XpansionTile extends StatelessWidget {
  final String text1;
  final String text2;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;
  final List<Widget> children;

  const XpansionTile(
      {super.key,
      required this.text1,
      required this.text2,
      this.onExpansionChanged,
      this.trailing,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.greyColor2, borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          iconColor: Colors.white,
          title: BottomTitles(
            text1: text1,
            text2: text2,
          ),
          // tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          onExpansionChanged: onExpansionChanged,
          controlAffinity: ListTileControlAffinity.trailing,
          trailing: trailing,
          children: children,
        ),
      ),
    );
  }
}
