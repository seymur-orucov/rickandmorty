import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/error/exception.dart';
import '../models/person_model.dart';

abstract class PersonRemoteDataSource {
  // Calls the https://rickandmortyapi.com/api/character/?page=1 endpoint.
  //
  // Throws a [ServerException] for all error codes.
  Future<List<PersonModel>> getAllPersons(int page);

  // Calls the https://rickandmortyapi.com/api/character/?name=rick endpoint.
  //
  // Throws a [ServerException] for all error codes.
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourceImpl extends PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl(this.client);

  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['result'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
