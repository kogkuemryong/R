# chap01_Basic : 주석문 기호 (라인을 주석문 처리한다.)

######################################################
#               chapter01. R 설치와 개요             #
######################################################

# 주요 단축기 
# - script 실행 : ctrl + Enter , ctrtl + R 
# - script 저장 : ctrl + s 

print("Hello, R!!!") # ctrl + Enter 

# 패키지와 session 보기 
# R package 보기

available.packages() # 패키지 상세보기 

dim(available.packages()) #15786  |   17 

# R Session 보기 
sessionInfo()

# 설치된 패키지 목록 확인 
installed.packages()

# 패키지 사용법 
install.packages("stringr") # 반드시 "" 넣어줘야 한다. 
library("stringr") #메모리에 로딩 : "" 생략 가능 
search()

# 패키지 제거 
remove.packages("stringr")

# 데이터 셋 보기 
data()

# 기본 데이터 셋으로 히스토그램 그리기 
# 단계 1 : 빈도수(frequency)를 기준으로 히스토그램 그리기 
hist(Nile)

# 단계 2 : 밀도(density)를 기준으로 히스토그램 그리기 
hist(Nile, freq = FALSE)

# 단계 3 : 단계 2의 결과에 분포곡선(line)을 추가 
lines(density(Nile))

# 히스토그램을 파일에 저장하기. '
par(mfrow=c(1,1)) # plots 영역에 1개 그래프 표시.  
pdf("C:/workspaces/R/output/batch.pdf")
hist(rnorm(20)) # 난수에 대한 히스토리그램 그리기. 
dev.off()


## 변수와 자료형
# 변수 사용 예 
age <- 25
print(age)
age
age <- 35

# 변수.멤버 / (.) 은 연산자 아니라 이름으로 사용
goods.model <- "lg-320" # 상품 모델명.
goods.name <- "냉장고" 
goods.price <- 850000
goods.desc <- "동급 최고 품질/사양"
# 그룹화 되어 있는 것처럼 변수의 이름을 사용한다.
# 하나의 대상의 특징이 열거 시키는 것(변수지만 객체처럼 사용)

var1 <- 100
Var1 <- 200

# 숫자로 시작
# 100num <- 50 error

# 자료형 
int <- 20 # 숫자형(정수)
double <- 3.14 #숫자형(실수)
string <- " 홍길동" # 문자형
boolean <- TRUE # 진리값 : TRUE(T)/FALSE(F) 
#(대문자만 사용가능, 약자 사용 가능)  
boolean <- 3.14

# 자료형 확인
is.numeric(int) # 숫자형인지 아닌지 확인 / TRUE
is.integer(int) # FALSE : int는 정수 값도 부동 소수점으로 관리 
is.double(int) # TRUE : 주의 

# 자료형 변환 
castInt <- as.integer(int) # 정수형으로 형변환 
is.integer(castInt) #TRUE 

is.numeric(double) #TRUE
is.double(double) #TRUE

is.character(string) # TRUE
is.character(boolean) # FALSE
is.character("boolean") # TRUE 

# 컴바인 함수 
x <- c(1, 2, 3)

# 숫자 원소를 문자 원소로 형변환
y <- c(1,2,"3") 
y # "1" "2" "3"

result <- x*3 
result # 3 6 9

result <- y*5 # Error in y * 5 : 이항연산자에 수치가 아닌 인수입니다. 

result <- as.integer(y) * 5
result 

# 스칼라 변수 사용 예 
name <- "홍길동"
name 

# 벡터 변수 사용 예
y <- c(1,2,"3") 
y # "1" "2" "3"

# 복소수형 자료 생성과 형변환
z <- 5.3 -3i 
Re(z) # 실수
Im(z) # 허수
is.complex(z) # 복소수의 여부 확인 
as.complex(5.3) # 강제 복소수형으로 형변환

# 스칼라 변수의 자료형 
mode(int) # "numeric"
mode(string) # "character"
mode(boolean) # "logical"
mode(double) # "numeric"

# 문자 벡터와 그래프 생성
gender <- c('man','woman','woman','man','woman')
gender
mode(gender) # character

plot(gender) # error : plot() 함수는 숫자 자료만을 대상으로 그래프를 생성할 수 있음. 

# 요인형 변환 
# as.factor() 함수 이용 범주(요인)형 변환
Ngender <- as.factor(gender)
Ngender 
table(Ngender)

# Factor형 변수로 차트 그리기 
plot(Ngender)
mode(Ngender) # "numeric"
class(Ngender) # "factor" 자료구조에 대한 정보 
is.factor(Ngender) # TRUE

# factor() 함수 이용 Factor형 변환 
args(factor) # 함수에 대한 정의를 보여준다. (6개의 입력 받도록 되어 있다)
ogender <- factor(x=gender, levels = c('woman','man')) 
ogender

# 도움말 보기 
help(factor)
?factor
?sum

# 함수 parameter 보기 
args(sum)

# 함수 사용 예제 
example(sum) # 예제만 보여주는 함수 

# 순서 없는 요인(default값)과 순서 있는 요인형 변수(factor 함수 활룡 )로 차트 그리기 
par(mfrow=c(1,2))
plot(Ngender) # 순서 없는 요인
plot(ogender) # 순서 있는 요인

# 작업 공간 지정
getwd()
setwd("C:/workspaces/R/output")
