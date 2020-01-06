import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mu_github_app/models/commit.dart';
import 'package:mu_github_app/models/repo.dart';

class ApiServices {
  Dio _dio = Dio();

  final baseUrl = 'https://api.github.com';

  String getUserUrl(String username) => '$baseUrl/users/$username';

  String getUserRepos(String username) => '${getUserUrl(username)}/repos';

  String getRepoCommits(String username, String projectName) =>
      '$baseUrl/repos/$username/$projectName/commits';

  Future<List<Repo>> getReposForUser(String username) async {
    List<Repo> repoList = List();
    Response repoResponse;
    Response userResponse = await _dio
        .get(getUserUrl(username))
        .catchError((e) => throw Failure(message: 'User Not Found'));
    if (userResponse != null && userResponse.data != null) {
      repoResponse = await _dio.get(getUserRepos(username));

      if (repoResponse != null) {
        List<dynamic> mapList = repoResponse.data;

        mapList.forEach((map) {
          repoList.add(Repo.fromJson(map));
        });
      } else
        throw Failure(message: 'No Repo Found');
    } else
      throw Failure(message: 'No user found');

    return repoList;
  }

  Future<List<Commit>> getCommits(String username, String repoName)async{
    List<Commit> commitList = List();
    var response = await _dio.get(getRepoCommits(username, repoName));

    if(response != null && response.data != null){
      List<dynamic> list = response.data;

      list.forEach((map){
        dynamic com = map['commit'];
        commitList.add(Commit.fromJson(com));
      });
    }
    return commitList;
  }
}

class Failure {
  String message;

  Failure({@required message});
}
