import 'package:capcell/function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class TreeViewPage extends StatefulWidget {
  const TreeViewPage({super.key});

  @override
  State<TreeViewPage> createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  late Node edge;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Wrap(
            children: [
              Container(
                width: 100,
                child: TextFormField(
                  initialValue: builder.siblingSeparation.toString(),
                  decoration: InputDecoration(labelText: 'Sibling Separation'),
                  onChanged: (text) {
                    builder.siblingSeparation = int.tryParse(text) ?? 100;
                    this.setState(() {});
                  },
                ),
              ),
              Container(
                width: 100,
                child: TextFormField(
                  initialValue: builder.levelSeparation.toString(),
                  decoration: InputDecoration(labelText: 'Level Separation'),
                  onChanged: (text) {
                    builder.levelSeparation = int.tryParse(text) ?? 100;
                    this.setState(() {});
                  },
                ),
              ),
              Container(
                width: 100,
                child: TextFormField(
                  initialValue: builder.subtreeSeparation.toString(),
                  decoration: InputDecoration(labelText: 'Subtree separation'),
                  onChanged: (text) {
                    builder.subtreeSeparation = int.tryParse(text) ?? 100;
                    this.setState(() {});
                  },
                ),
              ),
              Container(
                width: 100,
                child: TextFormField(
                  initialValue: builder.orientation.toString(),
                  decoration: InputDecoration(labelText: 'Orientation'),
                  onChanged: (text) {
                    builder.orientation = int.tryParse(text) ?? 100;
                    setState(() {});
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final node12 = Node.Id(3);
                  // var edge = graph.getNodeAtPosition(
                  //   r.nextInt(graph.nodeCount()),
                  // );

                  edge = Node.Id(500);
                  edge.position = Offset(100, 600);
                  print(edge);
                  graph.addEdge(edge, node12);
                  setState(() {});
                },
                child: Text('Add'),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              // edge.position = Offset(edge.position.dx + 10, 0);
              // read();
              pickFolderAndListFiles();
              setState(() {});
            },

            child: Text("左"),
          ),
          Expanded(
            child: InteractiveViewer(
              constrained: false,
              boundaryMargin: EdgeInsets.all(1000),
              minScale: 0.01,
              maxScale: 15.6,
              child: GraphView(
                graph: graph,
                algorithm: BuchheimWalkerAlgorithm(
                  builder,
                  TreeEdgeRenderer(builder),
                ),
                paint:
                    Paint()
                      ..color = Colors.black
                      ..strokeWidth = 2
                      ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  // I can decide what widget should be shown here based on the id
                  var a = node.key!.value as int?;

                  return Capcell(a);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rectangleWidget(int? a) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onDoubleTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 3), // 上
                left: BorderSide(width: 3), // 左
                bottom: BorderSide(width: 3), // 下
                right: BorderSide.none, // 右を消す
              ),
            ),
            height: 100,
            width: 150,
            child: Text("$a", style: TextStyle(fontSize: 50)),
          ),
        ),
        InkWell(
          onDoubleTap: () async {
            await openVSCodeFromFlutter(
              '/Users/takayahasuike/development/flutter-project/Ongoing_projects/capcell/lib/main.dart',
            );
          },

          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 108, 229, 206),
              border: Border.all(width: 3),
            ),
            height: 100,
            width: 150,
            child: Center(
              child: IntrinsicWidth(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50, // 最小幅
                    maxWidth: 300, // 最大幅（長文で暴れすぎないように）
                  ),

                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    maxLines: null, // 複数行OK
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Capcell(int? a) {
    return HoverableCell(
      key: ValueKey(a),
      nodeId: a,
      rectangleBuilder: rectangleWidget,
      buttonBuilder: addButton,
      onAddCell: addCell,
    );
  }

  Widget addButton() {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent,
      ),
      child: Icon(CupertinoIcons.add, color: Colors.white),
    );
  }

  void addCell(int id, String position) async {
    // 使用例
    final node = findNodeById(graph, id);
    int lastID = await loadLastId();
    int newID = lastID + 1;
    var newNode = Node.Id(newID);
    print(id);
    switch (position) {
      case (Position.right):
        newNode.position = Offset(node!.x + 400, node.y);
        final targetNode = findNodeById(graph, 1);
        if (targetNode != null) {
          graph.addEdge(targetNode, newNode);
        }
        break;
      case (Position.bottomLeft):
        newNode.position = Offset(node!.x, node.y + 250);
        graph.addEdge(node, newNode);
        break;
      case (Position.bottomRight):
        newNode.position = Offset(node!.x, node.y + 250);
        graph.addEdge(node, newNode);
        break;
    }
    saveLastId(newID);

    setState(() {});
  }

  Node? findNodeById(Graph graph, int id) {
    for (var node in graph.nodes) {
      if (node.key?.value == id) {
        return node;
      }
    }
    return null;
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    final node1 = Node.Id(1);
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);

    graph.addEdge(node1, node2);
    graph.addEdge(node1, node3);

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      title: Text("プロジェクトタイトル"),
      actions: [Icon(CupertinoIcons.settings)],
    );
  }
}

class Position {
  static const String right = "right";
  static const String bottomLeft = "bottomLeft";
  static const String bottomRight = "bottomRight";
}

// 独立したホバー状態を持つセルウィジェット
class HoverableCell extends StatefulWidget {
  final int? nodeId;
  final Widget Function(int?) rectangleBuilder;
  final Widget Function() buttonBuilder;
  final void Function(int, String) onAddCell;

  const HoverableCell({
    super.key,
    required this.nodeId,
    required this.rectangleBuilder,
    required this.buttonBuilder,
    required this.onAddCell,
  });

  @override
  State<HoverableCell> createState() => _HoverableCellState();
}

class _HoverableCellState extends State<HoverableCell> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      onTap: () {},
      child: SizedBox(
        width: 380,
        height: 140,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 40,
              child: widget.rectangleBuilder(widget.nodeId),
            ),
            if (isHover) ...[
              Positioned(
                top: 50 - 35 / 2,
                right: 0,
                child: InkWell(
                  onTap: () {
                    if (widget.nodeId != null) {
                      widget.onAddCell(widget.nodeId!, Position.right);
                    }
                  },
                  child: widget.buttonBuilder(),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 95,
                child: InkWell(
                  onTap: () {
                    if (widget.nodeId != null) {
                      widget.onAddCell(widget.nodeId!, Position.bottomLeft);
                    }
                  },
                  child: widget.buttonBuilder(),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 95,
                child: InkWell(
                  onTap: () {
                    if (widget.nodeId != null) {
                      widget.onAddCell(widget.nodeId!, Position.bottomRight);
                    }
                  },
                  child: widget.buttonBuilder(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
