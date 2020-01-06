import 'package:flutter/material.dart';

class RepoListUI extends StatelessWidget {
  final VoidCallback callback;
  final String title;

  const RepoListUI({Key key, this.callback, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(16),
          ),
          border: Border.all(color: Colors.grey)
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: callback,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 6),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title,
            )
          ),
        ),
      ),
    );
  }
}

