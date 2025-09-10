import 'dart:math' as math;
import 'package:capcell/tree_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    const int totalItems = 50; // 表示する総アイテム数
    const double widgetWidth = 230; // 各アイテムの固定幅
    const double widgetHeight = 200; // 各アイテムの固定高さ
    const double space = 40; // アイテム間のスペース
    const double horizontalPadding = 40; // 両端の余白

    return LayoutBuilder(
      builder: (context, constraints) {
        // パディング分を除いた実効横幅
        final double effectiveWidth =
            constraints.maxWidth - horizontalPadding * 2;

        // 1行に入る個数を計算（少なくとも1）
        int itemsPerRow =
            ((effectiveWidth + space) / (widgetWidth + space)).floor();
        if (itemsPerRow < 1) itemsPerRow = 1;

        // 必要な行数
        final int rowCount = (totalItems + itemsPerRow - 1) ~/ itemsPerRow;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 8,
          ),
          child: ListView.builder(
            itemCount: rowCount,
            itemBuilder: (context, rowIndex) {
              final int start = rowIndex * itemsPerRow;
              final int end = math.min(start + itemsPerRow, totalItems);
              final int count = end - start;

              return Padding(
                padding: const EdgeInsets.only(bottom: space),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(count, (i) {
                    final index = start + i;
                    return Padding(
                      padding: EdgeInsets.only(
                        right: i == count - 1 ? 0 : space,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return TreeViewPage();
                              },
                            ),
                          );
                        },
                        child: SizedBox(
                          width: widgetWidth,
                          height: widgetHeight,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[100 * ((index % 8) + 1)],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                                width: widgetWidth,
                                height: widgetHeight * 3 / 5,
                                alignment: Alignment.center,
                                child: Text('Item $index'),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                  ),
                                ),
                                width: widgetWidth,
                                height: widgetHeight * 2 / 5,
                                alignment: Alignment.center,
                                child: Text('Item $index'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
