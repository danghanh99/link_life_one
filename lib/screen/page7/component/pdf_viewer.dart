import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  final List<String> filePaths;
  final double ratio;
  final bool showPage;
  final Function(int)? onPageChange;
  const PdfViewer(
      {super.key,
      required this.filePaths,
      this.ratio = 16 / 9,
      this.showPage = true,
      this.onPageChange});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  int currentPage = 0;

  void onChangePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider.builder(
              itemCount: widget.filePaths.length,
              itemBuilder: (ctx, index, realIndex) {
                return SfPdfViewer.network(
                  widget.filePaths[index],
                  onDocumentLoaded: (details) {},
                  onDocumentLoadFailed: (detail) {
                    CustomToast.show(context, message: "PDFを取得出来ませんでした。");
                    // message: detail.description);
                  },
                );
              },
              options: CarouselOptions(
                viewportFraction: 1,
                aspectRatio: widget.ratio,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  onChangePage(index);
                  if (widget.onPageChange != null) {
                    widget.onPageChange!(index);
                  }
                },
              )),
        ),
        Visibility(
          visible: widget.showPage && widget.filePaths.isNotEmpty,
          child: Center(
            child: Text(
              "${currentPage + 1}/${widget.filePaths.length}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
