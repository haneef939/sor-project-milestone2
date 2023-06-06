class ProjectListModel {
  List<ProjectDetails>? data;
  String? status;
  int? projectcount;
  String? singleproject;

  ProjectListModel(
      {this.data, this.status, this.projectcount, this.singleproject});

  ProjectListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProjectDetails>[];
      json['data'].forEach((v) {
        data!.add(ProjectDetails.fromJson(v));
      });
    }
    status = json['status'];
    projectcount = json['projectcount'];
    singleproject = json['singleproject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['projectcount'] = this.projectcount;
    data['singleproject'] = this.singleproject;
    return data;
  }
}

class ProjectDetails {
  String? projectid;
  String? permission;
  String? name;

  ProjectDetails({this.projectid, this.permission, this.name});

  ProjectDetails.fromJson(Map<String, dynamic> json) {
    projectid = json['projectid'];
    permission = json['permission'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectid'] = this.projectid;
    data['permission'] = this.permission;
    data['name'] = this.name;
    return data;
  }
}
