library test.negative.interceptor.no_pre_post;

import 'dart:async';
import 'dart:io';
import 'package:test/test.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar/testing.dart';

part 'wrong_input_interceptor_type.g.dart';

class SomeOtherInterceptor extends Interceptor {
  const SomeOtherInterceptor();

  DateTime pre() => new DateTime.now();
}

class SomeInterceptor extends Interceptor {
  const SomeInterceptor();

  @Input(SomeOtherInterceptor)
  String post(String date) => 'SomeInterceptor';
}

@Api(path: '/api')
class WrongInputInterceptorTypeApi extends Object
    with _$JaguarWrongInputInterceptorTypeApi {
  @Get()
  @SomeOtherInterceptor()
  @SomeInterceptor()
  String getUser() => 'no pre post!';
}

void main() {
  group('Interceptor.Param', () {
    JaguarMock mock;
    setUp(() {
      Configuration config = new Configuration();
      config.addApi(new WrongInputInterceptorTypeApi());
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
