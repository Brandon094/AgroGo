import 'package:flutter/material.dart';

class AgroEmptyState extends StatelessWidget {
  final String mensaje;
  final IconData icono;
  final String? subtitulo;
  final VoidCallback? onAccion;
  final String? etiquetaAccion;

  const AgroEmptyState({
    super.key,
    required this.mensaje,
    required this.icono,
    this.subtitulo,
    this.onAccion,
    this.etiquetaAccion,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icono,
                size: 80,
                color: Colors.grey.withValues(alpha: 0.3),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              mensaje,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            if (subtitulo != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitulo!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
            if (onAccion != null && etiquetaAccion != null) ...[
              const SizedBox(height: 32),
              TextButton.icon(
                onPressed: onAccion,
                icon: const Icon(Icons.add_circle_outline),
                label: Text(etiquetaAccion!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
