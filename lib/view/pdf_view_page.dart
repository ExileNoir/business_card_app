import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

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

    print('is landScap: $_isLandscape'); // debug purpose

    if (_isLandscape) {
      _futureLandscapeBuilder();
    }
    if (!_isLandscape) {
      _futurePortraitBuilder();
    }

    return Scaffold(
      key: _pdfViewerKey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        // title: Text('My CV'),
      ),
      body: Stack(
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
          !_pdfReady ? Center(child: CircularProgressIndicator()) : Offstage(),
        ],
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
