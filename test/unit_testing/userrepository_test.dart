import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_database_mocks/firebase_database_mocks.dart';

class UserRepository {
  UserRepository(this.firebaseDatabase);
  FirebaseDatabase firebaseDatabase;

  Future<String?> getFieldFromDocument(String collectionName, String documentId, String fieldName) async {
    final userNameReference = firebaseDatabase.reference().child(collectionName).child(documentId).child(fieldName);
    final dataSnapshot = await userNameReference.once();
    final value = dataSnapshot.snapshot.value;
    if (value is String) {
      return value;
    }
    return null;
  }
}

void main() {
  FirebaseDatabase firebaseDatabase;
  late UserRepository userRepository;
  const userId = 'userId';
  const name = 'Muhammad Shaheer Uddin';
  const fakeData = {
    'users': {
      userId: {
        'name': name,
      },
    },
  };

  setUp(() {
    MockFirebaseDatabase.instance.reference().set(fakeData);
    firebaseDatabase = MockFirebaseDatabase.instance;
    userRepository = UserRepository(firebaseDatabase);
  });

  group('User Repository -', () {
    group('get field from document function', () {
      test('given user repository class when getFieldFromDocument function is called then a field should be returned',
              () async {
            // Arrange
            const userId = 'userId';
            const field = 'name';

            // Act
            final fieldFromDocument = await userRepository.getFieldFromDocument(
                'users', userId, field);

            // Assert
            expect(fieldFromDocument, equals(name));
          });
    });
  });
}
