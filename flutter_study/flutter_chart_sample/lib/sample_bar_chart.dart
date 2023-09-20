import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'model/ordinal_sales.dart';

class SimpleBarChart extends StatefulWidget {
  const SimpleBarChart({super.key});

  @override
  State<SimpleBarChart> createState() => _SimpleBarChartState();
}

class _SimpleBarChartState extends State<SimpleBarChart> {
  List<charts.Series>? seriesList;

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales(year: '2014', sales: 5),
      OrdinalSales(year: '2015', sales: 25),
      OrdinalSales(year: '2016', sales: 100),
      OrdinalSales(year: '2017', sales: 75),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  barChart() {
    return charts.BarChart(
      _createSampleData(),
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 1.0,
      ),
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createSampleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('차트 샘플'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: barChart(),
      ),
    );
  }
}
