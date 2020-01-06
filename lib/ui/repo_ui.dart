import 'package:flutter/material.dart';
import 'package:mu_github_app/models/commit.dart';
import 'package:mu_github_app/models/commit_list.dart';
import 'package:mu_github_app/service/repo_service.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class RepoUI extends StatefulWidget {
  final String title;
  final String username;

  const RepoUI({Key key, this.title, this.username}) : super(key: key);

  @override
  _RepoUIState createState() => _RepoUIState();
}

class _RepoUIState extends State<RepoUI> {
  @override
  void initState() {
    super.initState();
    fetchRepoCommits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: StateBuilder<CommitList>(
          models: [Injector.getAsReactive<CommitList>()],
          builder: (context, reactiveModel) {
            return reactiveModel.whenConnectionState(
              onIdle: () => CircularProgressIndicator(),
              onWaiting: () => Center(
                child: CircularProgressIndicator(),
              ),
              onData: (store) => dataUI(store.commitList),
              onError: (_) => errorUI(_, reactiveModel),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => fetchRepoCommits(),
        label: Text('Refresh'),
        icon: Icon(Icons.refresh),
      ),
    );
  }

  Widget dataUI(List<Commit> list) {
    return list.isEmpty
        ? Column(
            children: <Widget>[
              Center(
                child: Text('No Repo commit found!'),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${list.length - index}. ${list[index].message}'),
              );
            },
            itemCount: list.length,
          );
  }

  Widget errorUI(Failure f, ReactiveModel<CommitList> model) {
    return Column(
      children: <Widget>[
        Container(),
        SizedBox(
          height: 16,
        ),
        Center(
          child: Text(f?.message ?? 'Something went wrong'),
        ),
      ],
    );
  }

  void fetchRepoCommits() async {
    final reactiveModel = Injector.getAsReactive<CommitList>();
    reactiveModel.setState(
      (store) => store.fetchCommits(widget.username, widget.title),
    );
  }
}
