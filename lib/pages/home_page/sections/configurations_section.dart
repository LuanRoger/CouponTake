import 'package:coupon_take/models/enums/app_brightness.dart';
import 'package:coupon_take/providers/providers.dart';
import 'package:coupon_take/shared/app_theme_data.dart';
import 'package:coupon_take/shared/widgets/bottom_sheet.dart';
import 'package:coupon_take/shared/widgets/color_preview.dart';
import 'package:flutter/material.dart' hide BottomSheet;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfigurationSection extends HookConsumerWidget {
  const ConfigurationSection({super.key});

  void _changeBrightness(bool darkMode, WidgetRef ref) {
    AppBrightness appBrightness =
        darkMode ? AppBrightness.DARK : AppBrightness.LIGHT;

    ref.read(themePreferencesProvider.notifier).changeBrightness(appBrightness);
    ref.read(preferencesProvider).brightness = appBrightness.index;
  }

  void _changeAppColor(int colorIndex, WidgetRef ref) {
    ref.read(themePreferencesProvider.notifier).changeColor(colorIndex);
    ref.read(preferencesProvider).colorIndex = colorIndex;
  }

  void _showColorChanger(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    BottomSheet sheet = BottomSheet(context,
        height: size.height * 0.3,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cores",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Flexible(
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: AppThemeData.appColors.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (_, index) {
                    return ColorPreview(AppThemeData.appColors[index],
                        onPressed: () => _changeAppColor(index, ref));
                  }),
            )
          ],
        ));
    sheet.show();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themePreferences = ref.watch(themePreferencesProvider.notifier);

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text("Configurações"),
        ),
        body: ListView(
          children: [
            Text("Tema",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surfaceTint)),
            ListTile(
              title: Text("Modo escuro"),
              trailing: Switch(
                value: themePreferences.brightness == AppBrightness.DARK,
                onChanged: (newValue) => _changeBrightness(newValue, ref),
              ),
            ),
            ListTile(
              title: Text("Cor primária"),
              onTap: () => _showColorChanger(context, ref),
            )
          ],
        ),
      ),
    );
  }
}
