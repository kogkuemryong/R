# chap03_DataIO

######################################
#    chapter03. 데이터의 입출력      #
######################################

#1. 데이터 불러오기

##1.1 키보드 입력

# 키보드로 숫자 입력하기 
num <- scan()
num

# 합계 구하기 
sum(num)

# 키보드 문자 입력하기 
name <- scan(what = character())
name

# 편집기 이용 데이터 프레임 만들기 
df <- data.frame() # 빈 데이터프레임 생성
df <- edit(df)



## 1-2. 로컬 파일 가져오기 

## read.table 이용
# - 컬럼명이 없는 파일 불러오기
getwd()
setwd("C:/workspaces/R/data")

student <- read.table(file = "student.txt")
student


# 자료형, 자료구조 확인 
mode(student); class(student)


# 컬럼명 지정 
names(student) <- c('번호', '이름', '키', '몸무게')


# - 컬럼명이 있는 파일 불러오기
student <- read.table(file = "student1.txt", header = T)
student


# - 탐새기를 통해서 파일 선택하기 
student1 <- read.table(file.choose(), header = T)
student1

# - 구분자 있는 경우(세미콜론, 탭)
student2 <- read.table(file = "student2.txt", sep = ";" , header = T)
student2

# - 결측치를 처리하여 파일 불러오기 
student3 <- read.table(file = "student3.txt",header = T, na.strings = "-")
student3

#read.csv()
student4 <- read.csv(file = "student4.txt", na.strings = "-")
student4


# read.xlsx() 함수 이용 = 엑셀 데이터 읽어오기 
# 패키지 설치와 java 실행환경 설정
install.packages("rJava")  #rJava 패키지 설치
install.packages("xlsx") 
# xlsx 패키지 설치 - 내부의 코어가 java로 되어 있다. 그래서 java가 설치되어야지 
# 다운 받을 수 있다.

Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_221') 
# java의 위치를 설정해줘야지 구동이 된다. 


# 관련 패키지 메모리 로드 
library(rJava)
library(xlsx)

#엑셀 파일 가져 오기 
stuentex <- read.xlsx(file.choose(), sheetIndex =1, encoding = "UTF-8")
stuentex

## 1-3. 인터넷에서 파일 가져오기 

# 단계 1 : 세계 GDP 순위 데이터 가져오기 
GDP_Ranking <- read.csv("http://databank.worldbank.org/data/download/GDP.csv", encoding = "UTF-8")
head(GDP_Ranking ,10) #head 통해서 부분적으로 원하는 값, 개수를 출력할 수 있다.
dim(GDP_Ranking)

# read.csv , read.table, read.xlsx 반환형 = data.frame 

# 데이터를 가공하기 위해 불필요한 행과 열을 저거한다. 
GDP_Ranking2<-GDP_Ranking[-c(1:4) , c(1,2,4,5)] 
head(GDP_Ranking2) 

# 상위 16개 국가 선별한다. 
GDP_Ranking16 <-head(GDP_Ranking2, 16) 
GDP_Ranking16

# 데이터프레임을 구성하는 4개의 열에 대한 이름을 지정한다. 
names(GDP_Ranking16) <- c('code','Ranking','Nation','GDP')
GDP_Ranking16
dim(GDP_Ranking16)

# 단계 2 : 세계 GDP 상위 16위 국가 막대 차트 시각화 
gdp<-GDP_Ranking16$GDP # $객체 접근 
nation <- GDP_Ranking16$Nation 

num_gdp <- as.numeric(str_replace_all(gdp,',','')) # 전체의 모든 , 를 제거 
num_gdp

GDP_Ranking16$GDP <- num_gdp 

# 막대차트 시각화 
barplot(GDP_Ranking16$GDP, col = rainbow(16), xlab = '국가(nation)', ylab = '단위(dollar)', names.arg=nation)

# 1.000단위 축소 
num_gdp2 <- num_gdp/ 1000 
GDP_Ranking16$GDP2 <- num_gdp2
barplot(GDP_Ranking16$GDP2, col = rainbow(16),main = "2018년도 GDP 서계 16위 국가", 
        xlab = '국가(nation)', ylab = '단위(천달러)', names.arg=nation)


## 1-4. 웹문서 가져오기 (반정형성의 데이터 수집)

# 2010년 ~ 2015년도 미국의 주별 1인당 소등 자료 가져오기.
# "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

# 단계1 : XML / httr 패키지 설치 : 웹페이지의 내용을 읽어 올 수 있다(크롤링)
install.packages("XML")
install.packages("httr")

library(XML)
library(httr)

# 단계2 : 미국의 주별 1인당 소득 자료 가져오기. 
url <- "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

get_url <- GET(url) # httr 제공
get_url
get_url$content  #16진수 - 메모리의 값 그대로 가져온다. 
rawToChar(get_url$content) #16진수의 데이터를 이해할 수 있도록 문자열로 변환 - html소스코드 출력

html_cont <- readHTMLTable(rawToChar(get_url$content),stringAsFactors=F) #html에서 테이블을 찾아서 읽어오는 함수 
# Fators : 요인 , 순서(level) 
# 테이블에 있는 데이터를 문자열 그대로 읽어와라. / stringAsFactors= T 빈도의 값을 시각화 할 때 사용. 
str(html_cont) #list 형태로 결과값 출력 
# list 접근 방법이 key-value 값 
# Str = 변수의 성격(성질)을 보여주는 함수 

html_cont <- as.data.frame(html_cont) #data.frame형 변환 
str(html_cont)
head(html_cont) # 데이터에서 6개만 출력

# 단계 4 : 컬럼명을 수정한 후 뒷부분 6개 관측치 보기 
names(html_cont) <- c("state", "y2010","y2011","y2012","y2013","y2014","y2015") 
tail(html_cont) # 뒤에서 6개 데이터 출력 


# 2. 데이터 저장하기 
# 2-1. 화면(콘솔) 출력
#   1) cat() 함수
x<-10
y<-20
z<-x*y
cat("x*y의 결과는", z ,"입니다.\n") # \n : 줄바꿈 , system.out.println(); 의 값 = cat 

#   2) print()함수 
print(z) # 변수 도는 수식만 출력 
print(z*10)
print("x*y=", z) # error

# 2-2. 파일에 데이터 저장 
#   1) sink() 함수를 이용한 파일 저장
getwd()
setwd("C:/workspaces/R/output")

install.packages("RSADBE")
library(RSADBE)
data("Severity_Counts") # Severity_Counts 데이터 셋 가져오기
Severity_Counts

sink("Severity.txt") # 저장할 파일 open 

severity<- Severity_Counts # 데이터 셋을 변수에 저장 
severity # 콘솔에 출려되지 않고, 파일에 저장

sink ()  # 오픈된 파일 close 

# 2) read.table() 함수 이용 파일 저장
# 탐색기를 이용하여 데이터 가져오기

# 패키지 설치와 java 실행환경 설정
install.packages("rJava")  #rJava 패키지 설치
install.packages("xlsx") 
# xlsx 패키지 설치 - 내부의 코어가 java로 되어 있다. 그래서 java가 설치되어야지 
# 다운 받을 수 있다.

Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_251') 
# java의 위치를 설정해줘야지 구동이 된다. 


# 관련 패키지 메모리 로드 
library(rJava)
library(xlsx)

studenttx <- read.xlsx(file.choose(), sheetIndex = 1, encoding  = "UTF-8")
studenttx

# write.table 기본 속성으로 저장 - 행이름과 따옴표가 붙는다. 
write.table(studenttx, "stdt.txt")

# 'row.names=F' 속성을 이용하여 행이름 제거하여 저장한다.
write.table(studenttx, "stdt2.txt" , row.names=F)

# 'quote=F' ; 속성을 이용하여 따옴표를 제거하여 저장 
write.table(studenttx, "stdt3.txt" , quote=F)

# 행 이름 제거 + 따옴표 제거 
write.table(studenttx, "stdt4.txt" , quote=F, row.names=F)


html_cont # 데이터프레임 확인
write.table(html_cont, "GNP_United States.txt" , row.name = F ) 
# row.name = F : 행의 이름을 붙이지 말고 저장(이미 이름 존재)

# 만들어 놓은 파일 읽어오기 
GNP_US <- read.table("GNP_United States.txt", sep = "", header = T)
GNP_US


# 3) write.xlsx() 함수 이용 파일 저장 - 엣셀 파일 저장 
install.packages("rJava")  #rJava 패키지 설치
install.packages("xlsx") 
# xlsx 패키지 설치 - 내부의 코어가 java로 되어 있다. 그래서 java가 설치되어야지 
# 다운 받을 수 있다.

Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_221') 
# java의 위치를 설정해줘야지 구동이 된다. 


# 관련 패키지 메모리 로드 
library(rJava)
library(xlsx)

st.df <- read.xlsx(file.choose(), sheetIndex = 1, encoding  = "UTF-8")
st.df

write.xlsx(st.df, "stuednttx.xlsx") # excel 형식으로 저장

# 4) write.csv() 함수 이용 파일 저장
#    - data.frame 형식의 데이터를 csv 형식으로 저장

write.csv(st.df, "stdf.csv", row.names = F, quote = F)
