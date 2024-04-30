import 'package:flutter_education_app/core/error/exception.dart';
import 'package:flutter_education_app/src/on_boarding/data/datasource/on_boarding_local_datasrc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences preferences;
  late OnBoardingLocalDataSrc localDataSrc;

  setUpAll(() {
    preferences = MockSharedPreferences();
    localDataSrc = OnBoardingLocalDataSrcImpl(preferences);
  });

  group('cacheFirstTimer', () {
    test('should call [Shared Preferences] to cache the data', () async {
      when(() => preferences.setBool(any(), any()))
          .thenAnswer((_) async => true);

      await localDataSrc.cacheFirstTimer();

      verify(() => preferences.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(preferences);
    });

    test('should throw [CacheException] when there is error in caching data',
        () async {
      when(() => preferences.setBool(any(), any())).thenThrow(
        Exception(),
      );
      final methodCall = localDataSrc.cacheFirstTimer();

      expect(
        methodCall,
        throwsA(isA<CacheException>()),
      );
      verify(() => preferences.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(preferences);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test(
        'should call [shared prefrences] to check if user is a first timer  '
        'return the right response from storage when data exists', () async {
      when(
        () => preferences.getBool(any()),
      ).thenAnswer((_) => false);

      final result = await localDataSrc.checkIfUserIsFirstTimer();

      expect(result, false);

      verify(() => preferences.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(preferences);
    });

    test('should return true if there is no data storage', () async {
      when(() => preferences.getBool(any())).thenAnswer((_) => null);

      final result = await localDataSrc.checkIfUserIsFirstTimer();
      expect(result, true);

      verify(() => preferences.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(preferences);
    });

    test(
        'should return an [CacheException] where there is an error '
        'to reterving a data', () async {
      when(() => preferences.getBool(any())).thenThrow(Exception());

      final methodCall = localDataSrc.checkIfUserIsFirstTimer();

      expect(methodCall, throwsA(isA<CacheException>()));

      verify(() => preferences.getBool(kFirstTimerKey)).called(1);
      verifyNoMoreInteractions(preferences);
    });
  });
}
