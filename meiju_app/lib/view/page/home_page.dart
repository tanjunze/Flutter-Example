import 'package:flutter/material.dart';
import 'package:meiju_app/data/bean/moive.dart';
import 'home/horizontal_sroll_view.dart';
import 'package:meiju_app/view/component/roll_image.dart';
import 'package:meiju_app/view/component/roll_text.dart';
import 'package:meiju_app/view/page/home/recent_updates_list.dart';
import 'package:meiju_app/util/global.dart';
import 'package:meiju_app/view/page/routes.dart';
import 'package:meiju_app/presenter/home_presenter.dart';
import 'package:meiju_app/view/component/load_state_view.dart';

// 首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePage();
  }
}

class _HomePage extends State<HomePage> implements HomeContract {
  HomePresenter _presenter;
  List<MoiveGroup> _datas;
  LoadStateController _loadController;
  @override
  void initState() {
    super.initState();
    _loadController = LoadStateController();
    _presenter = new HomePresenter(this);
    _presenter.loadDatas();
  }

  @override
  void onLoadComplete(List<MoiveGroup> items) {
    setState(() {
      _datas = items;
      _loadController.state = LoadState.Success;
    });
  }

  @override
  void onLoadError() {
    setState(() {
      _loadController.state = LoadState.Fail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("美剧"),
      ),
      backgroundColor: pageColor,
      body: LoadStateView(
        controller: _loadController,
        child: _buildListView(),
        onRetry: () {
          setState(() {
            _presenter.loadDatas();
          });
        },
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _datas?.length,
      itemBuilder: (context, index) {
        return _buildListItem(context, index, _datas[index]);
      },
    );
  }

  Widget _buildListItem(
      BuildContext context, int index, MoiveGroup moiveGroup) {
    switch (index) {
      case 0: //广告弹窗
        return RollImage(
          onTap: () {
            openPage(context, moiveDetailRoute);
          },
          images: moiveGroup.moives,
        );
      case 1: // 消息栏
        return RollText(
          texts: moiveGroup.moives,
          title: moiveGroup.title,
          onTap: () {
            showBottomList(context, moiveGroup.moives);
          },
        );
      default: // 分类item
        return new HomeHorizontalScroll(
            moiveGroup: moiveGroup, type: HomeHorizontalScrollType.other);
    }
  }
}
