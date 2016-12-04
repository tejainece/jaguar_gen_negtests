library test.negative.interceptor.no_pre_post;

import 'package:test/test.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar/testing.dart';

part 'param.g.dart';

class NoPrePost extends Interceptor {
  const NoPrePost();
}

@Api(path: '/api')
class NoPrePostApi extends Object with _$JaguarNoPrePostApi {
  @Get()
  @NoPrePost()
  String getUser() => 'no pre post!';
}

void main() {
  group('Interceptor.Param', () {
    JaguarMock mock;
    setUp(() {
      Configuration config = new Configuration();
      config.addApi(new NoPrePostApi());
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