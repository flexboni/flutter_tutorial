import 'package:flutter/material.dart';
import 'package:flutter_tutorial/src/containers/filter_link.dart';
import 'package:flutter_tutorial/src/model/models.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FilterLink(filter: VisibilityFilter.SHOW_ALL, text: 'ALL'),
        FilterLink(filter: VisibilityFilter.SHOW_ACTIVE, text: 'ACTIVE'),
        FilterLink(filter: VisibilityFilter.SHOW_COMPLETED, text: 'COMPLETED'),
      ],
    ));
  }
}
