import 'package:capcell/function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class TreeViewPage extends StatefulWidget {
  const TreeViewPage({super.key});

  @override
  _TreeViewPageState createState() => _TreeViewPageState();
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
              '/Users/takayahasuike/development/flutter-project/ongoing-project/capcell/lib/main.dart',
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

  List hoverList = [0, false];

  Widget Capcell(int? a) {
    bool isHover = false;
    if (hoverList[0] == a) {
      isHover = hoverList[1];
    }
    return InkWell(
      onHover: (value) {
        hoverList = [a, value];
        setState(() {});
      },
      onTap: () {},
      child: SizedBox(
        width: isHover ? 380 : 300,
        height: isHover ? 140 : 100,
        child: Stack(
          children: [
            Align(alignment: Alignment.topCenter, child: rectangleWidget(a)),
            isHover
                ? Positioned(
                  top: 50 - 35 / 2,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      print("object");
                    },
                    child: addButton(),
                  ),
                )
                : SizedBox(),
            isHover
                ? Positioned(
                  bottom: 0,
                  left: 95,
                  child: InkWell(
                    onTap: () {
                      print("object");
                    },
                    child: addButton(),
                  ),
                )
                : SizedBox(),
            isHover
                ? Positioned(
                  bottom: 0,
                  right: 95,
                  child: InkWell(
                    onTap: () {
                      print("object");
                    },
                    child: addButton(),
                  ),
                )
                : SizedBox(),
          ],
        ),
      ),
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

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    final node1 = Node.Id(1);
    final node2 = Node.Id(2);
    final node3 = Node.Id(3);
    final node4 = Node.Id(4);
    final node5 = Node.Id(1);
    final node6 = Node.Id(6);
    final node8 = Node.Id(7);
    final node7 = Node.Id(8);
    final node9 = Node.Id(9);
    final node10 = Node.Id(10);
    final node11 = Node.Id(11);
    final node12 = Node.Id(12);
    graph.addEdge(node1, node2);
    graph.addEdge(node1, node3);

    // graph.addEdge(node1, node4);
    // graph.addEdge(node2, node5);
    // graph.addEdge(node2, node6);
    // graph.addEdge(node6, node7);
    // graph.addEdge(node6, node8);
    // graph.addEdge(node4, node9);
    // graph.addEdge(node4, node10);
    // graph.addEdge(node4, node11);
    // graph.addEdge(node11, node12);

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }
}

PreferredSizeWidget appbar() {
  return AppBar(
    title: Text("プロジェクトタイトル"),
    actions: [Icon(CupertinoIcons.settings)],
  );
}
