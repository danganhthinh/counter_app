import 'package:counter_app/blocs/counter_bloc.dart';
import 'package:counter_app/events/counter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = context.watch<CounterBloc>();

    // TODO: implement build
    return Scaffold(
      body: SafeArea(child: BlocBuilder<CounterBloc, int>(
        builder: (context, counter) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Two actions/events here: ',
                style: TextStyle(fontSize: 25),
              ),
              Container(
                child: FlatButton(
                    onPressed: () {
                      print('Increment');
                      context.read<CounterBloc>().increment();
                    },
                    child: Text(
                      'Increment',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    )),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.amber),
              ),
              Text(
                'Result : ${counter}',
                style: TextStyle(fontSize: 40, color: Colors.blue),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.redAccent),
                child: FlatButton(
                    onPressed: () {
                      print('Decrement');
                      context.read<CounterBloc>().decrement();
                    },
                    child: Text(
                      'Decrement',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    )),
              )
            ],
          );
        },
      )),
    );
  }
}
