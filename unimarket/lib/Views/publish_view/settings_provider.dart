import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{

  nameValidator(String value, String message){
    if(value.isEmpty){
      return message;
    } else if(int.tryParse(value) != null){
      return "The name cannot be just a number";
    } else{
      return null;
    }
  }

  priceValidator(String value){
    if(value.isEmpty){
      return "Product price is required";
    } else if(int.parse(value).isNaN){
      return "Only numbers are possible for the product price";
    } else if (int.parse(value)>10000000){
      return "Product price cannot be over 10'000.000";
    } else if (int.parse(value)<1){
      return "Product price cannot be negative nor 0";
    } else {
      return null;
    }
  }

  descriptionValidator(String value){
    if(value.isEmpty){
      return "Product description is required";
    } else if(int.tryParse(value) != null){
      return "The description cannot be just a number";
    } else if (value.length > 120){
      return "The description cannot exceed 100 characters";
    } else {
      return null;
    }
  }
}