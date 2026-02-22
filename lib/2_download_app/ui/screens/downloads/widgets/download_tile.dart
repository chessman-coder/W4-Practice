import 'package:flutter/material.dart';
import 'package:practice/2_download_app/ui/theme/theme.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  DownloadStatus get status => controller.status;

  IconData getStatusIcon(DownloadStatus status) {
    if (status == DownloadStatus.downloading) {
      return Icons.downloading;
    }
    if (status == DownloadStatus.downloaded) {
      return Icons.folder;
    }
    return Icons.download;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        final String? subText;
        if (status == DownloadStatus.downloading ||
            status == DownloadStatus.downloaded) {
          subText =
              "${(controller.progress * 100).round()} % completed - ${(controller.ressource.size * controller.progress).round()} of ${controller.ressource.size} MB";
        } else {
          subText = null;
        }
        return Padding(
          padding: EdgeInsets.all(12),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(controller.ressource.name),
              subtitle: subText != null
                  ? Text(subText, style: TextStyle(color: AppColors.neutral))
                  : null,
              trailing: GestureDetector(
                onTap: () {
                  if (status == DownloadStatus.notDownloaded) {
                    controller.startDownload();
                  }
                },
                child: Icon(getStatusIcon(status)),
              ),
            ),
          ),
        );
      },
    );
  }
}
