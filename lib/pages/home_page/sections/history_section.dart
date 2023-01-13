import 'package:cupon_take/shared/widgets/cupon_history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HistorySection extends HookWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilterSegmentState = useState(<String>{});

    return Scaffold(
      appBar: AppBar(
        title: Text("Histórico"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SegmentedButton(
                    segments: const [
                      ButtonSegment(label: Text("Otem"), value: "Ontem"),
                      ButtonSegment(label: Text("Hoje"), value: "Hoje"),
                      ButtonSegment(label: Text("Amanhã"), value: "Amanhã")
                    ],
                    selected: selectedFilterSegmentState.value,
                    onSelectionChanged: (newValue) {
                      selectedFilterSegmentState.value = newValue;
                    },
                    emptySelectionAllowed: true,
                  )
                ],
              )),
          Expanded(
            flex: 7,
            child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: CuponHistoryList(List.empty())),
          )
        ],
      ),
    );
  }
}
