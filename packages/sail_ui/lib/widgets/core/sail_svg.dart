import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sail_ui/style/style.dart';
import 'package:sail_ui/theme/theme.dart';

enum SailSVGAsset {
  iconDashboardTab,
  iconWithdrawalBundleTab,
  iconBMMTab,

  iconMainchain,
  iconSidechain,
  iconSettings,

  iconCalendar,
  iconQuestion,
  iconSearch,
  iconCopy,
  iconRestart,
  iconArrow,
  iconArrowForward,
  iconClose,
  iconGlobe,
  iconExpand,

  iconSuccess,
  iconPending,
  iconPendingHalf,
  iconFailed,
  iconInfo,
  iconSelected,
}

/// If you don't want to overwrite the color of the svg, put it in here!
// useful for svgs that already have a color like red or blue, that are
// not supposed to be the same color of the text, or ones that have
// multiple colors
const coloredAssets = [
  SailSVGAsset.iconMainchain,
  SailSVGAsset.iconSidechain,
  SailSVGAsset.iconSuccess,
  SailSVGAsset.iconPending,
  SailSVGAsset.iconPendingHalf,
  SailSVGAsset.iconFailed,
  SailSVGAsset.iconInfo,
];

class SailSVG {
  static Widget icon(
    SailSVGAsset asset, {
    bool isHighlighted = false,
    double? width,
    double? height,
  }) {
    return Builder(
      builder: (context) {
        final colors = SailTheme.of(context).colors;

        return SailSVG.fromAsset(
          asset,
          color: coloredAssets.contains(asset) ? null : (isHighlighted ? colors.primary : colors.icon),
          width: width ?? SailStyleValues.iconSizePrimary,
          height: height ?? SailStyleValues.iconSizePrimary,
        );
      },
    );
  }

  static SvgPicture fromAsset(
    SailSVGAsset asset, {
    double? height,
    double? width,
    Color? color,
  }) {
    return SvgPicture.asset(
      asset.toAssetPath(),
      package: 'sail_ui',
      width: width,
      color: color,
      height: height,
    );
  }
}

extension AsAssetPath on SailSVGAsset {
  String toAssetPath() {
    switch (this) {
      case SailSVGAsset.iconDashboardTab:
        return 'assets/svgs/icon_dashboard_tab.svg';
      case SailSVGAsset.iconWithdrawalBundleTab:
        return 'assets/svgs/icon_withdrawal_bundle_tab.svg';
      case SailSVGAsset.iconBMMTab:
        return 'assets/svgs/icon_bmm_tab.svg';

      case SailSVGAsset.iconMainchain:
        return 'assets/svgs/icon_mainchain.svg';
      case SailSVGAsset.iconSidechain:
        return 'assets/svgs/icon_sidechain.svg';
      case SailSVGAsset.iconSettings:
        return 'assets/svgs/icon_settings.svg';

      case SailSVGAsset.iconCalendar:
        return 'assets/svgs/icon_calendar.svg';
      case SailSVGAsset.iconQuestion:
        return 'assets/svgs/icon_question.svg';
      case SailSVGAsset.iconSearch:
        return 'assets/svgs/icon_search.svg';
      case SailSVGAsset.iconCopy:
        return 'assets/svgs/icon_copy.svg';
      case SailSVGAsset.iconRestart:
        return 'assets/svgs/icon_restart.svg';
      case SailSVGAsset.iconArrow:
        return 'assets/svgs/icon_arrow_down.svg';
      case SailSVGAsset.iconArrowForward:
        return 'assets/svgs/icon_arrow_forward.svg';
      case SailSVGAsset.iconClose:
        return 'assets/svgs/icon_close.svg';
      case SailSVGAsset.iconGlobe:
        return 'assets/svgs/icon_globe.svg';
      case SailSVGAsset.iconExpand:
        return 'assets/svgs/icon_expand.svg';

      case SailSVGAsset.iconSuccess:
        return 'assets/svgs/icon_success.svg';
      case SailSVGAsset.iconPending:
        return 'assets/svgs/icon_pending.svg';
      case SailSVGAsset.iconPendingHalf:
        return 'assets/svgs/icon_pending_half.svg';
      case SailSVGAsset.iconFailed:
        return 'assets/svgs/icon_failed.svg';
      case SailSVGAsset.iconInfo:
        return 'assets/svgs/icon_info.svg';
      case SailSVGAsset.iconSelected:
        return 'assets/svgs/icon_selected.svg';
    }
  }
}
