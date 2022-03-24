import 'package:flutter/material.dart';

void main() {
  runApp(WadToDoApp());
}

class WadToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: 'Wadvance',
      // テーマカラー
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListPage(),
    );
  }
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  // todo リストデータ受け取り
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todoList[index]),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    todoList.removeAt(index);
                  });
                },
                icon: Icon(Icons.delete),
              ),
              onTap: () async {
                // final updateListText = await Navigator.of(context)
                // .push(MaterialPageRoute(builder: (context) => ToDoUpdatePage(_text),
                // ));
                // 違う書き方をテスト xxx
                final updateListText = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ToDoUpdatePage();
                }));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // リスト追加画面からの値受け取り
        onPressed: () async {
          //push で画面遷移
          final newLIstText = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return ToDoAddPage();
          }));
          if (newLIstText != null) {
            setState(() {
              todoList.add(newLIstText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// リスト追加画面
// class ToDoAddPage extends StatelessWidget { をstatefulに変更する
class ToDoAddPage extends StatefulWidget {
  @override
  _ToDoAddPageState createState() => _ToDoAddPageState();
}

class _ToDoAddPageState extends State<ToDoAddPage> {
  // 入力されたテキストをStringに
  String _text = '';

  //
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 入力されたテキストを表示する
            Text(_text, style: TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            //テキスト入力
            TextField(
              // テキスト入力により、状態変更を検知する
              onChanged: (String value) {
                setState(() {
                  _text = value;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            // リスト追加
            Container(
              // 横幅全体
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                // color: Colors.blue,
                onPressed: () {
                  // Navigator.of(context).pop() の引数から前画面にデータを渡す
                  Navigator.of(context).pop(_text);
                },
                child: Text(
                  'リスト追加',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // 戻る
            Container(
              width: double.infinity,
              // ボタンを押したとき前に戻る
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('リスト追加画面(クリックで戻る)'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ToDoUpdatePage extends StatefulWidget {
  const ToDoUpdatePage({Key? key}) : super(key: key);

  @override
  State<ToDoUpdatePage> createState() => _ToDoUpdatePageState();
}

class _ToDoUpdatePageState extends State<ToDoUpdatePage> {
  String _text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('ToDo更新'),
    ),
    body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 入力されたテキストを表示する
            Text(_text, style: TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            //テキスト入力
            TextField(
              // テキスト入力により、状態変更を検知する
              onChanged: (String value) {
                setState(() {
                  _text = value;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            // リスト追加
            Container(
              // 横幅全体
              width: double.infinity,
              // 中身変更ボタン
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pop() の引数から前画面にデータを渡す
                  Navigator.of(context).pop(_text);
                },
                child: Text(
                  '中身変更',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // 戻る
            Container(
              width: double.infinity,
              // ボタンを押したとき前に戻る
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('リスト追加画面(クリックで戻る)'),
              ),
            )
          ],
        )
      )
    );
  }
}
