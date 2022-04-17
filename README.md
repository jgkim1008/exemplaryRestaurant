# 🥘 exemplaryRestaurant 1.0 V

**프로젝트 기간: 2022년 3월 31일 ~ 진행중**

&nbsp; 


## 프로젝트 설명
서울시에서 인증 및 지정 받은 업소를 보여주는 어플리케이션 입니다.<br>
추후 2.0V 업그레이드를 통하여 Navigation 기능 추가 및 DetailViewController를 좀더 보안할 예정입니다.
&nbsp;  
&nbsp; 

## 목차
+ [실행 화면](#실행-화면)
+ [주요 구현 사항](#주요-구현-사항)
    1. [MVVM-C 패턴 적용](#1-mvvm-c-패턴-적용)
    2. [10 - 200룰 적용](#2-10-200룰-적용)


&nbsp;

## 실행 화면
|상황|실행화면|
|:--:|:--:|
|1.0V|<img width=300 src="https://user-images.githubusercontent.com/52707151/163712953-6bdd2839-b094-40e1-aa5b-8d46d9c4e325.gif">|



&nbsp;
# 주요 구현 사항

+ `MVVM-C 패턴 적용` 적용
  + `MainCoordinator - start()` MapView 생성
  + `MainCoordinator - pushDetailVC()` 을 통해 `DetailViewCoordinator`를 생성
  + `DetailViewCoordinator - start()` 를 통해 AnnotaionView을 터치시 보여줄 `DetailViewController` 생성
&nbsp;

+ `Service Layer`들은 `의존성 주입`을 통하여 손쉽게 갈아낄수 있고 테스트 가능하도록 구현
  + 데이터 요청은 `viewModel`은 init시 에서 서버로부터 1000개 단위로 가져옴.
      + 가져온 데이터는 파싱 처리를 거침
      + `ViewModel`과 `View`을 바인딩할 떄 `Rx`을 이용했습니다.
  + `LocationManager`를 권한 요청 및 현재위치 가져오기

&nbsp;

## 1. MVVM-C 패턴 적용 

+ `Coordinator` 에서 화면 전환 및, `ViewController & ViewModel`을 생성하므로 `ViewController`가 `SRP`을 준수할수 있도록 하였습니다.
+ `MVVM-C` 패턴의 장점중 하나인 의존성 주입을 통한 `ViewModel`을 손쉽게 교체 및 `UI와 별개된 테스트`가 가능합니다.
&nbsp;


## 2. 10-200룰 적용
+ 제가 생각하는 코드의 중요한점인 `SRP`을 지키기 위해 `MVVM-C` 패턴 적용 및 `10 - 200룰` 을 적용하였습니다.

&nbsp;
    
