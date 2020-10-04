import 'package:basic_calculator/calculation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/calculation_bloc.dart';
import 'calculator_button.dart';
import 'result_display.dart';

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  double width;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<CalculationBloc, CalculationState>(
          builder: (context, CalculationState state) {
            return ResultDisplay(
              text: _getDisplayText(state.calculationModel),
            );
          },
        ),
        Row(
          children: [
            _getButton(text: '7', onTap: () => numberPressed(7)),
            _getButton(text: '8', onTap: () => numberPressed(8)),
            _getButton(text: '9', onTap: () => numberPressed(9)),
            _getButton(text: 'x', onTap: () => operatorPressed('*'), backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
        Row(
          children: [
            _getButton(text: '4', onTap: () => numberPressed(4)),
            _getButton(text: '5', onTap: () => numberPressed(5)),
            _getButton(text: '6', onTap: () => numberPressed(6)),
            _getButton(text: '/', onTap: () => operatorPressed('/'), backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
        Row(
          children: [
            _getButton(text: '1', onTap: () => numberPressed(1)),
            _getButton(text: '2', onTap: () => numberPressed(2)),
            _getButton(text: '3', onTap: () => numberPressed(3)),
            _getButton(text: '+', onTap: () => operatorPressed('+'), backgroundColor: Color.fromRGBO(220, 220, 220, 1))
          ],
        ),
        Row(
          children: [
            _getButton(text: '=', onTap: calculateResult, backgroundColor: Colors.orange, textColor: Colors.white),
            _getButton(text: '0', onTap: () => numberPressed(0)),
            _getButton(text: 'C', onTap: clear, backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
            _getButton(text: '-', onTap: () => operatorPressed('-'),backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
      ]
    );
  }


  Widget _getButton({String text, Function onTap, Color backgroundColor = Colors.white, Color textColor = Colors.black}) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      size: width / 4 - 12,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

  numberPressed(int number) {
    context.bloc<CalculationBloc>().add(NumberPressed(number: number));
  }

  operatorPressed(String operator) {
    context.bloc<CalculationBloc>().add(OperatorPressed(operator: operator));
  }

  calculateResult() {
    context.bloc<CalculationBloc>().add(CalculateResult());
  }

  clear() {
    context.bloc<CalculationBloc>().add(ClearCalculation());
  }

  String _getDisplayText(CalculationModel model) {
    if (model.result != null) {
      return '${model.result}';
    }

    if (model.secondOperand != null) {
      return '${model.firstOperand}${model.operator}${model.secondOperand}';
    }

    if (model.operator != null) {
      return '${model.firstOperand}${model.operator}';
    }

    if (model.firstOperand != null) {
      return '${model.firstOperand}';
    }

    return "${model.result}";
  }
}