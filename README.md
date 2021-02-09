# 😄 ERP
ERP란? Enterprise Resource Planning( 전사적 자원관리)의 약어입니다. <br/>
본 프로젝트에서는 회사의 구매, 영업, 회계, 생산, 인적 자원활동 등 비즈니스 프로세스를 통합 관리하는 소프트웨어를 개발하였습니다. <br/>
이 중 buy(구매), account(회계), emp(인사), order(영업), product(자재), wareHouse(생산) 탭으로 나누어, '구매'탭을 중심으로 개발하였습니다.

<br/>

## 🙌목차 
1. [개발환경](#1-개발-환경-)
2. [구현 기능 및 담당역할](#2-구현-기능-및-담당역할-)
3. [Database 모델링](#3-database-모델링-)
4. [ERP 기능](#4-erp-기능-)

<br/>

## 1. 개발 환경 😎
- jdk 1.8
- Spring Faramework 4.3.27
- Spring security 4.2.15
- ORACLE DB 11g
- Tomcat 8.5

<br/>

## 2. 구현 기능 및 담당역할 🖐

- EXERD를 활용하여 **DB를 설계**하고, 논리,물리ERD를 구현하여 구축
- 단어사전, 용어사전을 정의하여 DB에 저장될 데이터의 이름들을 미리 동일시하기
- 데이터들 사이의 관계를 정의하여 참조 관계 정의
- ORACLE에서 참조관계를 고려하여 DB를 **구축**하고, 더미 데이터를 넣어 프로젝트를 수행 할 수 있는 기본 환경을 구축
- 공통 기능 구현 시, 다른 팀원들도 함께 사용할 수 있도록 **모듈화** 작업
- Spring Security 적용

- 구매부서
    - 자재를 구매하기 위한 **구매요청관리**
    - 거래처에게 발주서를 보내는 **발주관리**
    - 발주한 물품을 매입하는 **매입관리**
    - 매입한 물품 중 반품하기 **위한 반품관리**
    - 등록된 원자재 단가 수정을 **위한 단가관리**

- 기타부서
    - 주요 거래처를 관리하는 **거래처관리**
    - **매출 반품 관리**
    - **dataTable api**를 활용한 출하서 조회
    - 퇴직금 및 급여 내역 및 **계산**하는 쿼리문 작성
    - QR 코드를 이용한 **근태 등록** 기능
<br/>

## 3. Database 모델링 🌞
<img width="1000" alt="ERD" src="https://user-images.githubusercontent.com/49690185/106271386-ca043800-6272-11eb-97d1-fb04fe294b82.png">
<br/><br/>

## 4. ERP 기능 🎈

🔹 **Spring Security 적용** <br/>
<img width="1000" alt="시큐리티" src="https://user-images.githubusercontent.com/49690185/106271933-91189300-6273-11eb-90da-662fe0b999d8.png">
- spring security를 사용하여, 로그인 처리와 접근제한, 에러페이지를 적용하였습니다.
<br/>

🔹 **구매요청서** <br/>
<img width="500" alt="구매요청서" src="https://user-images.githubusercontent.com/49690185/105695833-e12ae900-5f45-11eb-91c6-42384e8f0b44.png">
- _원자재 추가_ 를 클릭할 시, 등록된 원자재를 보여줍니다.
- 구매할 원자재를 선택하여 구매 요청을 합니다.
- 잘못 선택한 원자재 목록을 '_선택삭제_'를 통해 삭제할 수 있습니다.
<br/>

🔹 **구매요청 현황** <br/>
<img width="500" alt="구매요청현황" src="https://user-images.githubusercontent.com/49690185/105696194-54ccf600-5f46-11eb-8a5f-36465c311815.png">
- _전체, 진행중, 발주완료 탭_ 으로 구분하여 리스트를 출력합니다.
- 작성일자, 작성자명 별로 _검색_ 이 가능합니다.
- 작성자명에서 '_찾기_'를 클릭할 시, 사원 리스트가 출력됩니다.
<br/>

🔹 **발주신청서** <br/>
<img width="500" alt="발주신청서" src="https://user-images.githubusercontent.com/49690185/105698643-7e3b5100-5f49-11eb-8747-2e2896b6f368.png">
- 구매요청서 상의 내역 혹은 발주하고자 하는 물품을 발주할 수 있습니다.
- '일반 발주 추가' : 저장된 원자재 **이외의 물품** 을 발주시에 사용하며, '일반 발주 추가'를 클릭 시, 발주 목록에 빈칸으로 목록이 추가됩니다.
- '삭제'버튼 : 구매요청이 들어온 요청목록을 삭제 할 수 있습니다.
- '발주이동'버튼 : _구매요청 리스트_ 를 나타내는 테이블의 목록을 체크한 뒤, '발주이동'클릭 시 발주목록으로 추가합니다.
<br/>

🔹 **발주현황** <br/>
<img width="500" alt="발주현황" src="https://user-images.githubusercontent.com/49690185/105699518-d32b9700-5f4a-11eb-983b-fe86fac6d6c7.png">
- _전체, 진행중, 매입완료, 발주취소_ 탭으로 리스트를 보여주며, '진행중'탭에서는 발주취소와 매입등록을 할 수 있습니다.
<br/>

🔹 **매입신청서** <br/>
<img width="500" alt="매입등록" src="https://user-images.githubusercontent.com/49690185/106266021-3ed37400-626b-11eb-9a7f-f45d2e468118.png">
- 발주한 물품 중 매입한 목록을 등록합니다.
- _거래처, 담당자_ 의 '_찾기_'버튼을 클릭 시, 저장된 거래처 혹은 담당자 목록을 보여주며, 리스트를 클릭하면 거래처 입력 폼에 자동으로 정보가 _입력_됩니다.
<br/>

🔹 **매입현황** <br/>
<img width="500" alt="매입현황" src="https://user-images.githubusercontent.com/49690185/106266177-77734d80-626b-11eb-8cc6-2d73d56601ac.png">
- _전체, 진행중, 입고완료, 매입취소, 반품처리 탭_ 으로 구분하여 리스트를 출력합니다.
- _작성일자, 작성자명_ 별로 _검색_ 이 가능합니다.
- 작성자명에서 '찾기'를 클릭할 시, 사원 리스트가 출력되며, 출력된 리스트를 클릭하면 정보가 해당 폼에 자동으로 입력됩니다.
- 진행중 탭에서 '_매입취소_'를 할 수 있습니다.
<br/>

🔹 **반품신청** <br/>
<img width="1000" alt="반품신청" src="https://user-images.githubusercontent.com/49690185/106268272-33ce1300-626e-11eb-9c5c-eee2f8cdfcb9.png">
- 반품신청은 2단계를 거칩니다.
- Step1 에서는 매입한 물품 리스트가 출력되며, 이 중 하나를 _선택_ 합니다.
- Step2 에서는 step1에서 선택한 매입 목록에 포함된 물품 리스트가 출력 되며, 이 중에서 _반품할 목록_ 을 선택하여 반품 등록을 진행합니다.
- 반품등록을 성공적으로 완료되면, '반품 신청이 완료되었습니다.'가 출력됩니다.
<br/>

🔹 **반품현황** <br/>
<img width="500" alt="반품현황" src="https://user-images.githubusercontent.com/49690185/106267480-0cc31180-626d-11eb-8218-d2e0c4ca5c53.png">
- _전체, 진행중, 출고완료, 반품취소 탭_ 으로 구분하여 반품 리스트를 보여줍니다.
- 진행중인 탭에서 리스트를 선택하여 _반품취소_ 를 할 수 있습니다.
<br/>

🔹 **거래처등록** <br/>
<img width="500" alt="거래처등록" src="https://user-images.githubusercontent.com/49690185/106267242-ba81f080-626c-11eb-9448-8b204505dc52.png">
- 발주하는 업체 혹은 판매하는 업체 등의 거래처를 등록합니다.
- 등록된 거래처는 후에 검색 시에도 이용됩니다.
- 우편번호는 카카오API 를 사용하여 나타냈습니다.
<br/>

🔹 **거래처조회** <br/>
<img width="500" alt="거래처조회" src="https://user-images.githubusercontent.com/49690185/106267528-219fa500-626d-11eb-90ca-44c1922ea902.png">
- 등록된 래처를 조회합니다.
- DataTable API를 이용하여 리스트를 조회하였으며, '페이지네이션, 리스트 복사, 엑셀파일로 저장, 인쇄, 검색'기능을 지원합니다.
<br/>

🔹 **사원 급여 내역** <br/>
<img width="1000" alt="급여내역" src="https://user-images.githubusercontent.com/49690185/106270601-970d7480-6271-11eb-86c8-c9ec6d4d5a4c.png">
- DataTable API를 이용하여 사원들의 급여 내역을 출력합니다.
- 사원 목록 클릭 시, 사원의 급여 상세 내역을 출력합니다.
- 기본급, 연장수당, 공제액 등을 계산하여 출력합니다.
<br/>

🔹 **매출물품 반품 신청** <br/>
<img width="1000" alt="거래처조회" src="https://user-images.githubusercontent.com/49690185/106270930-0edb9f00-6272-11eb-8e6b-520501a411ed.png">
- 거래처에게 판매한 물품들의 원자재를 _반품 등록_ 합니다.
- '+버튼'을 클릭 시, 부트스트랩을 사용하여 상세 내역을 출력하였습니다.
- 출하된 목록 중 하나를 선택하여 '다음 step'으로 넘긴 뒤, 반품 목록을 선택하여 반품을 등록합니다.


