// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:coupon_take/models/enums/http_codes.dart';
import 'package:coupon_take/models/redeem_history_http_request.dart';
import 'package:coupon_take/providers/providers.dart';
import 'package:coupon_take/services/coupon_services.dart';
import 'package:coupon_take/shared/responsive_breakpoints_name.dart';
import 'package:coupon_take/shared/widgets/cards/cards_base.dart';
import 'package:coupon_take/shared/widgets/dynamic_ex_fab.dart';
import 'package:coupon_take/shared/widgets/last_redeem_info_card.dart';
import 'package:coupon_take/shared/widgets/no_account_message.dart';
import 'package:coupon_take/shared/widgets/user_info_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomLeftCard extends CardBase {
  BottomLeftCard({super.key, required super.cardTitle});

  @override
  Widget? headerActions(BuildContext context) {
    return Row(children: [
      IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!
                          .alertDialogRedeemInfoTitle),
                      content: Text(AppLocalizations.of(context)!
                          .alertDialogRedeemInfoContent),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                                AppLocalizations.of(context)!.continueText))
                      ],
                    ));
          },
          icon: const Icon(Icons.info_outline_rounded))
    ]);
  }

  Future<String?> _redeemCoupon(String authKey) async {
    CouponServices couponServices = CouponServices();
    final response = await couponServices.redeemCoupon(authKey);
    if (response.statusCode != HttpCodes.SUCCESS.code) return null;

    return response.body as String;
  }

  @override
  Widget virtualBuild(BuildContext context, WidgetRef ref) {
    final authKey = ref.read(userAuthProvider);
    final userInfo = ref.watch(fetchUserInfoProvider);

    final isLoadingState = useState(false);
    final lastCouponRedeemState = useState<String?>(null);

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
                            couponCode: lastCouponRedeemState.value),
                      UsernameInfoChip(info),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                      child: DynamicExFab(
                    icon: Icons.api_rounded,
                    label:
                        Text(AppLocalizations.of(context)!.fabRedeemCouponText),
                    enabled: !isLoadingState.value,
                    onPressed: () async {
                      isLoadingState.value = true;
                      String? code = await _redeemCoupon(authKey!);
                      if (code != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .snackBarRedeemCouponSuccessfully)));
                        ref.refresh(fetchUserInfoProvider);
                        ref.refresh(fetchUserRedeemHistoryProvider(
                            const RedeemHistoryHttpRequest(page: 1)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .snackBarRedeemCouponUnsuccessfully)));
                      }
                      lastCouponRedeemState.value = code;
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
