class Lens {
  const Lens(
      {required this.prism,
      required this.pupillaryDistance,
      required this.rightSphere,
      required this.rightCylinder,
      this.rightAxis,
      required this.leftSphere,
      required this.leftCylinder,
      
      this.leftAxis
      
      
      });

  final double rightSphere;
  final double rightCylinder;
  final double? rightAxis;
  final double leftSphere;
  final double leftCylinder;
  final double? leftAxis;
  final String prism;
  final String pupillaryDistance;

  Map<String, dynamic> toJson() => {
        'rightSphere': rightSphere,
        'rightCylinder': rightCylinder,
        'rightAxis': rightAxis,
        'leftSphere': leftSphere,
        'leftCylinder': leftCylinder,
        'leftAxis': leftAxis,
        'prism': prism,
        'pupillaryDistance': pupillaryDistance
      };

  factory Lens.fromJson(Map<String, dynamic> json) {
    return Lens(
      prism: json['prism'] as String,
      pupillaryDistance: json['pupillaryDistance'] as String,
      rightSphere: (json['rightSphere'] as num).toDouble(),
      rightCylinder: (json['rightCylinder'] as num).toDouble(),
      rightAxis: json['rightAxis'] != null
          ? (json['rightAxis'] as num).toDouble()
          : null,
      leftSphere: (json['leftSphere'] as num).toDouble(),
      leftCylinder: (json['leftCylinder'] as num).toDouble(),
      leftAxis: json['leftAxis'] != null
          ? (json['leftAxis'] as num).toDouble()
          : null,
    );
  }
}
