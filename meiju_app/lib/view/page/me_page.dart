
import 'package:meiju_app/app_path.dart';

/// 个人中心

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MePageState();
  }
}

class _MePageState extends State<MePage> {
  Future<File> imageFile;
  File file;
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("个人中心"),
        ),
        backgroundColor: pageColor,
        body: new ListView(
          children: <Widget>[_buildHeaderView(context), _buildList(context)],
        ));
  }

  Widget _buildList(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Divider(
          color: pageColor,
        ),
        _buildRow(context, "历史记录"),
        _LineDivider(),
        _buildRow(context, "我的收藏"),
        _LineDivider(),
        _buildRow(
          context,
          "设置",
        ),
        _LineDivider(),
        _buildRow(context, "切换主题", onTap: () {
            AppTheme.setTheme(AppTheme.currentTheme == redTheme ? blueTheme : redTheme);
            
        }),
        _LineDivider(),
        _buildRow(context, "关于我们", onTap: () {
          openWebView(context, aboutMeUrl);
        }),
      ],
    );
  }

  Widget _LineDivider() {
    return new Divider(
      height: 1.0,
      indent: 40.0,
      color: Colors.grey.withAlpha(70),
    );
  }

  Widget _buildRow(BuildContext context, String name,
      {GestureTapCallback onTap}) {
    return new Container(
        height: 50.0,
        color: Colors.white,
        child: new Material(
          child: new InkWell(
            onTap: () {
              if(onTap!=null){
                onTap();
              };
            },
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: new Icon(
                    Icons.settings,
                    color: Colors.red.withAlpha(100),
                  ),
                ),
                new Expanded(
                  child: new Text(name),
                ),
                new Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: new Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black.withAlpha(100),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildHeaderView(BuildContext context) {
    return new Container(
      height: 120.0,
      width: double.infinity,
      color: Colors.red,
      child: new Material(
        child: new Row(
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new InkWell(
                  onTap: () {
                    showBottomDialog(context, (Future<File> file) {
                      setState(() {
                        imageFile = file;
                      });
                    });
                  },
                  child: new ClipRRect(
                    borderRadius: new BorderRadius.circular(99.0),
                    child: new FutureBuilder<File>(
                      future: imageFile,
                      builder:
                          (BuildContext context, AsyncSnapshot<File> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null) {
                          file = snapshot.data;
                          return new Image.file(
                            file,
                            width: 70.0,
                            height: 70.0,
                            fit: BoxFit.cover,
                          );
                        } else {
                          if (file != null) {
                            return new Image.file(
                              file,
                              width: 70.0,
                              height: 70.0,
                              fit: BoxFit.cover,
                            );
                          }
                          return new Image.asset(
                            "assets/images/lake.jpg",
                            width: 70.0,
                            height: 70.0,
                            fit: BoxFit.cover,
                          );
                        }
                      },
                    ),
                  ),
                )),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "tanjz",
                  style: new TextStyle(
                      color: const Color(0xFF333333), fontSize: 17.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: new Text(
                    "微信登录",
                    style: new TextStyle(
                        color: const Color(0xFF666666), fontSize: 13.0),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
