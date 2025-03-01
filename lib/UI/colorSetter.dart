import 'package:flutter/material.dart';


Color getScoreColor(int? score){
  if (score == null) return Colors.grey;

  if (score < 50){
    return const Color(0xFFFF4D4D);
  }
  else if (score < 70){
    return const Color(0xFFFFA500);
  }
  else if (score < 80){
    return const Color(0xFFB4D455);
  }
  else{
    return const Color(0xFF2ECC71);
  }
}