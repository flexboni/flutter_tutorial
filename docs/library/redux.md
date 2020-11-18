# Redux

## 목차

* [Redux란 무엇인가?](#redux란-무엇인가) 
* [Redux의 주요 관점](#redux의-주요-관점) 
* [예제](#예제) 
* [참고](#참고) 
  
플러터를 이용해 어플리케이션 개발을 할 때 가장 먼저 생각드는 질문이 있다. **"어플리케이션 State를 어떻게 관리하지?"**.

어플리케이션 State를 관리하는 몇 가지 툴들이 있다:

* Bloc
* Redux
* Mobx
  
  ...

## Redux란 무엇인가?

왜 Redux를 사용할까? 그 이유는 다음과 같은 특성 때문이다:

* Deterministic state resolution enabling deterministic view renders when combined with pure components.
* Transactional state.
* Isolate state management from I/O and side-effects.
* Single source of truth for application state.
* Easily share state between different components.
* Transaction telemetry (auto-logging action objects).
* Time travel debugging.

다른말로, Redux는 code를 조직화 하고 디버깅을 강력하게 한다. 즉, 유지보수에 큰 이점이 있다.

</br>

## Redux의 주요 관점

* Store : 어플리케이션의 상태를 갖고 있는 주요 객체 </br>
(https://redux.js.org/glossary#store)
* Action : 상태 변화의 의도를 대표하는 순수 객체 </br>
(https://redux.js.org/glossary#action)
* Reducer : 다가올 action에 기반한 다음 상태를 계산한 기능 </br>
(https://redux.js.org/glossary#reducer)

![image](https://user-images.githubusercontent.com/29271126/99477554-13442b80-2996-11eb-9b5c-d74265cfea4a.png)

</br>

## 예제

### 초급

* [Counter](https://gitlab.com/brianegan/flutter_redux/tree/master/example)
* [mahmudahsan_example](https://github.com/mahmudahsan/flutter/tree/master/flutter/states_redux)
* [thisisamir98/flutter_redux_example](https://github.com/thisisamir98/flutter_redux_example)

### 중급

* [To Do list](https://github.com/xqwzts/flutter-redux-todo-list)

### 고급

* [inKino App](https://github.com/roughike/inKino)
* [flutter_architecture_samples](https://gitlab.com/brianegan/flutter_architecture_samples/tree/master/example/redux)
* [Weight Tracking](https://github.com/MSzalek-Mobile/weight_tracker/)

</br>

## 참고

* https://medium.com/@thisisamir98/flutter-meets-redux-the-redux-way-of-managing-flutter-applications-state-f60ef693b509
* https://medium.com/level-up-programming/how-to-use-redux-in-flutter-app-6299f69fadee
* https://pub.dev/packages/flutter_redux
* https://github.com/fluttercommunity/redux.dart/blob/master/doc/why.md