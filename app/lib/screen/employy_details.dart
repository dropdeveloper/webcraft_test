import 'package:app/helper/db_helper.dart';
import 'package:app/model/empl_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EmployeeDetails extends StatelessWidget {
  final id;
  EmployeeDetails({required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<Employee>(
            future: new DBHelper().getEmployyById(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 0,
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data!.profile_image,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data!.name,
                                style: TextStyle(fontSize: 20)),
                            Text(snapshot.data!.company),
                            Text(snapshot.data!.email),
                          ],
                        )),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("ADDRESS DETAILS",
                            style: TextStyle(fontSize: 16.0)),
                        Divider(),
                        _details("Street", snapshot.data!.street),
                        _details("Suite", snapshot.data!.suite),
                        _details("City", snapshot.data!.city),
                        _details("ZipCode", snapshot.data!.zipcode),
                        SizedBox(height: 20),
                        Text("COMPANY DETAILS",
                            style: TextStyle(fontSize: 16.0)),
                        Divider(),
                        _details("Company", snapshot.data!.company),
                        _details("catchPhrase", snapshot.data!.catchPhrase),
                        _details("Bs", snapshot.data!.bs),
                      ],
                    )
                  ],
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _details(String title, String val) {
    return Row(
      children: [
        Expanded(child: Text(title)),
        Expanded(child: Text(val)),
      ],
    );
  }
}
