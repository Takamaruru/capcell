import 'dart:math' as math;
import 'package:capcell/tree_view.dart';
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
                                return const TreeViewPage();
                              },
                            ),
                          );
                        },
                        child: SizedBox(
                          width: widgetWidth,
                          height: widgetHeight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: widgetWidth,
                                  height: widgetHeight * 3 / 5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.blue[300 + (index % 4) * 100]!,
                                        Colors.blue[200 + (index % 4) * 100]!,
                                      ],
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.folder_outlined,
                                    size: 48,
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'プロジェクト ${index + 1}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '最終更新: ${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
