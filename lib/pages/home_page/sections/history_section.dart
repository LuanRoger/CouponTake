import 'package:coupon_take/shared/widgets/controllers/coupon_history_list_controller.dart';
import 'package:coupon_take/shared/widgets/coupon_history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HistorySection extends HookWidget {
  late final CouponHistoryListController controller;

  HistorySection({super.key}) {
    controller = CouponHistoryListController();
  }

  @override
  Widget build(BuildContext context) {
    final selectedFilterSegmentState = useState(<String>{});
    final currentPageState = useState(controller.page);
    useEffect(() {
      controller.onReset = () => currentPageState.value = controller.page;
      return () => controller.onReset = null;
    }, [currentPageState]);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        controller.previousPage();
                        currentPageState.value = controller.page;
                      },
                      icon: const Icon(Icons.navigate_before_rounded)),
                  SegmentedButton(
                    segments: const [
                      ButtonSegment(label: Text("Otem"), value: "Ontem"),
                      ButtonSegment(label: Text("Hoje"), value: "Hoje")
                    ],
                    selected: selectedFilterSegmentState.value,
                    onSelectionChanged: (newValue) {
                      selectedFilterSegmentState.value = newValue;
                    },
                    emptySelectionAllowed: true,
                  ),
                  IconButton(
                      onPressed: () {
                        controller.nextPage();
                        currentPageState.value = controller.page;
                      },
                      icon: const Icon(Icons.navigate_next_rounded))
                ],
              )),
          Expanded(
            flex: 7,
            child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 0,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Página: ${controller.page}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceTint),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CouponHistoryList(
                            controller: controller,
                          ),
                        ),
                      ],
                    ))),
          )
        ],
      ),
    );
  }
}
