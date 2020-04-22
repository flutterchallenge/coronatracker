import 'dart:convert';

import 'package:coronatracker/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

import 'models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoronaTracker',
      theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          )),
      home: MyHomePage(title: 'CoronaTracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<charts.Series> seriesList;
  bool animate;


  _globalCountView(AsyncSnapshot snapshot) {
    return Container(
      height: 120.0,
      padding: EdgeInsets.all(16.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: snapshot == null ? Center(child: CircularProgressIndicator(),): snapshot.hasError ? Center(child: Text(snapshot.error.toString()),):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Total Confirmed",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "${snapshot.data.totalConfirmed}",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: snapshot == null ? Center(child: CircularProgressIndicator(),): snapshot.hasError ? Center(child: Text(snapshot.error.toString()),):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Total Recovered",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "${snapshot.data.totalRecovered}",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: snapshot == null ? Center(child: CircularProgressIndicator(),): snapshot.hasError ? Center(child: Text(snapshot.error.toString()),):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Total Death",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "${snapshot.data.totalDeaths}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
        ],
      ),
    );
  }

  _globalEffectLineChart(AsyncSnapshot<List<charts.Series<TimeSeriesCoronaStat, DateTime>>> snapshot) {
    return snapshot == null ? Center( child: CircularProgressIndicator(),) : snapshot.hasError ? Text(snapshot.error.toString()) :
    charts.TimeSeriesChart(
      snapshot.data,
      animate: false,
      // Configure the default renderer as a line renderer. This will be used
      // for any series that does not define a rendererIdKey.
      //
      // This is the default configuration, but is shown here for  illustration.
      defaultRenderer: new charts.LineRendererConfig(),
      // Custom renderer configuration for the point series.
      customSeriesRenderers: [
        new charts.PointRendererConfig(
          // ID used to link series to this renderer.
            customRendererId: 'customPoint')
      ],
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }


  Future<List<charts.Series<TimeSeriesCoronaStat, DateTime>>> _getTimeSeriesData() async {
    return http.get(Constants.BASE_URL + "/timeseries?days=30").then(
        (response) {
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          Map<String, dynamic> casesMap = responseMap["cases"];
          Map<String, dynamic> recoveredMap = responseMap["recovered"];
          Map<String, dynamic> deathsMap = responseMap["deaths"];
          print(casesMap.toString());
          List<TimeSeriesCoronaStat> casesList = [];
          casesMap.forEach((key, value) => casesList.add(new TimeSeriesCoronaStat(Constants.stringToDateTime(key, "M/d/yyyy"), value)));
          List<TimeSeriesCoronaStat> recoveredList = [];
          recoveredMap.forEach((key, value) => recoveredList.add(new TimeSeriesCoronaStat(Constants.stringToDateTime(key, "M/d/yyyy"), value)));
          List<TimeSeriesCoronaStat> deathList = [];
          deathsMap.forEach((key, value) => deathList.add(new TimeSeriesCoronaStat(Constants.stringToDateTime(key, "M/d/yyyy"), value)));
          print("caselist size = ${casesList.length}, deathlist size = ${deathList.length}, recovered length = ${recoveredList.length}");
          return [
            new charts.Series<TimeSeriesCoronaStat, DateTime>(
              id: 'Recovered',
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (TimeSeriesCoronaStat stat, _) => stat.time,
              measureFn: (TimeSeriesCoronaStat recovered, _) => recovered.count,
              data: recoveredList??[],
            ),
            new charts.Series<TimeSeriesCoronaStat, DateTime>(
              id: 'Deaths',
              colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
              domainFn: (TimeSeriesCoronaStat stat, _) => stat.time,
              measureFn: (TimeSeriesCoronaStat death, _) => death.count,
              data: deathList??[],
            ),
            new charts.Series<TimeSeriesCoronaStat, DateTime>(
                id: 'Cases',
                colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
                domainFn: (TimeSeriesCoronaStat stat, _) => stat.time,
                measureFn: (TimeSeriesCoronaStat cases, _) => cases.count,
                data: casesList??[])
            // Configure our custom point renderer for this series.
              ..setAttribute(charts.rendererIdKey, 'customPoint'),
          ];
    }, onError: (error) {
      return Future.error(ErrorDescription(error.toString()));
    });
  }

  Future<TodayData> _getGlobalData() {
    return http.get(Constants.BASE_URL + "/count").then((response) {
      return TodayData.fromJson(jsonDecode(response.body));
    }, onError: (error) {
      return Future.error(ErrorDescription(error.toString()));
    });
  }

  _getAllCountryData() {
    return http.get(Constants.BASE_URL + "/stat").then((response) {
      List allData =  jsonDecode(response.body);
      return List<CountryData>.generate(allData.length, (index) => CountryData.fromJson(allData[index]));
    }, onError: (error) {
      return Future.error(ErrorDescription(error.toString()));
    });
  }

  @override
  void initState() {
    animate = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Corona Tracker"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: _getGlobalData(),
                builder: (context, snapshot) {
                  return _globalCountView(snapshot);
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Outbreak trend over time",
                style:  Theme.of(context).textTheme.title,
              ),
              SizedBox(height: 8.0,),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                child: FutureBuilder(
                  future: _getTimeSeriesData(),
                  builder: (context, snapshot) {
                    return _globalEffectLineChart(snapshot);
                  },
                ),
              ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "All Countries stat",
              style:  Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 8.0,),

            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
