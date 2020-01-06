class Commit {
  Committer committer;
  String message;

  Commit({this.committer, this.message});

  Commit.fromJson(Map<String, dynamic> json) {
    committer = json['committer'] != null
        ? new Committer.fromJson(json['committer'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.committer != null) {
      data['committer'] = this.committer.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Committer {
  String name;
  String email;
  String date;

  Committer({this.name, this.email, this.date});

  Committer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['date'] = this.date;
    return data;
  }
}

