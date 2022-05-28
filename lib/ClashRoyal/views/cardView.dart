import 'package:api/ClashRoyal/view_models/cards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardView extends StatelessWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardsViewModel cardsViewModel = context.watch<CardsViewModel>();

    return Scaffold(
        appBar: AppBar(
          title: Text("clash Royale"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Container(
          child: cardsViewModel.isError
              ? Text(
                  '${cardsViewModel.errorMessageWithCode["code"]}  ${cardsViewModel.errorMessageWithCode["errorResponse"]}',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                )
              : Column(children: [_ui(cardsViewModel)]),
        ));
  }

  _ui(CardsViewModel cardsViewModel) {
    if (cardsViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Expanded(
        child: ListView.separated(
            itemBuilder: (context, index) {
              var data = cardsViewModel.cardsListModel;

              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: <Widget>[
                    // The former contents of our ListTile:
                    // leading
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: data[index].iconUrls!.medium!.isEmpty
                          ? Text("Loading...")
                          : Image.network(
                              data[index].iconUrls!.medium.toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, exception, stackTrace) {
                                return Text("NO Image");
                              },
                            ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // title
                          const Text("Card Name"),
                          Text(
                            data[index].name.toString(),
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          // subtitle
                        ],
                      ),
                    ),
                    // trailing
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Level"),
                        Text(
                          data[index].maxLevel.toString(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: cardsViewModel.cardsListModel.length));
  }
}
