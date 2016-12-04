library test.negative.route.input_of_void_interceptor;

import 'dart:async';
import 'dart:io';
import 'package:test/test.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar/testing.dart';

part 'input_of_void_interceptor.g.dart';

class SomeInterceptor extends Interceptor {
  const SomeInterceptor();

  void pre() => 'SomeInterceptor';
}

@Api(path: '/api')
class InputOfVoidInterceptorApi extends Object
    with _$JaguarInputOfVoidInterceptorApi {
  @Get()
  @SomeInterceptor()
  @Input(SomeInterceptor)
  String getUser(int param) => 'no pre post!';
}

void main() {
  group('Interceptor.Param', () {
    JaguarMock mock;
    setUp(() {
      Configuration config = new Configuration();
      config.addApi(new InputOfVoidInterceptorApi());
      mock = new JaguarMock(config);
    });

    tearDown(() {});

    test('ParamInjection', () async {
      Uri uri = new Uri.http('localhost:8080', '/api/user');
      MockHttpRequest rq = new MockHttpRequest(uri);
      MockHttpResponse response = await mock.handleRequest(rq);

      expect(response.mockContent, 'CheckerImpl');
      expect(response.headers.toMap, {});
      expect(response.statusCode, 200);
    });
  });
}
