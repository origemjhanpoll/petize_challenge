String formatUpdatedAt(String updatedAt) {
  final now = DateTime.now().toUtc();
  final updatedDate = DateTime.parse(updatedAt);
  final difference = now.difference(updatedDate);

  if (difference.inMinutes < 1) {
    return "Atualizado agora";
  } else if (difference.inHours < 1) {
    return "Atualizado há ${difference.inMinutes} minutos";
  } else if (difference.inDays < 1) {
    return "Atualizado há ${difference.inHours} horas";
  } else {
    return "Atualizado há ${difference.inDays} dias";
  }
}
