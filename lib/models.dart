class CountryData {
  int updated;
  String country;
  CountryInfo countryInfo;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  int casesPerOneMillion;
  int deathsPerOneMillion;
  int tests;
  int testsPerOneMillion;
  String continent;

  CountryData(
      {this.updated,
        this.country,
        this.countryInfo,
        this.cases,
        this.todayCases,
        this.deaths,
        this.todayDeaths,
        this.recovered,
        this.active,
        this.critical,
        this.casesPerOneMillion,
        this.deathsPerOneMillion,
        this.tests,
        this.testsPerOneMillion,
        this.continent});

  CountryData.fromJson(Map<String, dynamic> json) {
    updated = json['updated'];
    country = json['country'];
    countryInfo = json['countryInfo'] != null
        ? new CountryInfo.fromJson(json['countryInfo'])
        : null;
    cases = json['cases'];
    todayCases = json['todayCases'];
    deaths = json['deaths'];
    todayDeaths = json['todayDeaths'];
    recovered = json['recovered'];
    active = json['active'];
    critical = json['critical'];
    casesPerOneMillion = json['casesPerOneMillion'];
    deathsPerOneMillion = json['deathsPerOneMillion'];
    tests = json['tests'];
    testsPerOneMillion = json['testsPerOneMillion'];
    continent = json['continent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated'] = this.updated;
    data['country'] = this.country;
    if (this.countryInfo != null) {
      data['countryInfo'] = this.countryInfo.toJson();
    }
    data['cases'] = this.cases;
    data['todayCases'] = this.todayCases;
    data['deaths'] = this.deaths;
    data['todayDeaths'] = this.todayDeaths;
    data['recovered'] = this.recovered;
    data['active'] = this.active;
    data['critical'] = this.critical;
    data['casesPerOneMillion'] = this.casesPerOneMillion;
    data['deathsPerOneMillion'] = this.deathsPerOneMillion;
    data['tests'] = this.tests;
    data['testsPerOneMillion'] = this.testsPerOneMillion;
    data['continent'] = this.continent;
    return data;
  }
}

class CountryInfo {
  int iId;
  String iso2;
  String iso3;
  int lat;
  int long;
  String flag;

  CountryInfo({this.iId, this.iso2, this.iso3, this.lat, this.long, this.flag});

  CountryInfo.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    iso2 = json['iso2'];
    iso3 = json['iso3'];
    lat = json['lat'];
    long = json['long'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['flag'] = this.flag;
    return data;
  }
}



class TodayData {
  int totalConfirmed;
  int totalDeaths;
  int totalRecovered;
  int totalNewCases;
  int totalNewDeaths;
  int totalActiveCases;
  int totalCasesPerMillionPop;
  String created;

  TodayData(
      {this.totalConfirmed,
        this.totalDeaths,
        this.totalRecovered,
        this.totalNewCases,
        this.totalNewDeaths,
        this.totalActiveCases,
        this.totalCasesPerMillionPop,
        this.created});

  TodayData.fromJson(Map<String, dynamic> json) {
    totalConfirmed = json['totalConfirmed'];
    totalDeaths = json['totalDeaths'];
    totalRecovered = json['totalRecovered'];
    totalNewCases = json['totalNewCases'];
    totalNewDeaths = json['totalNewDeaths'];
    totalActiveCases = json['totalActiveCases'];
    totalCasesPerMillionPop = json['totalCasesPerMillionPop'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalConfirmed'] = this.totalConfirmed;
    data['totalDeaths'] = this.totalDeaths;
    data['totalRecovered'] = this.totalRecovered;
    data['totalNewCases'] = this.totalNewCases;
    data['totalNewDeaths'] = this.totalNewDeaths;
    data['totalActiveCases'] = this.totalActiveCases;
    data['totalCasesPerMillionPop'] = this.totalCasesPerMillionPop;
    data['created'] = this.created;
    return data;
  }
}


/// time series data type.
class TimeSeriesCoronaStat {
  final DateTime time;
  final int count;
  TimeSeriesCoronaStat(this.time, this.count);
}