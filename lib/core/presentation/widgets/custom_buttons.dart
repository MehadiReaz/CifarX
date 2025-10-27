import 'package:flutter/material.dart';

class CustomButtons {
  const CustomButtons._();

  static Widget primary({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    double? width,
    EdgeInsetsGeometry? padding,
  }) {
    return _BaseButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      width: width,
      padding: padding,
      style: ButtonStyle.primary,
    );
  }

  static Widget secondary({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    double? width,
    EdgeInsetsGeometry? padding,
  }) {
    return _BaseButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      width: width,
      padding: padding,
      style: ButtonStyle.secondary,
    );
  }

  static Widget outline({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    double? width,
    EdgeInsetsGeometry? padding,
  }) {
    return _BaseButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      width: width,
      padding: padding,
      style: ButtonStyle.outline,
    );
  }

  static Widget text({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    double? width,
    EdgeInsetsGeometry? padding,
  }) {
    return _BaseButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      width: width,
      padding: padding,
      style: ButtonStyle.text,
    );
  }
}

enum ButtonStyle { primary, secondary, outline, text }

class _BaseButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle style;

  const _BaseButton({
    required this.text,
    required this.onPressed,
    required this.style,
    this.isLoading = false,
    this.icon,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getTextColor(context),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          Icon(icon, size: 16),
          const SizedBox(width: 8),
        ],
        Text(text),
      ],
    );

    if (width != null) {
      child = SizedBox(width: width, child: child);
    }

    switch (style) {
      case ButtonStyle.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: child,
        );

      case ButtonStyle.secondary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.secondary,
            foregroundColor: theme.colorScheme.onSecondary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: child,
        );

      case ButtonStyle.outline:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
            side: BorderSide(color: theme.colorScheme.primary),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: child,
        );

      case ButtonStyle.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: child,
        );
    }
  }

  Color _getTextColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (style) {
      case ButtonStyle.primary:
        return theme.colorScheme.onPrimary;
      case ButtonStyle.secondary:
        return theme.colorScheme.onSecondary;
      case ButtonStyle.outline:
      case ButtonStyle.text:
        return theme.colorScheme.primary;
    }
  }
}
