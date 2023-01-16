import 'package:cupon_take/models/enums/http_codes.dart';
import 'package:cupon_take/models/user_info.dart';
import 'package:cupon_take/providers/providers.dart';
import 'package:cupon_take/services/cupon_services.dart';
import 'package:cupon_take/shared/responsive_breakpoints_name.dart';
import 'package:cupon_take/shared/widgets/cards/cards_base.dart';
import 'package:cupon_take/shared/widgets/dynamic_ex_fab.dart';
import 'package:cupon_take/shared/widgets/last_redeem_info_card.dart';
import 'package:cupon_take/shared/widgets/no_account_message.dart';
import 'package:cupon_take/shared/widgets/user_info_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BottomLeftCard extends CardBase {
  UserInfo userInfo;

  BottomLeftCard(this.userInfo, {super.key, required super.cardTitle});

  @override
  Widget? headerActions(BuildContext context) => null;

  Future<String?> _redeemCupon(String authKey) async {
    CuponServices cuponServices = CuponServices();
    final response = await cuponServices.redeemCupon(authKey);
    if (response.statusCode != HttpCodes.SUCCESS.code) return null;

    return response.body as String;
  }

  @override
  Widget virtualBuild(BuildContext context, WidgetRef ref) {
    final authKey = ref.read(userAuthProvider);
    final userInfo = ref.watch(fetchUserInfoProvider);
    final isLoadingState = useState(false);
    final lastCuponRedeemState = useState<String?>(null);

    return userInfo.maybeWhen(
        data: (info) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (ResponsiveWrapper.of(context).activeBreakpoint.name ==
                          ResponsiveBreakpointsName.desktopBreakpoint)
                        LastRedeemInfoCard(
                            cuponCode: lastCuponRedeemState.value),
                      UsernameInfoChip(info),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                      child: DynamicExFab(
                    icon: Icons.api_rounded,
                    label: const Text("Requisitar código"),
                    enabled: !isLoadingState.value,
                    onPressed: () async {
                      isLoadingState.value = true;
                      String? code = await _redeemCupon(authKey!);
                      if (code != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Código resgatado com sucesso")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Não foi possivel resgatar o código")));
                      }
                      lastCuponRedeemState.value = code;
                      isLoadingState.value = false;
                    },
                  )),
                )
              ],
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        orElse: () => const Center(
              child: NoAccountMessage(),
            ));
  }
}
