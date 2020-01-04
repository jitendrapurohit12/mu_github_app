import 'package:mu_github_app/models/repo.dart';
import 'package:mu_github_app/service/repo_service.dart';

class RepoList{
  List<Repo> repoList = List();

  fetchRepos(String userName)async{
    repoList = await ApiServices().getReposForUser(userName);
  }
}