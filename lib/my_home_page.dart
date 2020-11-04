import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _text = "You have pushed the button this many times:";
  var _textToEncrypt;
  var encryptResult;
  var hmacMd5;
  var key = utf8.encode('p@ssw0rd');
  var _text1 = utf8.encode("You have ");
  var _text2 = utf8.encode("pushed the button ");
  var _text3 = utf8.encode("this many times:");
  var output;
  ByteConversionSink input;

  void _incrementCounter() {
    // output = new AccumulatorSink<Digest>();
    // input = sha1.startChunkedConversion(output);
    _textToEncrypt = utf8.encode(_text);
    encryptResult = sha1.convert(_textToEncrypt);
    print("SHA1 EncrypResult = $encryptResult");
    encryptResult = sha256.convert(_textToEncrypt);
    print("SHA256 EncrypResult = $encryptResult");
    output = new AccumulatorSink<Digest>();
    input = sha1.startChunkedConversion(output);
    input.add(_text1);
    input.add(_text2);
    input.add(_text3);
    input.close();
    var digest = output.events.single;
    print("Chunked conversion as bytes : ${digest.bytes}");
    print("Chunked conversion : $digest");
    encryptResult = sha1.convert(_text1 + _text2 + _text3);
    print("SHA1 EncrypResult combine = $encryptResult");
    encryptResult = md5.convert(_textToEncrypt);
    print("Md5 EncrypResult combine = $encryptResult");
    hmacMd5 = new Hmac(md5, key);
    encryptResult = hmacMd5.convert(_textToEncrypt);
    print("Hmac Md5 EncrypResult combine = $encryptResult");
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _text,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
