import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CORONA TRACKER',
      home: MyHomePage(),
      theme: ThemeData.dark(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var res, data, india,convertData;
  int total;
  var url = 'https://api.rootnet.in/covid19-in/stats/latest';

  @override
  void initState() {
    _checkInternetConnectivity();
    fetchData();
    super.initState();
  }

  fetchData() async {
    res = await http.get(url);
//    print(res.body);
     convertData = await json.decode(res.body);
    data = await convertData['data']['regional'];
    india = await convertData['data']['summary'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'COVID-19',
            style: TextStyle(color: Colors.blueAccent, fontSize: 35.0),
          ),
          centerTitle: true,
        ),
        body: convertData != null ? Stack(
          children: <Widget>[
            Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 32,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                '${data[index]['loc']}',
                                style: TextStyle(
                                    fontSize: 40.0, color: Colors.cyanAccent),
                              ),
                              Text(
                                'Total Case : ',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.yellow),
                              ),
                              Text(
                                '${data[index]['totalConfirmed']}',
                                style: TextStyle(
                                    fontSize: 45.0, color: Colors.red),
                              ),
                              Text(
                                'Deaths ',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.yellow),
                              ),
                              Text(
                                '${data[index]['deaths']}',
                                style: TextStyle(
                                    fontSize: 45.0, color: Colors.red),
                              ),
                              Text(
                                'Discharged : ',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.yellow),
                              ),
                              Text(
                                '${data[index]['discharged']}',
                                style: TextStyle(
                                    fontSize: 45.0, color: Colors.red),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(left: 20.0, right: 30.0),
                          height: 450.0,
                          width: 310.0,
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(50.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.lightBlue,
                                  offset: Offset(6.0, 6.0),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                                BoxShadow(
                                  color: Colors.red,
                                  offset: Offset(-6.0, -6.0),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                )
                              ]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'INDIA',
                            style: TextStyle(fontSize: 40.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.yellow),
                                  ),
                                  Text(
                                    '${india['total']}',
                                    style: TextStyle(
                                        fontSize: 40.0, color: Colors.red),
                                  ),
                                ],
                              ),
                              Container(
                                width: 2.0,
                                color: Colors.blueAccent,
                                height: 120.0,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'DEATHS',
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.yellow),
                                  ),
                                  Text(
                                    '${india['deaths']}',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.red),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'DISCHARGE',
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.yellow),
                                      ),
                                      Text(
                                        '${india['discharged']}',
                                        style: TextStyle(
                                            fontSize: 20.0, color: Colors.red),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(left: 20.0, right: 30.0),
                      height: 180.0,
                      width: 310.0,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber,
                              offset: Offset(6.0, 6.0),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                            BoxShadow(
                              color: Colors.purple,
                              offset: Offset(-6.0, -6.0),
                              blurRadius: 10,
                              spreadRadius: 5,
                            )
                          ]),
                    ),
                  ],
                ),
              ),
              bottom: 20.0,
            ),
          ],
        ): Center(
          child: CircularProgressIndicator(),
        ));
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog('No internet !!',
          "Please Check your internet connection and restart app");
    } else if (result == ConnectivityResult.mobile) {
    } else if (result == ConnectivityResult.wifi) {}
  }

  _showDialog(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
