class IncidentListModel {
  List<Incidents>? incidents;

  IncidentListModel({this.incidents});

  IncidentListModel.fromJson(Map<String, dynamic> json) {
    if (json['incidents'] != null) {
      incidents = <Incidents>[];
      json['incidents'].forEach((v) {
        incidents!.add(new Incidents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.incidents != null) {
      data['incidents'] = this.incidents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Incidents {
  String? lat;
  String? lon;
  String? incidentID;
  String? uUID;
  String? distance;
  String? radius;
  String? name;
  String? snippet;
  String? descriptor;
  String? type;
  String? code;
  String? state;
  String? count;
  String? mediaCount;
  String? projectID;
  String? incidentProjID;
  String? created;
  String? reason;
  String? disposition;
  String? incidentStatus;
  String? createdBy;
  String? createdByUser;
  String? lastupdated;
  String? offlineDescription;
  String? isSIOI;
  String? updates;
  String? icon;

  Incidents(
      {this.lat,
      this.lon,
      this.incidentID,
      this.uUID,
      this.distance,
      this.radius,
      this.name,
      this.snippet,
      this.descriptor,
      this.type,
      this.code,
      this.state,
      this.count,
      this.mediaCount,
      this.projectID,
      this.incidentProjID,
      this.created,
      this.reason,
      this.disposition,
      this.incidentStatus,
      this.createdBy,
      this.createdByUser,
      this.lastupdated,
      this.offlineDescription,
      this.isSIOI,
      this.updates,
      this.icon});

  Incidents.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    incidentID = json['incidentID'];
    uUID = json['UUID'];
    distance = json['distance'];
    radius = json['radius'];
    name = json['name'];
    snippet = json['snippet'];
    descriptor = json['descriptor'];
    type = json['type'];
    code = json['code'];
    state = json['state'];
    count = json['count'];
    mediaCount = json['mediaCount'];
    projectID = json['projectID'];
    incidentProjID = json['incidentProjID'];
    created = json['created'];
    reason = json['reason'];
    disposition = json['disposition'];
    incidentStatus = json['incidentStatus'];
    createdBy = json['createdBy'];
    createdByUser = json['createdByUser'];
    lastupdated = json['lastupdated'];
    offlineDescription = json['offlineDescription'];
    isSIOI = json['isSIOI'];
    updates = json['updates'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['incidentID'] = this.incidentID;
    data['UUID'] = this.uUID;
    data['distance'] = this.distance;
    data['radius'] = this.radius;
    data['name'] = this.name;
    data['snippet'] = this.snippet;
    data['descriptor'] = this.descriptor;
    data['type'] = this.type;
    data['code'] = this.code;
    data['state'] = this.state;
    data['count'] = this.count;
    data['mediaCount'] = this.mediaCount;
    data['projectID'] = this.projectID;
    data['incidentProjID'] = this.incidentProjID;
    data['created'] = this.created;
    data['reason'] = this.reason;
    data['disposition'] = this.disposition;
    data['incidentStatus'] = this.incidentStatus;
    data['createdBy'] = this.createdBy;
    data['createdByUser'] = this.createdByUser;
    data['lastupdated'] = this.lastupdated;
    data['offlineDescription'] = this.offlineDescription;
    data['isSIOI'] = this.isSIOI;
    data['updates'] = this.updates;
    data['icon'] = this.icon;
    return data;
  }
}
