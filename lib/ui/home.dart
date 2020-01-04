import 'package:flutter/material.dart';
import 'package:mu_github_app/models/repo.dart';
import 'package:mu_github_app/models/repo_list.dart';
import 'package:mu_github_app/service/repo_service.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller;
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: StateBuilder<RepoList>(
          models: [Injector.getAsReactive<RepoList>()],
          builder: (context, reactiveModel) {
            return reactiveModel.whenConnectionState(
              onIdle: () => initialUI(reactiveModel),
              onWaiting: () => Center(
                child: CircularProgressIndicator(),
              ),
              onData: (store) => dataUI(store.repoList),
              onError: (_) => errorUI(_, reactiveModel),
            );
          },
        ),
      ),
    );
  }

  Widget initialUI(ReactiveModel<RepoList> model) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Username'),
                validator: (s) =>
                    s.isEmpty ? 'Please enter a valid username' : null,
                onSaved: (s) {},
              ),
            ),
            SizedBox(
              width: 16,
            ),
            IconButton(
              iconSize: 36,
              icon: Icon(Icons.search),
              onPressed: () {
                var state = _formKey.currentState;
                if (state.validate()) {
                  state.save();
                  model.setState((model)=>model.fetchRepos(_controller.text));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget dataUI(List<Repo> list) {
    return list.isEmpty
        ? Column(
          children: <Widget>[
            Center(
                child: Text('No Repo found! Please enter different username.'),
              ),
          ],
        )
        : ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(list[index].name),
              );
            },
            itemCount: list.length,
          );
  }

  Widget errorUI(Failure f, ReactiveModel<RepoList> model) {
    return Column(
      children: <Widget>[
        initialUI(model),
        SizedBox(height: 16,),
        Center(
          child: Text(f.message),
        ),
      ],
    );
  }

  void searchUserRepos(BuildContext context, String userName) {
    final reactiveModel = Injector.getAsReactive<RepoList>();
    reactiveModel.setState(
      (store) => store.fetchRepos(userName),
    );
  }
}
