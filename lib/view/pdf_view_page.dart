import 'dart:async';

import 'package:deseure_steven_card/view/my_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PdfViewPage extends StatefulWidget {
  final String path;

  PdfViewPage({this.path});

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> with WidgetsBindingObserver {
  bool _pdfReady = false;
  Completer<PDFViewController> _controller = Completer<PDFViewController>();

  bool _stopBuild = true;
  bool _stopBuild2 = false;
  UniqueKey _pdfViewerKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    print('build PDF view Page'); // debug purpose
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (_isLandscape) {
      _futureLandscapeBuilder();
    }
    if (!_isLandscape) {
      _futurePortraitBuilder();
    }

    return Scaffold(
      key: _pdfViewerKey,
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: 45.0,
          height: 35.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) {
                  return MyPage();
                }),
              );
            },
            backgroundColor: Colors.teal,
            tooltip: 'Previous',
            child: Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Icon(FontAwesomeIcons.arrowCircleLeft),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(20.0),
              ),
              side: BorderSide(color: Colors.teal, width: 2.0),
            ),
          ),
        ),
      ),
      body: Container(
        child: Stack(
          fit: StackFit.loose,
          children: [
            PDFView(
              filePath: widget.path,
              autoSpacing: true,
              enableSwipe: true,
              nightMode: false,
              pageFling: true,
              swipeHorizontal: true,
              fitPolicy: FitPolicy.WIDTH,
              onRender: (_pages) {
                setState(() {
                  _pdfReady = true;
                });
              },
              onViewCreated: (final PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
            ),
            !_pdfReady
                ? Center(child: CircularProgressIndicator())
                : Offstage(),
          ],
        ),
      ),
    );
  }

  void _futurePortraitBuilder() {
    if (_stopBuild2) {
      setState(() {
        print("Build in Portrait"); // debug purpose
        _controller = Completer<PDFViewController>();
        _pdfViewerKey = UniqueKey();
        _stopBuild2 = false;
        _stopBuild = true;
      });
    }
  }

  void _futureLandscapeBuilder() {
    if (_stopBuild) {
      setState(() {
        print("Build in LandScape"); // debug purpose
        _controller = Completer<PDFViewController>();
        _pdfViewerKey = UniqueKey();
        _stopBuild = false;
        _stopBuild2 = true;
      });
    }
  }
}
