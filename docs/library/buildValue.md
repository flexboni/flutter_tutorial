# Build value library

Dart 라이브러리 중 하나인 "Buil value"에 대해서 설명한 포스팅 입니다.

---

## 목차 

* [소개 (Introduction)](#소개-(Introduction))
* [직렬화 문제 (Serialization Problem)](#직렬화-문제-(Serialization-Problem))
    * [JSON 직렬화 (JSON Serialization)](#JSON-직렬화-(JSON-Serialization))
    * [불변성 (Immutability)](#불변성-(Immutability))
    * [객체 비교 (Object Comparison)](#객체-비교-(Object-Comparison))
* [Built Value 라이브러리의 등장 (Emergence of 'Built value' library)](#Built-Value-라이브러리의-등장-(Emergence-of-Built-value-library))
* [정리 (Summary)](#정리-(Summary))
* [참조 (Reference)](#참조-(Reference))

---

</br>

## 소개 (Introduction)

Dart는 몇가지 단점이있다. 'Serialization', 'Immutability', 'object comparison' 에 대한 관련된 내용들 때문이다. 즉, 클래스와 enum은 효율적이지 못하다.

</br>

## 직렬화 문제 (Serialization Problem)

앱 개발에 있어 우리는 데이터 모델 직렬화에 대해 빠르게 직면하게 된다. 아마도 데이터 모델을 JSON Object나 바이트 스트림, 메모리나 데이터베이스에 전달 등을 예로 들 수 있다. 하지만 Dart는 'Serialization & De-serialization'을 기본적으로 제공하지 않는다. 자세한 내용을 살펴보자.

### JSON 직렬화 (JSON Serialization)

모델 클래스 하나를 예를 들어보자.

```
class Divison{
  Divison(){}
  int id;
  String name;
  String description
  String displayName;
}
```

다트에서 이 모델을 직렬화 하기 위해서는 많은 내용의 코드를 작성해야 한다.

처음으로, 모델을 JSON Object로 변환하는 코드를 작성해야 한다.

```
Map<String, dynamic> toJson() =>    {
      'id': id,
      'name':name,
      'description':description,
      'displayName':displayName,
    };
```

그리고 JSON 을 Dart 객체로 변환하는 코드를 작성해야 한다.

```
  Divison.fromJson(Map<String, dynamic> json) 
      : id= json['id'],
        name = json['name'],
        description = json['description'],
        displayName = json['displayName'];
```

얼마나 많은 작업이 필요한가!!! 😥

### 불변성 (Immutability)

객체지향, 실용주의 프로그래밍에서 불변 객체는 생선된 후 상태에 대한 변경이 불가하다. 우리는  데이터 모델이 변경 불가능하여 객체에 대한 모든 변경 사항이 앱 전체에 반영 될 수 있기를 원한다. 예를들어, e-commerce 앱에서 장바구니에 담은 상품이 지속적으로 변경되길 원한다. 불변성은 이러한 모든 지역적인 변경 사항이 항상 동기화 되게 한다. 하지만!! Dart는 이와 같은 불변성을 기본적으로 제공하지 않는다.

### 객체 비교 (Object Comparison)

Dart 객체는 값 유형(Value type)이 아닌 참조 유형(Reference types) 이다. 그래서 객체 비교에 어려움이 있다.

예를 들어보자:

```
var peron1 = new Person(name: "Jane Doe");
var person2 = new User(name: "Jane Doe");

print(person1 == person2);
```

우리는 'person1'과 'person2' 가 같다는 것을 기대하지만, Dart는 두 객체는 다른 것으로 인식하고 같음에에 동의하지 않는다.

</br>

## Built Value 라이브러리의 등장 (Emergence of 'Built value' library)

'Built Value' 라이브러리는 위에서 언급한 문제와 같이 'Serialization', 'Immutability', 'Object Comparison' 등에 대한 지원을 제공한다. 즉, 이 라이브러리를 이용해 원하는 'Value type'들을 만들 수 있다.

* Null에 대한 사전 확인 (pre-condition checks like null checks)
* 해시 값 생성 지원 (support for hash value generation)
* 객체를 String으로 변환 (converting objects to String)
* 복잡한 데이터 직렬화 (complex data Serialization)
* ... +α (and much more!)

</br>

## 정리 (Summary)

## 참조 (Reference)

* https://stacksecrets.com/flutter/introduction-to-built_value-library-in-dart
* https://stacksecrets.com/flutter/how-to-use-built_value-library
* https://medium.com/dartlang/darts-built-value-for-immutable-object-models-83e2497922d4