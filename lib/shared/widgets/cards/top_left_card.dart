import 'package:cupon_take/models/enums/http_codes.dart';
import 'package:cupon_take/providers/providers.dart';
import 'package:cupon_take/services/points_services.dart';
import 'package:cupon_take/shared/widgets/cards/cards_base.dart';
import 'package:cupon_take/shared/widgets/dynamic_ex_fab.dart';
import 'package:cupon_take/shared/widgets/no_account_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopLeftCard extends CardBase {
  TopLeftCard({super.key, required super.cardTitle});

  @override
  Widget? headerActions(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.light_mode))
      ],
    );
  }

  Future<bool> _requestPoints(String authKey) async {
    PointsServices pointsServices = PointsServices();
    final response = await pointsServices.requestPoints(authKey);

    return response.statusCode == HttpCodes.SUCCESS.code;
  }

  @override
  Widget virtualBuild(BuildContext context, WidgetRef ref) {
    final authKey = ref.read(userAuthProvider);
    final userInfo = ref.watch(fetchUserInfoProvider);
    final isLoading = useState(false);

    return userInfo.maybeWhen(
      data: (info) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: 0,
              child: Chip(
                  avatar: const Icon(Icons.attach_money_rounded),
                  label: Text(info.points.toString()))),
          Expanded(
            flex: 1,
            child: Center(
                child: DynamicExFab(
                    icon: Icons.add_rounded,
                    label: const Text("Adicionar pontos"),
                    enabled: !isLoading.value,
                    onPressed: () async {
                      isLoading.value = true;
                      bool success = await _requestPoints(authKey!);
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Pontos regatados com sucesso")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Não foi possivel resgatar os pontos")));
                      }
                      isLoading.value = false;
                    })),
          ),
        ],
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      orElse: () => const Center(child: NoAccountMessage()),
    );
  }
}
