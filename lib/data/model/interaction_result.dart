// ignore_for_file: public_member_api_docs, sort_constructors_first
class InteractionResult {
  final String message;
  final bool success;
  final List<int> medicamentsIds;

  const InteractionResult({
    required this.message,
    required this.success,
    required this.medicamentsIds,
  });

  InteractionResult copyWith({
    String? message,
    bool? success,
    List<int>? medicaments,
  }) {
    return InteractionResult(
      message: message ?? this.message,
      success: success ?? this.success,
      medicamentsIds: medicaments ?? this.medicamentsIds,
    );
  }
}
