# chap04_Control

####################################################
# chapter04-1. 연산자 / 제어문(조건문과 반복문)    #
####################################################

###################
##  1. 연산자    ##
###################

# 산술연산자

num1 <- 100 # 피연산자1
num2 <- 20  # 피연산자2

result <- num1 + num2  # 덧셈
result
result <- num1 - num2  # 뺄셈
result
result <- num1 * num2  # 곱셈
result
result <- num1 / num2  # 나눗셈
result

result <- num1 %% num2  # 나머지 연산자 - java와 다름 
result

result <- num1^2   # 제곱연산자(num1 ** 2)
result

result <- num1^num2   # 100의 20승(10의 40승과 동일한 결과)
result   # [1] 1e+40 -> 1 * 10^40 e표기법 동일하게 사용. 


# 비교(관계) 연산자
# (1) 동등비교
boolean <- num1 == num2 # 두 변수의 값이 같은지 비교 
boolean
boolean <- num1 != num2 # 두 변수의 값이 다른지 비교 
boolean

# (2) 크기비교
boolean <- num1 > num2 
boolean
boolean <- num1 >= num2 
boolean
boolean <- num1 < num2 
boolean
boolean <- num1 <= num2 
boolean

# 논리 연산자
# AND
logical <- num1 >= 50 & num2 <= 10
logical

# OR
logical <- num1 >= 50 | num2 <= 10
logical

x <- TRUE; y <- FALSE
xor(x, y)              #(xor FF = F, FT = T, TF = T, TT = F)
x <- TRUE; y <- TRUE
xor(x, y)

logical <- num1 >= 50
logical

logical <- !(num1 >= 50)
logical


#################
## 2. 조건문   ##
#################

# 1) if()
x <- 10
y <- 5
z <- x * y
z

#if(조건식){ 산술/비교/논리 연산자 
#    실행문1 <- 참
#}else{
#    실행문1 <- 거짓
#}

if(x*y > 40){ # 산술 > 비교 > 논리
  cat("x*y의 결과는 40이상입니다.\n")  # \n :줄바꿈
  cat("x*y = ", z, '\n')
  print(z)
}else{
  cat("x*y의 결과는 40미만입니다. x*y=", z, "\n")
}


# 학점 구하기
score <- scan()
score

if(score >= 90){ # 조건식1
  result = "A학점"
}else if(score >= 80){ # 조건식1
  result = "B학점"
}else if(score >= 70){ # 조건식2
  result = "C학점"
}else if(score >= 60){ # 조건식3
  result = "D학점"
}else{
  result = "F학점"
}

cat("당신의 학점은 ", result) # 당신의 학점은?
print(result)


# 2) ifelse(조건, 참, 거짓) - 3항 연산자 기능, 특정 조건을 통해서 간단히 전처리 할 수 있다. 
score <- c(78,95,85,65)
score
ifelse(score >= 80, "우수" , "노력") # "노력" "우수" "우수" "노력"

# ifelse() 응용
getwd()
setwd("C:/workspaces/R/data")

excel <- read.csv("excel.csv") # 반환형 : data.frame
excel

q1 <- excel$q1 # q1 변수값 추출 
ifelse(q1 >= 3, sqrt(q1), q1)  # sqrt : 루트를 입력해주는 함수 (3보다 큰 경우 사용용)
ifelse(q1 >= 2 & q1 <= 4, q1^2,q1)

# 3) swich문 
#   형식 swich(비교구문, 실행구문1, 실행구문2, 실행구문3...) 원하는 값을 읽어와주는 것. 
switch("name", id="hong", pwd="1234", age=25, name="홍길동") # 홍길동
switch("pwd", id="hong", pwd="1234", age=25, name="홍길동") # 1234

empname <- scan(what = "")
empname 

switch(empname, hong=250, lee=350, kim=200, kang=400)

# 4) which 문
#   - which()의 괄호내의 조건에 해당하는 위치(인텍스)를 출력하낟. 
#   - 벡터에서 사용 -> index 값 리턴

name <- c("kim" , "lee" , "choi" , "park")
which(name == "choi") # 3(index)

# 데이터프레임에서 사용 
# 서로 다른 자료형

no <- c(1:5) # 1~5 
name <- c("홍길동" , "이순신" , "강감찬" , "유관순", "김유신")
score <- c(85,78,89,90,74)

exam <- data.frame(학번 = no, 이름 = name, 성적 = score)
exam
#   학번   이름 성적
#1    1 홍길동   85
#2    2 이순신   78
#3    3 강감찬   89
#4    4 유관순   90
#5    5 김유신   74

which(exam$이름 == "유관순") # 4

exam[4,] 

# 학번   이름 성적
#   4   유관순 90

################################################################################
## 반복문 
################################################################################

# 1)  반복문 - for(변수 in 값){표현식} - 단일문 {} 생략 가능 

i <- c(1:10)
i

d <- numeric() # d변수를 numeric으로 setting , 빈 vector(숫자)

for(n in i){ # 10회 반복
  print (n*10)
  print (n)
  d[n] <- n*2
}  

d

for(n in i){
  if(n %% 2!=0){
    print(n) # %% : 나머지 값 - 홀수만 출력. 
  }
}

for(n in i){
  if(n %% 2==0){
    print(n) # %% : 나머지 값 - 짝수만 출력. 
  }
}


for(n in i){ # 결과적으로 홀수값만 출력.  - java의 for, each 문과 동일 
  if(n %% 2==0){
    next # 다음 문장장 skip 하고 for문으로 올라가서 수행하라. -> 반복문 계속 (자바의 continue 키워드와 동일.)
  }else{
    print(n) # %% : 나머지 값 - 홀수만 출력
  }
}

# 벡터 데이터 사용 예 
score <- c(85,95,98)
name <- c("홍길동" , "이순신" , "강감찬")
i <- 1 # 첨자로 사용되는 변수 
for(s in score){
  cat(name[i],"->" , s, "\n")
  i <- i+1
}

# 2) 반복문 - while (logical 값){}
i = 0

# 무한반복 되지 않도록 만들어야한다. 
while(i < 10){
  i <- i+1
  print(i)
}

################################################################################
## chapter04-2. 사용자 정의 함수와 내장 함수 
################################################################################

##1. 사용자 정의 함수 

# 함수 정의 형식
# 변수 <- function([매개변수]){
#             함수의 실행문
#         }


# 함수 호출 
#   - 변수([매개변수]) 

# 매개변수가 없는 함수 예 (변수 - vector, matrix, array, list, data.frame, function)
f1 <- function(){
  cat("매개변수 없는 함수")
}

f1() # 함수 호출 방법 

# 매개변수가 있는 함수 예 
f2 <- function(x){
  cat("x의 값 = " , x,  "\n")
}

f2(10) # 실인수
f2(c(1:10)) # 벡터 객체 전달 

# 리턴값이 있는 함수 예
f3 <- function(x,y){ # add : 지역 변수로 사용 { }안에서만 유효하다.   
  add <- x + y # 덧셈
  return (add)  # 결과값 반환 (java의 return과 동일)
}

add <- f3(10,30) # 함수 안에 있는 add와 다른 메모리 공간이다. (같은 공간x) 
add


# 기술 통계량을 계산하는 함수 정의 
# 파일 불러오기 
getwd()
setwd("C:/workspaces/R/data")

test <- read.csv("test.csv", header = T) # data.frame 으로 반환 
head(test)

#  A B C D E (컬럼이름)
#1 2 4 4 2 2
#2 1 2 2 2 2
#3 2 3 4 3 3
#4 3 5 5 3 3
#5 3 2 4 4 4
#6 4 3 3 4 2

# A 컬럼 요약통례량, 빈도수 구하기.

summary(test) # 요약 통계량. 
#  A               B               C               D              E            (컬럼이름)
# Min.   :1.000   Min.   :1.000   Min.   :1.000   Min.   :1.00   Min.   :1.000 (최소값) 
# 1st Qu.:2.000   1st Qu.:2.000   1st Qu.:3.000   1st Qu.:2.00   1st Qu.:3.000 (1분기) 
# Median :3.000   Median :3.000   Median :4.000   Median :2.00   Median :4.000 (중간값) 
# Mean   :2.734   Mean   :2.908   Mean   :3.622   Mean   :2.51   Mean   :3.386 (평균값) 
# 3rd Qu.:3.000   3rd Qu.:4.000   3rd Qu.:4.000   3rd Qu.:3.00   3rd Qu.:4.000 (3분기) 
# Max.   :5.000   Max.   :5.000   Max.   :5.000   Max.   :4.00   Max.   :5.000 (최댓값) 

table(test$A) # A 변수 대상 빈도 수 
# table 을 만들어주는 함수x , 요인형의 값을 전달 받으면 빈도수를 반환해주는 함수. 

#1   2   3   4   5 (A의 범주)
#30 133 156  80  3 (학목별 빈도수) / 설문에 의한 만족도 조사, 수집 

max(test$A) # 최대값
# [1] 5

min(test$A) # 최소값 
# [1] 1

length(test) # 항목(colume)의 개수 
# [1] 5


## 각 컬럼 단위 요약통계략과 빈도 수 구하기. 
data_pro <- function(x){
  
  for(idx in 1:length(x)){
    cat(idx, '번째 컬럼의 빈도분석 결과')
    print(table(x[idx]))
    cat('\n')
  }
  
  for(idx in 1:length(x)){
    f <- table(x[idx]) 
    cat(idx, '번째 컬럼의 최대값/최소값 \n')
    cat('max=', max(f), 'min=', min(x), '\n')
    
  }
}

data_pro(test) # 함수 호출 



# 분산과 표준편차를 구하는 함수 정의
z <- c(7,5,12,9,15,6) # x 변량 생성
var_sd <- function(x){
  var <- sum((x-mean(x))^2) / (length(x)-1) # 표본분산
  sd <-sqrt(var) # 표준편차 = 분산에 루르틀 씌어준 것 
  cat('표준분산:', var , '\n')
  cat('표본 표준편차:' , sd ,'\n')
}

var_sd(z)



# 결측치(NA=유효하지 않은값) 데이터 처리
data <- c(10,20,5,4,40,7,NA,6,3,NA,2,NA)
data
# [1] 10 20  5  4 40  7 NA  6  3 NA  2 NA

mean(data)
# [1] NA : 결과 값이 1개라도 NA가 존재한다면 NA로 출력한다. (NA = 유효하지 않은 값)
# 평균뿐 아니라 수식으로 계산되어지는 결과값은 NA가 출력된다. 

# 통계학및 연산과 관련된 수식 대부분의 함수는 매개변수로 na.rm 를 가지고 이싿. 
mean(data, na.rm = T) # na.rm : NA의 값을 지우고 계산. 
# [1] 10.77778



#구구단 출력 함수 
gugudan <- function(i,j){
  for(x in i){
    cat("==", x , "단 ==\n")
    
    for(y in j){
      cat(x,"x",y,"=",x*y , "\n")
    }
    cat("\n")
  }
}

i <- c(2:9) # 단 수 지정
j <- c(1:9) # 단 수와 곱해지는 수 지정 

gugudan(i,j)


# 결측치 데이터 처리 함수 

na <- function(x){
  # 1차: NA제거 
  print(x)
  print(mean(x, na.rm = T)) #na 항목을 제외하고 평균값 출력. 
  
  # 2차: NA를 0으로 대체 (데이터의 개수가 적을 때 사용)
  data <- ifelse(!is.na(x),x,0)  # is.na 결과가 T = 입력값 NA , NA 이면 0으로 대체 
  print(x)
  print(mean(data))
  
  # 3차: NA를 평균으로 대체 
  data2 <- ifelse(!is.na(x),x,round(mean(x, na.rm = T),2)) 
  # x,mean(x, na.rm = T) , 소수점 이하 5~6자리까지 출력
  # rounb 를 활용하여 소수점 이하 2자리까지만 출력
  
  print(data2)
  print(mean(data2))
}

na(data) # 함수 호출 
# 결측치를 무조건 제거하면 정화한 통계량을 얻을 수 없으며, 데이터가 손실될 수 있다. 


# 1차: NA제거 
# [1] 10 20  5  4 40  7 NA  6  3 NA  2 NA
# [1] 10.77778

# 2차: NA를 0으로 대체
# [1] 10 20  5  4 40  7 NA  6  3 NA  2 NA
# [1] 8.083333

# 3차: NA를 평균으로 대체
# [1] 10.00 20.00  5.00  4.00 40.00  7.00 10.78  6.00  3.00 10.78  2.00 10.78
# [1] 10.77833



## 2. 주요 내장 함수 

# 행 단위, 컬럼 단위 합계와 평균 구하기 

# 단계1 : 데이터 셋 불러오기 
install.packages("RSADBE")
library(RSADBE)

data(Bug_Metrics_Software)
class(Bug_Metrics_Software)
# [1] "xtabs" "table"

Bug_Metrics_Software[,,1] # 제품 출시 전 
#Bugs
#Software   Bugs NT.Bugs Major Critical H.Priority
#JDT     11605   10119  1135      432        459
#PDE      5803    4191   362      100         96
#Equinox   325    1393   156       71         14
#Lucene   1714    1714     0        0          0
#Mylyn   14577    6806   592      235       8804

Bug_Metrics_Software[,,2] # 제품 출시 후 
#Bugs
#Software  Bugs NT.Bugs Major Critical H.Priority
#JDT      374      17    35       10          3
#PDE      341      14    57        6          0
#Equinox  244       3     4        1          0
#Lucene    97       0     0        0          0
#Mylyn    340     187    18        3         36


# 단계2 : 소프트웨어 발표 전 행 단위 합계와 평균 구하기 
rowSums(Bug_Metrics_Software[,,1])
#JDT     PDE Equinox  Lucene   Mylyn 
#23750   10552    1959    3428   31014

rowMeans(Bug_Metrics_Software[,,1])
#JDT     PDE Equinox  Lucene   Mylyn 
#4750.0  2110.4   391.8   685.6  6202.8 

# 단계3 : 소프트웨어 발표 전 열 단위 합계와 평균 구하기 
colSums(Bug_Metrics_Software[,,1])
#Bugs    NT.Bugs      Major   Critical H.Priority 
#34024      24223       2245        838       9373 

colMeans(Bug_Metrics_Software[,,1])
#Bugs    NT.Bugs      Major   Critical H.Priority 
#6804.8     4844.6      449.0      167.6     1874.6 



# 기술 통계량 관련 내장 함수 사용 예 
seq(-2,2, by= .2) # (시작값, 마지막 값, 증가값)
# [1] -2.0 -1.8 -1.6 -1.4 -1.2 -1.0 -0.8 -0.6 -0.4 -0.2  0.0  0.2  0.4  0.6  0.8  1.0  1.2  1.4  1.6  1.8  2.0
vec <- 1:10 
vec
# [1]  1  2  3  4  5  6  7  8  9 10

min(vec)
# [1] 1 (최소값)

max(vec)
# [1] 10 (최대값)

range(vec)
# [1]  1(최소값) 10(최대값)

mean(vec)
# [1] 5.5 (평균값)

median(vec)
# [1] 5.5 (데이터의 중간값)

sum(vec)
# [1] 55 (총합)

sd(rnorm(10))
# [1] 0.991409 (표준편차)

table(vec) # 요인의 빈도수 
vec 
# 1  2  3  4  5  6  7  8  9 10 
# 1  1  1  1  1  1  1  1  1  1 



# 난수와 확률 분포 관계 
# 난수 : 기준이 되어지는 값을 지정해서 , 그 값이 절대 중복되지 않는 개념으로 수를 발생시켜 
# 우리가 보기에는 난수처럼 보이게 하는 것이다. (default 값 : 현재 시간의 1/1000초 기준)

# 1 단계 : 정규 분포 (연속형)의 난수 생성
n <- 1000
r <- rnorm(n, mean = 0, sd = 1) # 평균 0, 표준편차 1 = 정규 분포 
hist(r) # 대칭성



# 2 단계 : 균등분포(연속형)의 난수 생성
n <- 1000
r2 <- runif(n, min = 0, max= 1) # 0 < r2 < 1 
hist(r2)



# 3 단계 : 이항분포(이산형) 난수 생성
n <- 20
rbinom(n, 1, prob = 1/2) # 1/2 의 확률로 20개의 이상변수를 0과 1의 값을 가지는 이항분포를 생성 
# [1] 0 1 0 1 0 0 0 0 0 1 1 0 0 1 1 0 1 0 0 0

rbinom(n, 2, prob = 1/2) # 1/2 의 확률로 20개의 이상변수를 0 ~ 2의 값을 가지는 이항분포를 생성 
# [1] 2 2 1 1 2 1 1 1 2 0 1 0 0 2 1 2 0 1 1 1

rbinom(n, 10, prob = 1/2) # 1/2 의 확률로 20개의 이상변수를 0 ~ 10의 값을 가지는 이항분포를 생성 
# [1] 3 3 6 4 4 3 7 3 5 7 6 6 5 5 4 4 3 3 5 7

n <- 1000
rbinom(n,5,prob = 1/6)



# 4 단계 : 종자값(seed)으로  동일한 난수 생성. 
rnorm(5, mean=0, sd=1) # 정규 분포 (평균 0, 표준편차 1)

#[1]  0.7393503  0.6653646 -0.5210477 -1.3716350 -1.2954320
#[1] -0.02988800  0.05601044 -0.29434405 -0.67715103  0.45006390
#[1]  0.46050159 -0.55269490 -0.01527421 -0.24496429 -0.05962877

# 불규칙적인 느낌으로 추력 된다.(random)

set.seed(123)
rnorm(5, mean=0, sd=1)

#[1] -0.56047565 -0.23017749  1.55870831  0.07050839  0.12928774
#[1] -0.56047565 -0.23017749  1.55870831  0.07050839  0.12928774

# seed 값을 통이시키면 같은 값이 출력된다. 



# 수학 관련 내장함수 사용 예 

vec <- 1:10 # combine함수 생략 가능 
prod(vec) # product : 벡터 원소들의 곱셈
# [1] 3628800 (1*2*3*4*...*10)

factorial(3)
# [1] 6 

abs(-5) # 절대값 
# [1] 5

sqrt(16) # 제곱근
# [1] 4

log(10) # 10의 자연로그 (밑수가 e)
# [1] 2.302585

log10(10) # 10의 일반로그(밑수가 10)
# [1] 1




# 집합연산 내장함수 
x <- c(1,3,5,7,9)
y <- c(3,7)

union(x,y) # 집합 x와y의 합집합
# [1] 1 3 5 7 9

intersect (x, y) # 집합 x와y의 교집합
# [1] 3 7

setequal(x, y) # x와y의동일성테스트
# [1] FALSE 

setdiff(x, y) # x의모든 원소중 y에는 없는 x와y의차집합
# [1] 1 5 9



