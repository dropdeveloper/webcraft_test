import 'dart:convert';
import 'package:app/helper/db_helper.dart';
import 'package:app/helper/internet_helper.dart';
import 'package:app/model/empl_model.dart';
import 'package:app/screen/employy_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late DBHelper dbHelper;
  late Future<List<Employee>> employss;

  void _loadApi() async {
    String response = await InternetHelper().get(InternetHelper.url);
    List<dynamic> data = jsonDecode(response);
    data.forEach((element) {
      Employee employee = new Employee(
        element["id"],
        element["name"],
        element["username"],
        element["email"],
        element["profile_image"] ?? "null",
        element["phone"] ?? "null",
        element["website"] ?? "null",
        element["company"] != null ? element["company"]["name"] : "null",
        element["company"] != null ? element["company"]["catchPhrase"] : "null",
        element["company"] != null ? element["company"]["bs"] : "null",
        element["company"] != null ? element["address"]["street"] : "null",
        element["company"] != null ? element["address"]["city"] : "null",
        element["company"] != null ? element["address"]["suite"] : "null",
        element["company"] != null ? element["address"]["zipcode"] : "null",
      );
      //add new data
      dbHelper.addEmploy(employee);
      setState(() {
        getEmployList();
      });
    });
  }

  getEmployList() {
    setState(() {
      employss = dbHelper.getEmployy();
    });
  }

  searchEmployy(String key) {
    setState(() {
      employss = dbHelper.getEmploySearch(key);
    });
  }

  @override
  void initState() {
    super.initState();
    dbHelper = new DBHelper();
    _loadApi();
    getEmployList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sample list"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              TextField(
                onChanged: (query) {
                  if (query.length == 0) {
                    getEmployList();
                  } else {
                    searchEmployy(query);
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: "Search"),
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder<List<Employee>>(
                    future: employss,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: snapshot.data![index].profile_image,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                title: Text(snapshot.data![index].name),
                                subtitle: Text(snapshot.data![index].company),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EmployeeDetails(
                                            id: snapshot.data![index].id,
                                          )));
                                },
                              );
                            });
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
