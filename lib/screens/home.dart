import 'package:flutter/material.dart';
import 'dart:async';
import 'package:simple_permissions/simple_permissions.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => new _Home();
}

class _Home extends State<Home> {

  String status;
  Permission permission;

  @override
  void initState(){
    super.initState();
    status = 'Select an item';
    print(Permission.values);
  }

  requestPermission() async {
    final res = await SimplePermissions.requestPermission(permission);
    print("Permission result is ${res.toString()}");

    setState(() {
      status = '${permission.toString()} = ${res.toString()}';
    });
  }

  checkPermission() async {
    bool res = await SimplePermissions.checkPermission(permission);
    print("Permission result is ${res.toString()}");

    setState(() {
      status = '${permission.toString()} = ${res.toString()}';
    });
  }

  getPermissionStatus() async {
    final res = await SimplePermissions.getPermissionStatus(permission);
    print("Permission result is ${res.toString()}");

    setState(() {
      status = '${permission.toString()} = ${res.toString()}';
    });
  }

  onDropDownChange(Permission permission) {
    setState(() {
      this.permission = permission;
      status = 'Click a button below';
    });
    print(permission);
  }

  List<DropdownMenuItem<Permission>> _getDropDwnItems() {
    List<DropdownMenuItem<Permission>> items = new List<DropdownMenuItem<Permission>>();
    Permission.values.forEach((permission){
      var item = new DropdownMenuItem(child: new Text(getPermissionString(permission)), value: permission,);
      items.add(item);
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(status),
              new DropdownButton(items: _getDropDwnItems(), value: permission, onChanged: onDropDownChange),
              new RaisedButton(onPressed: checkPermission, child: new Text('Check Permission'),),
              new RaisedButton(onPressed: requestPermission, child: new Text('Request Permission'),),
              new RaisedButton(onPressed: getPermissionStatus, child: new Text('Get Status'),),
              new RaisedButton(onPressed: SimplePermissions.openSettings, child: new Text('Open Settings'),),
            ],
          ),
        ),
      ),
    );
  }
}
