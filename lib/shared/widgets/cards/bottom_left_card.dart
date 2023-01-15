import 'package:cupon_take/models/user_info.dart';
import 'package:cupon_take/providers/providers.dart';
import 'package:cupon_take/services/cupon_services.dart';
import 'package:cupon_take/shared/responsive_breakpoints_name.dart';
import 'package:cupon_take/shared/widgets/cards/cards_base.dart';
import 'package:cupon_take/shared/widgets/last_redeem_info_card.dart';
import 'package:cupon_take/shared/widgets/material_card.dart';
import 'package:cupon_take/shared/widgets/no_account_message.dart';
import 'package:cupon_take/shared/widgets/user_info_chip.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BottomLeftCard extends CardBase {
  UserInfo userInfo;

  BottomLeftCard(this.userInfo, {super.key, required super.cardTitle});

  @override
  Widget? headerActions(BuildContext context) => null;

  @override
  Widget virtualBuild(BuildContext context, WidgetRef ref) {
    final authKey = ref.read(userAuthProvider);
    final userInfo = ref.watch(fetchUserInfoProvider);

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
                        const LastRedeemInfoCard(),
                      UsernameInfoChip(info),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: FloatingActionButton.extended(
                      icon: const Icon(Icons.api_rounded),
                      onPressed: () {
                        CuponServices cuponServices = CuponServices();
                        cuponServices.redeemCupon(authKey!);
                      },
                      label: const Text("Requisitar código"),
                    ),
                  ),
                )
              ],
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        orElse: () => const Center(
              child: NoAccountMessage(),
            ));
  }
}
