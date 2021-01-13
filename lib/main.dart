import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'myPerContainer.dart';
import 'constants.dart';
import 'moneyIcon.dart';

void main() {
  runApp(new MaterialApp(home: BillSpliter()));
}

class BillSpliter extends StatefulWidget {
  @override
  _BillSpliterState createState() => _BillSpliterState();
}

class _BillSpliterState extends State<BillSpliter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(padding: EdgeInsets.only(top: 170.0), children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              mainImage(),
              perPersonContainer(),
              SizedBox(height: 20.0),
              mainContainer(),
            ],
          ),
        ]),
      ),
    );
  }

  Container mainContainer() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, top: 20.0),
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      width: 350,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(color: Colors.grey.shade400, fontSize: 20.0),
            decoration: InputDecoration(
                prefixText: 'Bill Amount',
                prefixIcon: Icon(Icons.attach_money)),
            onChanged: (String value) {
              try {
                billAmount = double.parse(value);
              } catch (e) {
                billAmount = 0.0;
              }
            },
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text(
                'Split',
                style: ktextStyle,
              ),
              SizedBox(width: 170.0),
              SubstractButton(),
              SizedBox(width: 10.0),
              Text('$personcounter', style: knumberssmall),
              SizedBox(width: 10.0),
              AddButton(),
            ],
          ),
          SizedBox(height: 30.0),
          Row(
            children: [
              Text('Tip', style: ktextStyle),
              SizedBox(width: 220.0),
              Text('\$ ${calculateTotalTip(billAmount, personcounter, tipPercentage)}', style: knumberssmall)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(tipPercentage.toString(), style: knumberssmall),
              Text('%', style: knumberssmall)
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Color(0xFF590e87),
              inactiveTrackColor: Color(0xFFded1e6),
              overlayColor: Color(0x29af66cc),
              thumbColor: Color(0xFFdda2f5),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
            ),
            child: Slider(
              value: tipPercentage.toDouble(),
              min: 0,
              max: 100,
              divisions: 10,
              onChanged: (double newValue) {
                setState(() {
                  tipPercentage = newValue.round();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector AddButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (personcounter < 100) {
            personcounter++;
          }
        });
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: Color(0xFFded1e6),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('+', style: kpurpleSmalltext),
          ],
        ),
      ),
    );
  }

  GestureDetector SubstractButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (personcounter > 1 && personcounter < 100) {
            personcounter--;
          }
        });
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: Color(0xFFded1e6),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('-', style: kpurpleSmalltext),
          ],
        ),
      ),
    );
  }

  Container perPersonContainer() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      width: 350,
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xFFded1e6),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Total Per Person',
            style: TextStyle(
              color: Color(0xFF590e87),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '\$ ${calculateTotalTip(billAmount, personcounter, tipPercentage)}',
            style: TextStyle(
              color: Color(0xFF590e87),
              fontSize: 45.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }


  calculateTotalPerPerson(int tipPercentage, double billAmount, int splitBy){
    var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage)) / splitBy;

    return totalPerPerson;


  }
  calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
    double totalTip = 0.0;

    if(billAmount < 0 || billAmount.toString().isEmpty || billAmount == null){

    }else{
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}
