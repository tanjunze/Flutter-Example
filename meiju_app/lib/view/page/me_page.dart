import 'package:meiju_app/app_path.dart';

/// 个人中心

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MePageState();
  }
}

class _MePageState extends State<MePage> {
  Future<File> imageFile;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("个人中心"),
        ),
        backgroundColor: pageColor,
        body: ListView(
          children: <Widget>[_buildHeaderView(context), _buildList(context)],
        ));
  }

  Widget _buildList(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          color: pageColor,
        ),
        _buildRow(context, "历史记录"),
        _lineDivider(),
        _buildRow(context, "我的收藏"),
        _lineDivider(),
        _buildRow(
          context,
          "设置",
        ),
        _lineDivider(),
        _buildRow(context, "切换主题", onTap: () {
          AppTheme.setTheme(
              AppTheme.currentTheme == redTheme ? blueTheme : redTheme);
        }),
        _lineDivider(),
        _buildRow(context, "关于我们", onTap: () {
          openWebView(context, aboutMeUrl);
        }),
      ],
    );
  }

  Widget _lineDivider() {
    return Divider(
      height: 1.0,
      indent: 40.0,
      color: Colors.grey.withAlpha(70),
    );
  }

  Widget _buildRow(BuildContext context, String name,
      {GestureTapCallback onTap}) {
    return Container(
        height: 50.0,
        color: Colors.white,
        child: Material(
          child: InkWell(
            onTap: () {
              if (onTap != null) {
                onTap();
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Icon(
                    Icons.settings,
                    color: Theme.of(context).primaryColor.withAlpha(100),
                  ),
                ),
                Expanded(
                  child: Text(name),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
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
    return SizedBox(
      height: 120.0,
      width: double.infinity,
      child: Material(
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    showPickerPhotoDialog(context, (Future<File> file) {
                      setState(() {
                        imageFile = file;
                      });
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(99.0),
                    child: FutureBuilder<File>(
                      future: imageFile,
                      builder:
                          (BuildContext context, AsyncSnapshot<File> snapshot) {
                        if (snapshot.data != null) {
                          return Image.file(
                            snapshot.data,
                            width: 70.0,
                            height: 70.0,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return Image.asset(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "tanjz",
                  style:
                      TextStyle(color: const Color(0xFF333333), fontSize: 17.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "微信登录",
                    style: TextStyle(
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
