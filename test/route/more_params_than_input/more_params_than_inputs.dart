library test.negative.route.more_params_than_inputs;

import 'package:test/test.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar/testing.dart';

part 'more_params_than_inputs.g.dart';

@Api(path: '/api')
class MoreParamsThanInputsApi extends Object with _$JaguarMoreParamsThanInputsApi {
  @Get()
  @InputCookie('id')
  String getUser(String id) => 'no pre post!';
}

void main() {
  group('Interceptor.Param', () {
    JaguarMock mock;
    setUp(() {
      Configuration config = new Configuration();
      config.addApi(new MoreParamsThanInputsApi());
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