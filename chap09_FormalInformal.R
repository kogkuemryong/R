# chap09_FormalInformal

####################################################
#       chapter09. 정형/비정형 데이터 처리         #
####################################################

# 1.1 Oracle 정형 데이터 처리 

# 단계1 : 사용자 로그인과 테이블 생성
# - sqlplus 명령문으로 접속 후 다음의 데이터 생성 


# 이 안에 들어 있는 모든 글을 문자열로 처리한다. 주성문으로 많이 사용한다. 

"""
SQL> 
create table test_table(
  id    varchar2(50) primary key,
  pass  varchar2(30) not null,
  name  varchar2(30) not null, 
  age   number(2) 
);
"""

# 단계2 : 레코드 추가와 조회하기 
# SQL> insert into test_table values('hong', '1234', '홍길동',25);
# SQL> insert into test_table values('lee', '1234', '이순신',30);

# 단계3 : transaction 처리 - commit; 
# SQL> commit; 

# Oracle 연동을 위한 R 패키지 설치.
# 1) 패키지 설치
#   - RJDBC 패키지 사용하기 위해서는 java를 설치해야 한다.(내부가 java로 되어 있기 때문이다.)

install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")

# 2) 패키지 로딩
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jdk1.8.0_221') # java 위치 명시 
library(DBI)
library(rJava) 
library(RJDBC) # rJava에 의존적이다(rJava 먼저 로딩)

# 3) Oracle 연동 (주의 : 버전에 따라 다름)

### Oracle 11g Ex. 
# driver
drv <- JDBC("oracle.jdbc.driver.OracleDriver","C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar")
# oracle 사이트 또는 구글링을 통해서 찾으면 된다. 


# db 연동 (driver, url, id, pwd)
conn <- dbConnect(drv, "jdbc:oracle:thin:@//localhost:1521/xe", "scott", "tiger")

# (1) 모든 레코드 검색 
query <- "select * from test_table"
dbGetQuery(conn, query)


# (2) 조건 검생 - 나이가 30살 이상인 레코드 조회
query <- "select * from test_table where age >= 30"
result <- dbGetQuery(conn, query)

str(result) 
# 'data.frame':	1 obs. of  4 variables:
#   $ ID  : chr "lee"
# $ PASS: chr "1234"
# $ NAME: chr "이순신"
# $ AGE : num 30

# (3) 정렬 조회 - 나이 컬럼을 기준으로 내림차순 정렬
query <- "select * from test_table order by age desc"
dbGetQuery(conn, query)

# (4) 레코드 삽입
query <- "insert into test_table values('kang', '123', '강감찬', 35)"
dbSendUpdate(conn,query)

query <- "select * from test_table"
dbGetQuery(conn, query)

# (5) 레코드 수정 : 데이터 '강감찬'의 나이를 35 -> 40 으로 수정 
query <- "update test_table set age=40 where name='강감찬'"
dbSendUpdate(conn,query)

query <- "select * from test_table"
dbGetQuery(conn, query)
# '강감찬' - 문자열 안에 있기 때문에 작은 따옴표로 감싸야 한다. 

# (6) 레코드 삭제 - 데이터 '홍길동' 레코드 삭제 
query <- "delete from test_table where name = '홍길동'"
dbSendUpdate(conn,query) # RJDBC

query <- "select * from test_table"
dbGetQuery(conn, query) # DBI 

# (7) db 연결 종료 
dbDisconnect(conn) # DBI



################################################################################

# 2. 비정형 데이터 처리(텍스트 마이닝 분석)

# - 텍스트 마이닝(Text Mining): 문자로 된 데이터에서 가치 있는 정보를 얻어 내는 분석 기법.

## 2.1 토픽 분석
#   - 텍스트 데이터를 대상을 단어를 추출하고, 이를 단어 사전과 비교하여 단어의 출현 빈도수를 분석하는  텍스팅 마이닝 분석 


# - 또한 단어구름(word cloud) 패키지를 적용하여 분석 결과를 시각화 한느 과정도 포함 


# (1) 패키지 설치 및 준비 
# 4점대의 버전으로는 텍스트 마이닝을 사용하는 패키지를 KoKNP을 지원하지 않기 때문에 그에 맞는 버전으로 변경 해야한다. 
install.packages("KoKLP") # package ‘KoKNP’ is not available (for R version 4.0.1)

install.packages("https://cran.rstudio.com/bin/windows/contrib/3.4/KoNLP_0.80.1.zip",repos = NULL)

# repos = NULL : 버전은 다운한 3.6버전에 설치한다든 옵션 

# Sejong 설치 : KoNLP 와 의존성 있는 현재 버전의 한글 사전 
# Sejong 패키지 설치
install.packages("Sejong")

install.packages(c("hash","tau","RSQLite","rJava","devtools"))

library(Sejong)
library(hash)
library(tau)
library(RSQLite)

Sys.setenv(JAVA_HOME='C:/Program Files/Java/jdk1.8.0_221')
library(rJava) # rJava를 올리기 전에 java의 위치를 지정해줘햔다. 
library(devtools)

library(KoNLP)

install.packages(c("wordcloud", "tm"))
library(wordcloud)
library(tm)


# (2) 텍스트 자료 가져오기 
facebook <- file("C:/workspaces/R/data/facebook_bigdata.txt",encoding = "UTF-8")
# file : 텅키로 파일을 읽어 온다.
facebook_data <- readLines(facebook)
# readLines : 줄 단위 데이터 생성
head(facebook_data) # 앞부분 6줄 보기 - 줄 단위 데이터 생성
str(facebook_data) # chr [1:76] 


# (3) 세종 사전에 신규 단어 추가
userDic <- data.frame(term=c("R 프로그래밍", "페이스북", "소셜네트워크", "얼죽아"), tag='ncn') 
# term = 추가 단어 저장 
# tag = 저장된 문자의 형태 저장
# ('ncn') : 명사 

# - 신규 단어 사정 추가 함수 
buildDictionary(ext_dic = 'sejong', user_dic = userDic)  
#buildDictionary (ext_dic = '저장할 사전 이름', user_dic = 변수 이름 )


# (4) 단어 추출 위한 사용자 정의 함수 
# - R 제공 함수로 단어 추출하기 - Sejong 사전에 등록된 신규 단어 테스트 
paste(extractNoun("홍길동은 얼죽아를 최애로 생각하는, 빅데이터에 최대 관심을 가지고 있으면서, 페이스북이나 소셜네트워크로부터 생성 수집되어진 빅데이터 분석에 많은 관심을 가지고 있어요."),collapse=" ")
# [1] "홍길동은 얼죽아 최애로 생각 빅데이터에 최대 관심 페이스북 소셜네트워크 생성 수집 빅데이터 분석 관심"


# paste() : 나열된 원소 사이에 공백을 두고 결과값을 출력합니다.
# paste0() : 나열된 원소 사이에 공백없이 출력합니다.
# extractNoun() : 명사를 추출 
# collapse=" " : 찾은 단어 사이 넣기. 


# 단어 추출을 위한 사용자 정의 함수 정의하기 
# (1) 사용자 정의 함수 작성

# -[문자형 변환] -> [명사 단어 추출] -> [" "으로 데이터 연결하여 하나의 문자열로 출력] 
exNouns <- function(x){ 
  paste(extractNoun(as.character(x)), collapse = " ")  
}
# (2) exNouns 함수 이용 단어 추출
facebook_nouns <- sapply(facebook_data, exNouns) # 명사 단어 추출 
facebook_nouns[1] # 단어가 추출된 첫 줄 보기 

# sapply(list, function)
# sapply 는 list 대신 행렬 or 벡터로 반환한다.

# Apply 함수는 행렬의 행 또는 열 방향으로 특정 함수를 적용한다.
# apply(matrix, 1 or 2, 함수)
# 1: 행, 2: 열

# lapply
# apply 함수의 단점은 input 으로 array 만 입력할 수 있다는 것이다. 
# 일반적으로 vector 를 input 넣는 경우가 많은데, 이를 위해 lapply 가 존재한다. 
# 입력으로 vector 또는 list 를 받아 list 를 반환한다.

# 추출된 단어 대상 전처리 
#  단계1: 추출된 단어 이용 말뭉치(Corpus) 생성
myCorpus <- Corpus(VectorSource(facebook_nouns))
myCorpus
# Corpus() : 단어 처리의 단위
# VectorSource() : vector 형으로 변환 

# <<SimpleCorpus>>
# Metadata:  corpus specific: 1, document level (indexed): 0
# Content:  documents: 76
# - 76개의 말뭉치 단위로 포장

# 단계2 : 데이터 전처리 
myCorpusPrepro <- tm_map(myCorpus,removePunctuation) # 문장부호 제거 
# - myCorpus 안에 들어있는 문장 부호를 삭제 한다. 

myCorpusPrepro <-tm_map(myCorpusPrepro, removeNumbers) # 수치 제거
# - myCorpusPrepro 안에 들어있는 숫자 삭제 한다.

myCorpusPrepro <-tm_map(myCorpusPrepro, tolower) #영문자 소문자 변경
# - myCorpusPrepro 안에 들어있는 영문자 소문자 변경.

myCorpusPrepro <-tm_map(myCorpusPrepro, removeWords,stopwords('english')) 
# 불용어(for, very, and, of, are...)제거 

# tm_map() : Corpus로 처리된 데이터를 받아서 필터링을 해준다.
# removePunctuation : 문장부호 삭제 
# removeNumbers : 수치 제거 
# tolower : 영문자 소문자 변경 
# removeWords , stopwords('english') :  불용어(for, very, and, of, are...)제거 

# 전처리 결과 확인
inspect(myCorpusPrepro[1])

# (6) 단어 선별(단어 2음절~8음절 사이 단어 선택) 하기 

# - Corpus 객체를 대상으로 TermDocumentMatrix() 함수를 이용하여 분석에 필용한 단어 선별하고 단어/문서 행렬을 만든다. 

# - 전처리 된 단어집에서 단어 선별(단어 2음절 ~ 8음절 사이 단어)하기
# - 한글 1음절은 2byte에 저장(2음절 = 4byte , 8음절 = 16byte)
myCorpusPrepro_term <- TermDocumentMatrix(myCorpusPrepro,control=list(wordLengths=c(4,16)))
# 텍스트를 숫자로 표현하는 대표적인 방법 

myCorpusPrepro_term # Corpus 객체 정보 
# <<TermDocumentMatrix (terms: 696, documents: 76)>>
#   Non-/sparse entries: 1256/51640
# Sparsity           : 98%
# Maximal term length: 12
# Weighting          : term frequency (tf)

# matrix 자료구조를 data.frame 자료 구조로 변경
myTerm_df <- as.data.frame(as.matrix(myCorpusPrepro_term))
dim(myTerm_df) # [1] 696  76

# (7) 단어 출현 빈도수 구하기 - 빈도수 높은 순서대로 내림차순 정렬. 
wordResult <- sort(rowSums(myTerm_df), decreasing = T)
# 빈도수로 내림차순 정렬
# decreasing = T : 내림차순 정렬

wordResult[1:10]
#데이터  분석   빅데이터   처리     사용     수집   시스템     저장     결과     노드 
#91       41       33       31       29       27      23        16       14       13 


# (8) 불필요한 용어 제거 시작 
#  1) 데이터 전처리 
myCorpusPrepro <- tm_map(myCorpus,removePunctuation) # 문장부호 제거 
# - myCorpus 안에 들어있는 문장 부호를 삭제 한다. 

myCorpusPrepro <-tm_map(myCorpusPrepro, removeNumbers) # 수치 제거
# - myCorpusPrepro 안에 들어있는 숫자 삭제 한다.

myCorpusPrepro <-tm_map(myCorpusPrepro, tolower) #영문자 소문자 변경
# - myCorpusPrepro 안에 들어있는 영문자 소문자 변경.

myCorpusPrepro <-tm_map(myCorpusPrepro, removeWords,stopwords('english')) 
# 불용어(for, very, and, of, are...)제거 

myStopwords <- c(stopwords('english'),"사용","하기")

myCorpusPrepro <-tm_map(myCorpusPrepro, removeWords,myStopwords) # 불용어 제거 

inspect(myCorpusPrepro[1:5]) # 데이터 전처리 결과 확인 


# 단어 선별 - 단어 길이 2 ~ 8 개 이상 단어 선별.
myCorpusPrepro_term <- TermDocumentMatrix(myCorpusPrepro,control=list(wordLengths=c(4,16)))
# 텍스트를 숫자로 표현하는 대표적인 방법 

myCorpusPrepro_term

myTerm_df <- as.data.frame(as.matrix(myCorpusPrepro_term))
dim(myTerm_df) # [1] 696  76

# 단어 출현 빈도수 구하기 - 빈도수 높은 순서대로 내림차순 정렬. 
wordResult <- sort(rowSums(myTerm_df), decreasing = T)
# 빈도수로 내림차순 정렬
# decreasing = T : 내림차순 정렬

wordResult[1:20]


# (9) 단어 구름(wordcloud) - 디자인 적용 전 
myName <- names(wordResult) # 단어 이름 축출
wordcloud(myName, wordResult) # 단어 구름 시각화 

# 단어 구름에 디자인 적용 (빅도수, 색상, 위치, 회전등)
#(1) 단어 이름과 빈도수로 data.frame 생성  
word.df <- data.frame(word=myName, freq=wordResult)
str(word.df)
# 'data.frame':	694 obs. of  2 variables:
# $ word: Factor w/ 694 levels "‘똑똑한","‘삶",..: 197 283 297 546 359 374 495 103 169 399 ...
# $ freq: num  91 41 33 31 27 23 16 14 13 13 ...

# (2) 단어 색상과 글꼴 지정
pal <- brewer.pal(12,"Paired") # 12가지 생상 pal
windowsFonts(malgun=windowsFont("맑은 고딕"))
# brewer.pal(색상의 수)

# (3) 단어 구름 시각화 
x11() # 별도의 창을 띄우는 함수 
wordcloud(word.df$word, word.df$freq, scale = c(5,1), min.freq = 3, random.order = F, rot.per = .1, colors = pal, famliy = "malgun")

# random.order = F : 가장 큰 크기를 가운데 고정 


# 예시 2) 텍스트 파일 가져오기와 단어 추출하기 
# 데이터 불러오기 
txt <- readLines("C:/workspaces/R/data/hiphop.txt")
head(txt)


install.packages("stringr")
library(stringr)

# 특수문자 제거 
txt1 <- str_replace_all(txt, "\\W", " ") # "\W(대문자) : 특수문자 선택  
# str_replace_all(변수, 변경 전 문자, 변경 후 문자)
head(txt1)

# 가사에서 명사 추출 
nouns <- extractNoun(txt1)
head(nouns)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns)) # unlist( ) : list -> vector 
head(wordcount);tail(wordcount) # 하위 6개 출력 

#         1  100 168  17 
#12   2   8   3   1   1 


#  히   히트     힘   힘겹 힘내잔   힙합 
#  8      1      10     1      1      1 

# 데이터 프레임으로 변환
df_word<-as.data.frame(wordcount,stringsAsFactors = F) 
# stringsAsFactors = F : 문자열 그대로 형변환 없이 출력, stringsAsFactors = T : factor 형으로 출력. 

tail(df_word)
#        Var1 Freq
# 3078     히    8
# 3079   히트    1
# 3080     힘   10
# 3081   힘겹    1
# 3082 힘내잔    1
# 3083   힙합    1

# 변수명 수정 
names(df_word) <- c('word', 'freq')
tail(df_word)
#        word freq
# 3078     히    8
# 3079   히트    1
# 3080     힘   10
# 3081   힘겹    1
# 3082 힘내잔    1
# 3083   힙합    1

install.packages("dplyr")
library(dplyr)

df_word <- filter(df_word,nchar(word) >= 2) # nchar() :  length  제공 

top_20 <- df_word %>% arrange(desc(freq)) %>% head(20) # 내리차순으로 정렬(가장 많이 언급된 단어)
top_20

# 시각화 
pal <- brewer.pal(8,"Dark2") # Dark2 색상 목록에서 8개 색상 추출.

set.seed(1234)
x11()
wordcloud(word=df_word$word, freq = df_word$freq, min.freq = 2, max.words = 200, random.order = F, rot.per = .1, scale = c(4,0.3), colors=pal) 
# min.freq = 2 : 두번 이상 언급 된 것 출력 , max.words = 200 : 출력되는 단어 수 200개 까지만
# random.order = F : 가장 많이 언급된 단어 가운데 배치, rot.per = .1 : 단어의 회전각 0.1
# scale = c(4,0.3) : 텍스트 들의 비율 및 크기 







## 연관어 분석
#   : 연관규칙(Association Rule)을 적용하여 특정 단어와 연관성이 있는 단어들을 선별하여 네트워크 형태로 시각화 해주는 과정.

# 한글 처리를 위한 패키지 설치. 
# 토픽 분석과 동일

install.packages("KoKLP") # package ‘KoKNP’ is not available (for R version 4.0.1)

install.packages("https://cran.rstudio.com/bin/windows/contrib/3.4/KoNLP_0.80.1.zip",repos = NULL)

# repos = NULL : 버전은 다운한 3.6버전에 설치한다든 옵션 

# Sejong 설치 : KoNLP 와 의존성 있는 현재 버전의 한글 사전 
# Sejong 패키지 설치
install.packages("Sejong")

install.packages(c("hash","tau","RSQLite","rJava","devtools"))

library(Sejong)
library(hash)
library(tau)
library(RSQLite)

Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_221')
library(rJava) # rJava를 올리기 전에 java의 위치를 지정해줘햔다. 
library(devtools)

library(KoNLP)


# 텍스트 파일 가져오기와 단어 추출하기 
marketing <- file("C:/workspaces/R/data/marketing.txt", encoding = "UTF-8")

marketing2 <- readLines(marketing) # 줄 단위 데이터 생성

marketing2[1]

# 2. 줄 단위 단어 추출
lword <- Map(extractNoun, marketing2) # Map(extractNoun,변수) :변수에서 명사단위로 추출 
head(lword)
length(lword) # [1] 472 : 라인별로 472개를 가지고 있다.

lword <- unique(lword) # 빈 block 필터링 
length(lword) # [1] 353 : 중복 단어를 제거 이후, 353개를 가지고 있다. 
head(lword)

lword <-sapply(lword, unique)
# sapply(lword, unique) 변수의 값을 함수에 넣어서 결과를 vector로 출력. 
# unique : 입력의 데이터를 보고 중복 되어지는 텍스트를 제거하는 함수 
length(lword) # [1] 353

str(lword) # List of 353
# $ : chr [1:20] "본고" "목적" "비판이론" "토대" ...
# $ : chr [1:19] "전통" "적" "마케팅" "욕구충족" ...

# 단어 필터링 함수 정의 - 길이가 2개 이상 4개 이하 사이의 문자 길이로 구성된 단어. 
filter1 <- function(x){
  nchar(x) >= 2 && nchar(x) <=4 && is.hangul(x)
} # 자동적으로 영어가 필터링, 

filter2 <- function(x){
  Filter(filter1, x) 
}

# 2) 줄 단위로 추출된 단어 전처리 
lword <- sapply(lword, filter2) # 단어 길이 1이하 또는 5이상인 단어 제거

head(lword)

# 트랜잭션 생성
#   - 트랜잭션 : 연관분석에서 사용되는 처리 단위. 
#   - 연관분석을 위해서는 추출된 단어를 대상으로 트랜잭션 형식을 자료구조 변환. 
#   - 토픽 분석 Corpus() : 단어 처리의 단위

# 1) 연관분석을 위한 패키지 설치 
install.packages("arules")
library(arules)

# 2) 트랜잭션 생성
wordtran <- as(lword, "transactions")
wordtran
# transactions in sparse format with
# 353 transactions (rows) and
# 2423 items (columns)


# 3) 교차평 작성 : crossTable() -> 교차테이블 함수를 이용. 
wordtable <- crossTable(wordtran)
wordtable


# 4) 단어 간 연관 규칙 산출  
transrlue <- apriori(wordtran, parameter = list(support=0.25,conf =0.05)) 
# writing ... [59 rule(s)] done [0.00s].59개의 규칙을 찾았다. 


# 자료구조의 형태는 transaction 일때 정상적으로 실행
# apriori() : 연관분석 기능 적용(규칙성을 찾음)
# parameter = 
# support = 지지도 : 수치형의 값(상관도) = 퍼센트 값으로 최대값 1, 최소값 0
# 전체 거래에서 특정 물품 A와 B가 동시에 거래되는 비중으로,해당 규칙이 얼마나 의미가 있는 규칙인지를 보여줍니다.
#지지도 = P(A∩B)  :  A와 B가 동시에 일어난 횟수 / 전체 거래 횟수
# conf = 신뢰도 
# A를 포함하는 거래 중 A와 B가 동시에 거래되는 비중으로,
# A라는 사건이 발생했을 때 B가 발생할 확률이 얼마나 높은지를 말해줍니다.
# 신뢰도 =  P(A∩B) / P(A)  :  A와 B가 동시에 일어난 횟수 / A가 일어난 횟수


# 5) 연관 규칙 생성 결과 보기 
inspect(transrlue)

# 연관어 시각화 
# 1) 연관 단어 시각화를 위해서 자료 구조 변경
rules <- labels(transrlue, ruleSep = " ") # 연관규칙 레이블을 " "으로 분리 
head(rules,20)
# 1대1의 관계로 출력 
class(rules) # [1] "character"

# 2) 문자열로 묶인 연관 단어를 행렬 구조 변경
rules <- sapply(rules, strsplit, " ", USE.NAMES = F)
rules
class(rules) # [1] "character" -> [1] "list"

# 3) 행 단위로 묶어서 matrix로 반환 (do.call)
rulemat <- do.call("rbind", rules)
rulemat
class(rulemat) # [1] "matrix"


# 연관어 시각화를 위한 igraph 패키지 설치
install.packages("igraph")
library(igraph)

# edgelist 보기 - 연관 단어를 정점(vertex) 형태의 목록 제공
# matrix 형태의 자료형을 전달 받게 되어 있음 
relueg <- graph.edgelist(rulemat[c(12:59),],directed = F) # [c(1:11)] - "{}" 제외 
relueg

# edgelist 시각화 
x11()
plot.igraph(relueg,vertex.label=V(relueg)$name, vertex.label.cex=1.2,vertex.label.color='black',vertex.size=20, vertex.color='green',vertex.frame.color = 'blue') 



