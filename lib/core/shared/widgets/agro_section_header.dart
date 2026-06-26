import 'package:flutter/material.dart';

class AgroSectionHeader extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final Color? colorIcono;
  final Widget? extra;
  final double paddingBottom;

  const AgroSectionHeader({
    super.key,
    required this.titulo,
    required this.icono,
    this.colorIcono,
    this.extra,
    this.paddingBottom = 32,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorBase = colorIcono ?? theme.primaryColor;

    return Container(
      padding: EdgeInsets.fromLTRB(24, 70, 24, paddingBottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titulo,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorBase.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icono, color: colorBase, size: 28),
              ),
            ],
          ),
          if (extra != null) ...[
            const SizedBox(height: 20),
            extra!,
          ],
        ],
      ),
    );
  }
}
