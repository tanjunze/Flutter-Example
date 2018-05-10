// import 'dart:async';
// new Future.delayed(const Duration(seconds: 3), () {
//   if (_pageController != null&&!LoopImage.isLoopPause) {
//     _pageController.nextPage(
//         duration: const Duration(milliseconds: 350),
//         curve: Curves.decelerate);
//   }
//   handleLoop();
// });

// physics: physics, https://juejin.im/entry/5a9aaaf8f265da239b40e2c5
// physics: const PageScrollPhysics(
// parent: const BouncingScrollPhysics()),



// new CustomScrollView(
//   slivers: <Widget>[
//     const SliverAppBar(
//       pinned: true,
//       expandedHeight: 250.0,
//       flexibleSpace: const FlexibleSpaceBar(
//         title: const Text('Demo'),
//       ),
//     ),
//     new SliverGrid(
//       gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 200.0,
//         mainAxisSpacing: 10.0,
//         crossAxisSpacing: 10.0,
//         childAspectRatio: 4.0,
//       ),
//       delegate: new SliverChildBuilderDelegate(
//         (BuildContext context, int index) {
//           return new Container(
//             alignment: Alignment.center,
//             color: Colors.teal[100 * (index % 9)],
//             child: new Text('grid item $index'),
//           );
//         },
//         childCount: 20,
//       ),
//     ),
//     new SliverFixedExtentList(
//       itemExtent: 50.0,
//       delegate: new SliverChildBuilderDelegate(
//         (BuildContext context, int index) {
//           return new Container(
//             alignment: Alignment.center,
//             color: Colors.lightBlue[100 * (index % 9)],
//             child: new Text('list item $index'),
//           );
//         },
//       ),
//     ),
//   ],
// )

// FutureBuilder

// new Center(
//           child: new FutureBuilder<List<MoiveGroup>>(
//             future: requestData(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return new ListView.builder(
//                   itemCount: groups.length,
//                   itemBuilder: _buildGroup,
//                 );
//               } else if (snapshot.hasError) {
//                 return new Text("${snapshot.error}");
//               }
//               // By default, show a loading spinner
//               return new CircularProgressIndicator();
//             },
//           ),
//         )



// FutureBodyView<List<MoiveGroup>>(
//         bodyBuilder: (datas) {
//           groups = datas;
//           return ListView.builder(
//             itemCount: datas.length,
//             itemBuilder: (context, index) {
//               return _buildGroup(context, index);
//             },
//           );
//         },
//         future: datasSource,
//         onRetry: () {
//           setState(() {
//             datasSource = DataManager().dataRepository.getRecommendMoive();
//           });
//         },
//       )