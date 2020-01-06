import 'package:flutter/material.dart';
import 'package:mu_github_app/models/commit_list.dart';
import 'package:mu_github_app/models/repo.dart';
import 'package:mu_github_app/ui/home.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'models/repo_list.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Github Profile',
      home: Injector(
        inject: [
          Inject<RepoList>(() => RepoList()),
          Inject<CommitList>(() => CommitList()),
        ],
        builder: (context) => Home(),
      ),
    );
  }
}

