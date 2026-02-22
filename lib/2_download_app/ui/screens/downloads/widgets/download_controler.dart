import 'package:flutter/material.dart';

class Ressource {
  final String name;
  final int size; // in MB

  Ressource({required this.name, required this.size});
}

enum DownloadStatus { notDownloaded, downloading, downloaded }

class DownloadController extends ChangeNotifier {
  DownloadController(this.ressource);

  // DATA
  Ressource ressource;
  DownloadStatus _status = DownloadStatus.notDownloaded;
  double _progress = 0.0; // 0.0 → 1.0

  // GETTERS
  DownloadStatus get status => _status;
  double get progress => _progress;

  set status(DownloadStatus newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  // ACTIONS
  void startDownload() async {
    if (_status == DownloadStatus.downloading) {
      return;
    }
    if (_status == DownloadStatus.notDownloaded) {
      _status = DownloadStatus.downloading;
      notifyListeners();
      for (int i = 0; i < 10; i++) {
        _progress += 0.1;
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 1000));
      }
      _status = DownloadStatus.downloaded;
      notifyListeners();
    }

    // TODO
    // 1 – set status to downloading
    // 2 – Loop 10 times and increment the download progress (0 -> 0.1 -> 0.2 )
    //      - Wait 1 second :  await Future.delayed(const Duration(milliseconds: 1000));

    // 3 – set status to downloaded
  }
}
