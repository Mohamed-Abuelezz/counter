import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyLoadingList extends StatelessWidget {
  Axis axis;
  bool isGrid;
  MyLoadingList({super.key, required this.axis, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: axis == Axis.vertical
            ? isGrid
                ? GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    itemCount: 16,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.0,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 230,
                    ),
                    itemBuilder: (ctx, i) {
                      return Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1)),
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            // Container(
                            //   width: 100,
                            //   height: 100,
                            //   margin: EdgeInsets.symmetric(horizontal: 5),
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 20, vertical: 5),
                            //   decoration: BoxDecoration(
                            //       color: Theme.of(context).primaryColor,
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(20))),
                            // ),
                            Expanded(
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      height: 60,
                      margin: EdgeInsets.all(5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    Container(
                      width: 150,
                      height: 60,
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    Container(
                      width: 150,
                      height: 60,
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    Container(
                      width: 150,
                      height: 60,
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    Container(
                      width: 150,
                      height: 60,
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    Container(
                      width: 150,
                      height: 60,
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ],
                ),
              ));
  }
}
