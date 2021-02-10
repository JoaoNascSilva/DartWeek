// Ensure that the build script itself is not opted in to null safety,
// instead of taking the language version from the current package.
//
// @dart=2.9
//
// ignore_for_file: directives_ordering

import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:injectable_generator/builder.dart' as _i2;
import 'package:json_serializable/builder.dart' as _i3;
import 'package:shelf_router_generator/builder.dart' as _i4;
import 'package:source_gen/builder.dart' as _i5;
import 'dart:isolate' as _i6;
import 'package:build_runner/build_runner.dart' as _i7;
import 'dart:io' as _i8;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(r'injectable_generator:injectable_builder', [_i2.injectableBuilder],
      _i1.toDependentsOf(r'injectable_generator'),
      hideOutput: true),
  _i1.apply(
      r'injectable_generator:injectable_config_builder',
      [_i2.injectableConfigBuilder],
      _i1.toDependentsOf(r'injectable_generator'),
      hideOutput: false),
  _i1.apply(r'json_serializable:json_serializable', [_i3.jsonSerializable],
      _i1.toDependentsOf(r'json_serializable'),
      hideOutput: true,
      appliesBuilders: const [r'source_gen:combining_builder']),
  _i1.apply(r'shelf_router_generator:shelf_router', [_i4.shelfRouter],
      _i1.toDependentsOf(r'shelf_router_generator'),
      hideOutput: true,
      appliesBuilders: const [r'source_gen:combining_builder']),
  _i1.apply(r'source_gen:combining_builder', [_i5.combiningBuilder],
      _i1.toNoneByDefault(),
      hideOutput: false, appliesBuilders: const [r'source_gen:part_cleanup']),
  _i1.applyPostProcess(r'source_gen:part_cleanup', _i5.partCleanup)
];
void main(List<String> args, [_i6.SendPort sendPort]) async {
  var result = await _i7.run(args, _builders);
  sendPort?.send(result);
  _i8.exitCode = result;
}
