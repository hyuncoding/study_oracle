/*

요구사항

유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
아이들은 여러 번 체험학습에 등록할 수 있어요.

*/

CREATE TABLE TBL_PARENT(
	ID NUMBER CONSTRAINT PK_PARENT PRIMARY KEY,
	PARENT_NAME VARCHAR2(1000) NOT NULL,
	PARENT_AGE NUMBER,
	PARENT_ADDRESS VARCHAR2(1000) NOT NULL,
	PARENT_PHONE VARCHAR2(1000) NOT NULL UNIQUE,
	PARENT_GENDER VARCHAR2(1000) NOT NULL
);

CREATE TABLE TBL_CHILD(
	ID NUMBER CONSTRAINT PK_CHILD PRIMARY KEY,
	CHILD_NAME VARCHAR2(1000) NOT NULL,
	CHILD_AGE NUMBER,
	CHILD_GENDER VARCHAR2(1000) NOT NULL,
	PARENT_ID NUMBER,
	CONSTRAINT FK_CHILD_PARENT FOREIGN KEY(PARENT_ID)
	REFERENCES TBL_PARENT(ID)
);

CREATE TABLE TBL_FIELD_TRIP(
	ID NUMBER CONSTRAINT PK_FIELD_TRIP PRIMARY KEY,
	FIELD_TRIP_TITLE VARCHAR2(1000),
	FIELD_TRIP_CONTENT VARCHAR2(1000),
	FIELD_TRIP_NUMBER NUMBER
);

CREATE TABLE TBL_FIELD_TRIP_FILE(
	ID NUMBER CONSTRAINT PK_FIELD_TRIP_FILE PRIMARY KEY,
	FILE_ORIGINAL_NAME VARCHAR2(1000) NOT NULL,
	FILE_SYSTEM_NAME VARCHAR2(1000) NOT NULL,
	FILE_POSITION VARCHAR2(100),
	FIELD_TRIP_ID NUMBER,
	CONSTRAINT FK_FIELD_TRIP_FILE_FIELD_TRIP FOREIGN KEY(FIELD_TRIP_ID)
	REFERENCES TBL_FIELD_TRIP(ID)
);

CREATE TABLE TBL_APPLY(
	ID NUMBER CONSTRAINT PK_APPLY PRIMARY KEY,
	CHILD_ID NUMBER,
	FIELD_TRIP_ID NUMBER,
	CONSTRAINT FK_APPLY_CHILD FOREIGN KEY(CHILD_ID)
	REFERENCES TBL_CHILD(ID),
	CONSTRAINT FK_APPLY_FIELD_TRIP FOREIGN KEY(FIELD_TRIP_ID)
	REFERENCES TBL_FIELD_TRIP(ID)
);

/*

요구사항

안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.

*/

CREATE TABLE TBL_COMPANY(
	ID NUMBER CONSTRAINT PK_COMPANY PRIMARY KEY,
	COMPANY_NAME VARCHAR2(1000) NOT NULL,
	COMPANY_ADDRESS VARCHAR2(1000) NOT NULL,
	COMPANY_TEL VARCHAR2(1000) NOT NULL,
	COMPANY_TYPE VARCHAR2(1000) NOT NULL
);

CREATE TABLE TBL_CATEGORY_A(
	ID NUMBER CONSTRAINT PK_CATEGORY_A PRIMARY KEY,
	CATEGORY_A_NAME VARCHAR2(1000) NOT NULL
);

CREATE TABLE TBL_CATEGORY_B(
	ID NUMBER CONSTRAINT PK_CATEGORY_B PRIMARY KEY,
	CATEGORY_B_NAME VARCHAR2(1000) NOT NULL,
	CATEGORY_A_ID NUMBER,
	CONSTRAINT FK_CATEGORY_B_CATEGORY_A FOREIGN KEY(CATEGORY_A_ID)
	REFERENCES TBL_CATEGORY_A(ID)
);

CREATE TABLE TBL_CATEGORY_C(
	ID NUMBER CONSTRAINT PK_CATEGORY_C PRIMARY KEY,
	CATEGORY_C_NAME VARCHAR2(1000) NOT NULL,
	CATEGORY_B_ID NUMBER,
	CONSTRAINT FK_CATEGORY_C_CATEGORY_B FOREIGN KEY(CATEGORY_B_ID)
	REFERENCES TBL_CATEGORY_B(ID)
);

CREATE TABLE TBL_ADVERTISEMENT(
	ID NUMBER CONSTRAINT PK_ADVERTISEMENT PRIMARY KEY,
	ADVERTISEMENT_TITLE VARCHAR2(1000),
	ADVERTISEMENT_CONTENT VARCHAR2(1000),
	CATEGORY_C_ID NUMBER,
	CONSTRAINT FK_ADVERTISEMENT_CATEGORY_C FOREIGN KEY(CATEGORY_C_ID)
	REFERENCES TBL_CATEGORY_C(ID)
);

CREATE TABLE TBL_APPLY(
	ID NUMBER CONSTRAINT PK_APPLY PRIMARY KEY,
	COMPANY_ID NUMBER NOT NULL,
	ADVERTISEMENT_ID NUMBER NOT NULL,
	CONSTRAINT FK_APPLY_COMPANY FOREIGN KEY(COMPANY_ID)
	REFERENCES TBL_COMPANY(ID),
	CONSTRAINT FK_APPLY_ADVERTISEMENT FOREIGN KEY(ADVERTISEMENT_ID)
	REFERENCES TBL_ADVERTISEMENT(ID)
);


/*

요구사항

음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다. 
음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.

*/
CREATE TABLE TBL_MEMBER(
	ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
	MEMBER_ADDRESS VARCHAR2(1000)
);


CREATE TABLE TBL_SOFT_DRINK(
	ID NUMBER CONSTRAINT PK_SOFT_DRINK PRIMARY KEY,
	SOFT_DRINK_NAME VARCHAR2(1000) NOT NULL,
	SOFT_DRINK_PRICE NUMBER DEFAULT 0
);

CREATE TABLE TBL_PRODUCT(
	ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
	PRODUCT_NAME VARCHAR2(1000) NOT NULL
);

CREATE TABLE TBL_LOTTERY(
	ID NUMBER CONSTRAINT PK_LOTTERY PRIMARY KEY,
	PRODUCT_ID NUMBER,
	CONSTRAINT FK_LOTTERY_PRODUCT FOREIGN KEY(PRODUCT_ID)
	REFERENCES TBL_PRODUCT(ID)
);

CREATE TABLE TBL_CIRCULATION(
	ID NUMBER CONSTRAINT PK_CIRCULATION PRIMARY KEY,
	SOFT_DRINK_ID NUMBER,
	LOTTERY_ID NUMBER,
	CONSTRAINT FK_CIRCULATION_SOFT_DRINK FOREIGN KEY(SOFT_DRINK_ID)
	REFERENCES TBL_SOFT_DRINK(ID),
	CONSTRAINT FK_CIRCULATION_LOTTERY FOREIGN KEY(LOTTERY_ID)
	REFERENCES TBL_LOTTERY(ID)
);

CREATE TABLE TBL_DELIVERY(
	ID NUMBER CONSTRAINT PK_DELIVERY PRIMARY KEY,
	DELIVERY_STATUS VARCHAR2(100) DEFAULT 'READY',
	MEMBER_ID NUMBER,
	PRODUCT_ID NUMBER,
	CONSTRAINT FK_DELIVERY_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_DELIVERY_PRODUCT FOREIGN KEY(PRODUCT_ID)
	REFERENCES TBL_PRODUCT(ID)
);

/*

요구사항

이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
기업의 정보는 기업 이름, 주소, 대표번호가 있고
사용자 정보는 이름, 주소, 전화번호가 있습니다. 결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.

*/

CREATE TABLE TBL_COMPANY(
	ID NUMBER CONSTRAINT PK_COMPANY PRIMARY KEY,
	COMPANY_NAME VARCHAR2(1000) NOT NULL,
	COMPANY_ADDRESS VARCHAR2(1000) NOT NULL,
	COMPANY_TEL VARCHAR2(1000) NOT NULL
);

CREATE TABLE TBL_MEMBER(
	ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
	MEMBER_NAME VARCHAR2(1000),
	MEMBER_ADDRESS VARCHAR2(1000),
	MEMBER_PHONE VARCHAR2(1000)
);

CREATE TABLE TBL_PRODUCT(
	ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
	PRODUCT_NAME VARCHAR2(1000) NOT NULL,
	PRODUCT_PRICE NUMBER DEFAULT 0,
	PRODUCT_STOCK NUMBER DEFAULT 0,
	COMPANY_ID NUMBER,
	CONSTRAINT FK_PRODUCT_COMPANY FOREIGN KEY(COMPANY_ID)
	REFERENCES TBL_COMPANY(ID)
);

CREATE TABLE TBL_CARD(
	ID NUMBER CONSTRAINT PK_CARD PRIMARY KEY,
	CARD_NUMBER VARCHAR2(1000) NOT NULL,
	CARD_COMPANY VARCHAR2(1000) NOT NULL,
	MEMBER_ID NUMBER,
	CONSTRAINT FK_CARD_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID)
);

CREATE TABLE TBL_ORDER(
	ID NUMBER CONSTRAINT PK_ORDER PRIMARY KEY,
	MEMBER_ID NUMBER,
	ORDER_DATE DATE DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT FK_ORDER_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID)
);

CREATE TABLE TBL_ORDER_DETAIL(
	ID NUMBER CONSTRAINT PK_ORDER_DETAIL PRIMARY KEY,
	PRODUCT_COUNT NUMBER DEFAULT 1,
	ORDER_ID NUMBER,
	PRODUCT_ID NUMBER,
	CONSTRAINT FK_ORDER_DETAIL_ORDER FOREIGN KEY(ORDER_ID)
	REFERENCES TBL_ORDER(ID),
	CONSTRAINT FK_ORDER_DETAIL_PRODUCT FOREIGN KEY(PRODUCT_ID)
	REFERENCES TBL_PRODUCT(ID)
);

CREATE TABLE TBL_PAY(
	ID NUMBER CONSTRAINT PK_PAY PRIMARY KEY,
	MEMBER_ID NUMBER,
	ORDER_ID NUMBER,
	CARD_ID NUMBER,
	CONSTRAINT FK_PAY_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_PAY_ORDER FOREIGN KEY(ORDER_ID)
	REFERENCES TBL_ORDER(ID),
	CONSTRAINT FK_PAY_CARD FOREIGN KEY(CARD_ID)
	REFERENCES TBL_CARD(ID)
);