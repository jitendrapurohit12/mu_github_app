import 'package:mu_github_app/models/commit.dart';
import 'package:mu_github_app/service/repo_service.dart';

class CommitList{

  List<Commit> commitList = List();


fetchCommits(String username, String repoName)async{
  commitList = await ApiServices().getCommits(username, repoName);
}
}