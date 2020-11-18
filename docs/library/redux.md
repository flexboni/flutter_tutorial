# Redux

## 목차

* [Redux란 무엇인가?](#redux란-무엇인가) 
* [Redux의 주요 관점](#redux의-주요-관점)
* [Redux Thunk란 무엇인가?]() 
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

## Redux Thunk란 무엇인가?

Redux Thunk는 함수를 action으로 disptach하는데 도움이 되는 redux 미들웨어이다. 내부적으로 하나의 작업을 수행하고 전달 된 action이 함수인지 확인한 다음, 호출하고 store를 전달한다.

## Flutter Redux란 무엇인가?

Flutter Redux는 어플리케이션을 Redux store에 연결 시키는 것을 돕는 라이브러리 이다. 세 가지의 위젯을 갖고 있다. **StoreProvider**, **StireBuilder**, **SotreConnector**. 이 위젯들은 내부적으로 Flutter의 _InheritedWidget_을 사용한다. InheritedWidget을 사용하면 Flutter 위젯 트리를 통해 데이터를 주입 할 수 있으므로 그 아래 트리 내의 모든 위젯이 해당 데이터에 액세스하고 데이터가 변경 될 때마다 스스로를 다시 빌드 할 수 있습니다.

## Fleutter Redux 위젯

* StoreProvider : The base Widget. It will pass the given Redux Store to all descendants that request it.
* StoreBuilder : A descendant Widget that gets the Store from a StoreProvider and passes it to a Widget builder function.
* StoreConnector : A descendant Widget that gets the Store from the nearest StoreProvider ancestor, converts the Store into a ViewModel with the given converter function, and passes the ViewModel to a builder function. Any time the Store emits a change event, the Widget will automatically be rebuilt. No need to manage subscriptions!

## 예제

App source: [example](https://github.com/flexboni/flutter_tutorial/tree/master/examples/library/redux/)

### 초급

* [Counter](https://gitlab.com/brianegan/flutter_redux/tree/master/example)
* [mahmudahsan_example](https://github.com/mahmudahsan/flutter/tree/master/flutter/states_redux)

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