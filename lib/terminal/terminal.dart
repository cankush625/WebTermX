import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';

class TerminalOutput extends StatefulWidget {
  @override
  _TerminalOutputState createState() => _TerminalOutputState();
}
// ignore: non_constant_identifier_names
class _TerminalOutputState extends State<TerminalOutput> {
//  var fsconnect = FirebaseFirestore.instance;
  static var screensize;

  static TextEditingController _textController = new TextEditingController();
  static Map commandOutput = new Map();
  String msgLine = " ";
  String commandName = " ";
  String output = " ";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text(
            'WebTermX',
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              ListView.builder(
                itemCount: commandOutput.length,
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                itemBuilder: (BuildContext context, int index) {
                  screensize = MediaQuery.of(context).size.width;
                  try {
                    String key = commandOutput.keys.elementAt(index);
                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'mac@ankush',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              '>>>',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.red,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                key,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          commandOutput[key],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  } catch (e) {
                    e.toString();
                    return Text(' ');
                  }
                },
              ),
              Row(
                children: <Widget>[
                  Text(
                    'mac@ankush',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    '>>>',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    width: 200 * 0.65,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      controller: _textController,
                      autocorrect: false,
                      scrollPadding: EdgeInsets.all(0),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onFieldSubmitted: (_textController) async {
                        commandName = await _textController.toString();
                        var url = "http://13.232.106.3/cgi-bin/$commandName.py";
                        var result = await http.get(url);
                        var data = result.body;
                        setState(() {
                          output = data;
                        });
                        print(commandName);
                        commandOutput[commandName] = output;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 5)
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}