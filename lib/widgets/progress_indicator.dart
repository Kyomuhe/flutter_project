// widgets/progress_indicator.dart
import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  
  const StepProgressIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: List.generate(totalSteps * 2 - 1, (index) {
          // If index is even, it's a circle (step indicator)
          if (index % 2 == 0) {
            final stepIndex = index ~/ 2;
            final isCompleted = stepIndex < currentStep;
            final isCurrent = stepIndex == currentStep;
            
            return Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted || isCurrent ? Colors.blue : Colors.transparent,
                border: Border.all(
                  color: isCompleted || isCurrent ? Colors.blue : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: isCompleted ? 
                Icon(Icons.check, color: Colors.white, size: 16) : 
                (isCurrent ? 
                  Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ) : 
                  null),
            );
          } 
          // If index is odd, it's a connecting line between circles
          else {
            final leftStepIndex = index ~/ 2;
            final isActive = leftStepIndex < currentStep;
            
            return Expanded(
              child: Container(
                height: 2,
                color: isActive ? Colors.blue : Colors.grey[300],
              ),
            );
          }
        }),
      ),
    );
  }
}