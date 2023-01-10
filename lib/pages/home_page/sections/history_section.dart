import 'package:cupon_take/shared/widgets/cupon_history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HistorySection extends HookWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final todayFilterState = useState(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "Histórico",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        const Spacer(),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ChoiceChip(
                    selected: todayFilterState.value,
                    onSelected: (newValue) => todayFilterState.value = newValue,
                    label: Text("Hoje"))
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
    );
  }
}
