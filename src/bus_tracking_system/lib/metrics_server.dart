import 'dart:io';
import 'package:prometheus_client/prometheus_client.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;

void main() {
  // Create a Prometheus registry
  final registry = CollectorRegistry();

  // Register your metrics with the registry
  registry.register(counterMetric);  // Assuming you've defined and initialized the `counterMetric` in the same file

  // Create a shelf handler to expose metrics
  final handler = prometheusHandler(registry);

  // Create a shelf pipeline
  final pipeline = const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(handler);

  // Start the HTTP server
  io.serve(pipeline, InternetAddress.anyIPv4, 9090).then((server) {
    print('Metrics server running on ${server.address.host}:${server.port}');
  });
}

//dart metrics_server.dart chalio bhai:)
