import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sail_ui/sail_ui.dart';
import 'package:sail_ui/widgets/core/sail_snackbar.dart';
import 'package:sail_ui/widgets/core/sail_text.dart';

class SingleValueContainer extends StatelessWidget {
  final String label;
  final dynamic value;
  final double width;
  final String? trailingText;
  final Widget? icon;
  final bool copyable;

  const SingleValueContainer({
    super.key,
    required this.label,
    required this.value,
    required this.width,
    this.trailingText,
    this.icon,
    this.copyable = true,
  });

  @override
  Widget build(BuildContext context) {
    return SailRow(
      spacing: SailStyleValues.padding08,
      children: [
        if (icon != null)
          icon!
        else
          const SizedBox(
            width: 13,
          ),
        SizedBox(
          width: width,
          child: SailText.secondary12(label),
        ),
        SailScaleButton(
          onPressed: copyable
              ? () {
                  Clipboard.setData(ClipboardData(text: value.toString()));
                  showSnackBar(context, 'Copied $label');
                }
              : null,
          child: SailText.primary12(value.toString()),
        ),
        Expanded(child: Container()),
        if (trailingText != null) SailText.secondary12(trailingText!),
      ],
    );
  }
}