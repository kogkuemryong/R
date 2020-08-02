# chap10_DescriptiveStatistics

########################################################
##  Chapter10. 기술 통계(Descriptive Statistics) 분석  
########################################################

## 1. 기술 통계 개요.

# 대표값:평균(Mean), 합계(Sum), 중위수(Median), 최빈수(mode), 사분위수(quartile) 등.

# 산포도:분산(Variance), 표준편차(Standard Deviation), 최소값(Minimum), 최대값(Maximum), 범위(Range) 등 

# 비대칭도:왜도(Skewness), 첨도(Kurtosis)


## 1.1 평균과 분산 그리고 표준편차 
score1 <- c(85, 90, 93, 86, 82)
score2 <- c(85, 90, 93, 46, 42)
score3 <- c(100, 100, 54, 50, 52)


# 평균 
mean(score1)  # [1] 87.2 : 평균값
mean(score2)  # [1] 71.2 : 평균값
mean(score3)  # [1] 71.2 : 평균값


# 중앙값(median:중위수) - 모든 데이터를 크기 순서대로 정렬시킨 후 가운데 있는 값을 의미.
# ex) 100, 100, 54, 50, 52 : 중앙값 -> 54
median(score3) # 54

# ex) 6, 6, 7, 8, 9, 10
num <- c(6, 6, 7, 8, 9, 10)
median(num) # 7.5(=(7+8)/2)


# 편차(Deviation) : 평균값을 기준으로 각 값의 차이. 즉, 평균과 해당값의 차이.

# 제곱평균(평균제곱) : 편차 값을 제곱해서 마이너스 값을 플러스 값으로 바꾼 후 평균을 구하는 방법.
# ex) ((100-71.2)^2+(100-71.2)^2+(54-71.2)^2+(50-71.2)^2+(52-71.2)^2) / 5 = 554.56

((100-71.2)^2+(100-71.2)^2+(54-71.2)^2+(50-71.2)^2+(52-71.2)^2) / 5 

# 분산(Variance) : 편차 값을 제곱해서 나온 값.

# 표준편차(Standard Deviation:SD) : 분산 값에 루트를 적용해서 제곱을 제거한 값. ex) 23.55(sqart(554.56))

score <- c(100, 100, 54, 50, 52)
mean(score)


# 자유도(degree of freedom) : 표본의 분산과 표준편차를 계산할 때 나누는 분모의 수를 (모집단-1)개로 계산하여 주어진 데이터에서 표본을 자유롭게 뽑을수 있는 경우의수를 의미. 표본을 추출해서 표본의 분산과 표준 편차를 계산할 때는 항상 자유도를 분모로 사용함.

median(score1) # [1] 86
score1 <- c(85, 90, 93, 86, 82)
mean(score1)
# ((85-87.2)^2+(90-87.2)^2+(93-87.2)^2+(86-87.2)^2+(82-87.2)^2)/5 = 14.9
var(score1)    # [1] 18.7 (4로 나눈 값(자유도))
sd(score1)     # [1] 4.32435


# 평균의 종류
# 1) 산술평균 : 모든 값을 더한 후 값의 개수만큼 나눈 후 나오는 값을 의미.

# 2) 상승평균/기하평균 : %로 평균 비율을 구할 때 방법.
#   ex) 회사의 연매출 10억 인 회사가 작년에 10% 성장 후 올해 2% 감소했다면 2년 평균 성장률은 어떻게 될까요?
#   ans) squart(1.1*0.98) = 1.04 : 4% 성장.


# 3) 제곱평균 : 각 값의 제곱의 평균을 구한 후 루트를 적용해서 구하는 평균.

# 4) 조화평균 : 주로 평균 속도를 구할 때 사용하는 방법.
#   ex) 서울에서 강원도로 휴가는 가는데 갈 때는 안 막혀서 시속 100km로 갔는데, 올 때는 너무 막혀서 시속 60km였다면 왕복 평균 속력은 얼마일까요?
#   ans) 조화 평균의 식 : 2xy / (x+y) = 2(100*60) / (100+60)



# 표준화와 표준값 
# 1) 표준화 : 모든 값들의 표준값을 정해서 그 값을 기준으로 차이를 구해서 비교하는 방법.
# 2) 표준값 = (각데이터 - 평균) / 표준편차 
# 3) 편차값 = 표준값 * 10 + 50


# 2. 척도별 기술 통계량 구하기 

# 연속형 변수 : 양적인 크기를 가지는 변수  (키) - > 등간척도, 비율척도 
# 범주형 변수 : 크기를 가지지 않는 변수 (성별) -> 명목척도, 서열 척도

# 명목척도 : 단순히 속성을 분류핛 목적으로 명목상 숫자를 부여하는 척도, 연산 불가능한 변수

# 서열척도 : 순서관계를 밝혀주는 척도(연산 불가능핚 변수) - 설문의 종류에 따라서 달라진다. 
# (선호도) - 직급

# 등간척도 : 균일한 분포를 가지면서 연산이 가능

# 비율척도 : 척도의 수가 등간 



# 실습 데이터 가져오기 
data <-read.csv("C:/workspaces/R/data/descriptive.csv",header = T)
View(data)

# 데이터 특성보기 
dim(data) # 300   8 - 차원보기 
length(data) # 8 (컬럼 수)
length(data$survey) # 300(데이터 수)
str(data) # 'data.frame':	300 obs. of  8 variables: + 컬럼의 이름 + 자료형 출력 
str(data$survey) #  int [1:300] 1 2 1 4 3 3 NA NA NA 1 ...

# 데이터 특성(최소, 최대, 중위수, 평균, 분위수ㅡ 노이즈-NA) 제공
summary(data)

# 2.1 명목 척도: 단순히 속성을 분류핛 목적으로 명목상 숫자를 부여하는 척도, 연산 불가능한 변수
length(data$gender) # 300

summary(data$gender)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.00    1.00    1.00    1.42    2.00    5.00 

table(data$gender) # 각 성별 빈도 수 - outlier(이상치) -> 0,5 
# 0   1   2   5 
# 2 173 124   1 

# 이상치 제거 
data <- subset(data, data$gender==1 | data$gender ==2) # 성별 outlier 제거
x<- table(data$gender) # 성별에 대한 빈도수 저장 
x
# 1   2 
# 173 124 

x11()
barplot(x) # 범주형(명목/서열 척도) 시각화 -> 막대 차트 

# 구성비율 계산 
prop.table(x) # 비율계산 : 0 < x < 1 사이의 값 
#     1         2 
# 0.5824916 0.4175084 

y <- prop.table(x)
round(y*100,2) # 백분율 적용(소수점 2자리)
#   1     2 
# 58.25 41.75 


# 2.2 서열 척도 : 순서관계를 밝혀주는 척도(연산 불가능핚 변수) - 설문의 종류에 따라서 달라진다. 
# (선호도) - 직급

length(data$level) # [1] 297 : 학력수준 - 서열 (크기적인 개념 포함)
summary(data$level) # 명목척도와 함께 의미 없음 
table(data$level) # 빈도분석 - 의미있음 
#  1   2   3 
# 115  99  70

# 학력 수준(level) 변수의 빈도 수 시각화
x1 <- table(data$level) # 각 학력수준에 빈도수 저장. 
barplot(x1) # 명목/ 서열 척도 -> 막대차트

# 구성비율 계산
y <- prop.table(x1)
round(y*100,2) # 백분율 적용(소주점 2자리)
#     1     2     3 
#   40.49 34.86 24.65 

# 2.3 등간척도 기술 통계량
# 등간척도 : 측정대상의 속성에 대한 각 수준 간의 간격이 동일한 척도, 균일한 분포를 가지면서 연산이 가능(수치로서의 개념 존재)

# 등간척도와 비율척도의 차이는 절대 원점(0)의 의미를 가지는가 가지지 않는가 이다. 
# - 등간척도는 절대원점(0)을 가지고 있지 않음(의미 없음) 
# - 비율척도는 절대원점(0)을 가지고 있는 척도(0을 기준으로 한 수치)


# 만족도(survey) 변수 

survey <- data$survey
survey

summary(survey) #만족도(5점척도)인 경우 의미 있음 -> 평균간 : 2.605
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#  1.000   2.000   3.000   2.605   3.000   5.000     112 
# NA의 값이 112개나 되기 때문에 배제해 버리면 sample의 데이터가 많이 사라지므로 문제를 결과가 잘못 이상하게 출력될 수 있다. 

x1 <- table(survey) # 빈도수 
x1
# survey
# 1  2  3  4  5 
# 20 72 61 25  7 

hist(survey) # 등간척도 시각화(연속형 변수)  
pie(x1)
barplot(x1)

# 2.4 비율척도 기술 통계량
# 비율척도 : 척도의 수가 등간 , 사측 연산 가능 

# 생황비(cost) 변수 대상 요약 통계량 구하기 
length(data$cost) # 297 (레코드 개수)
summary(data$cost) # 요약통계량 - 의미 있음(mean) / Mean = 8.784 , Median = 5.4
#    Min.    1st Qu.  Median    Mean     3rd Qu.  Max.    NA's 
# -457.200    4.400    5.400    8.784    6.300  675.000    30 

plot(data$cost) # 분포도 확인 

# 데이터 정제(이상치 제거)
data <- subset(data, data$cost>=2 & data$cost <= 10) # 총점기준 
data 

plot(data$cost)
x <- data$cost
mean(x) # 5.354032

# (1) 대표값 구하기 

# 평균이 극단치에 영향을 받는 경우 = 중위수(median) 대체 
median(x) # 5.4

# 생활비(cost) 변수 대상 대표값 구하기 
mean(x)
median(x)
sort(x) # 오름차순(default) = decreasing = F 
sort(x, decreasing = T) # 내림차순

# 생활비(cost) 변수 대상 사분위수 구하기
#quantile() : 분위별 결과 출력 
quantile(x, 1/4) # 1분위
quantile(x, 2/4) # 2분위
quantile(x, 3/4) # 3분위
quantile(x, 4/4) # 4분위

# 생활비(cost) 변수의 최빈수(빈도 수가 가장 많은 변수) 구하기 
length(x) # [1] 248
x.t <- table(x)
x.t

max(x.t) # [1] 18

x.m <- rbind(x.t)
x.m
class(x.m) # [1] "matrix"
str(x.m)
which(x.m[1, ] == 18) # 1행 전체를 대상으로 18값 찾기.
# 5 
# 19 : index 

x.df <- as.data.frame(x.m)
class(x.df)
which(x.df[1, ] == 18) # [1] 19(index)
x.df[1, 19] # [1] 18
attributes(x.df) # $names, $class, $row.names
names(x.df[19]) # [1] "5"


# (2) 산포도 구하기 

# 생활비(cost) 변수 대상 산포도 구하기 
var(x) # 분산, [1] 1.296826
sd(x)  # 표준편차, [1] 1.138783

# 분산 -> 표준편차
sqrt(var(x))

# 표준편차 -> 분산 
sd(x) ** 2


# (3) 빈도 분석 

# 생활비(cost) 변수의 빈도분석과 시각화 
table(data$cost)

hist(data$cost) # 히스토그램 시각화
plot(data$cost) # 산점도 시각화 

# 연속형 변수 범주화 
data$cost2[data$cost >= 2 & data$cost < 4] <- 1
data$cost2[data$cost >= 4 & data$cost < 7] <- 2
data$cost2[data$cost >= 7] <- 3

x <- table(data$cost2)
barplot(x)
pie(x)


# 2.5 비대칭도 구하기 
install.packages("moments")
library(moments)
cost <- data$cost
cost

# 왜도 - 평균을 중심으로 기울어진 정도.
skewness(cost) # [1] -0.297234


# 첨도 - 표준 정규 분포와 비교하여 얼마나 뽀족한가 측정 지표 
kurtosis(cost) # [1] 2.674163

# 기본 히스토그램 
hist(cost)


# 히스토그램 확률밀도/표준 정규 분포 곡선
hist(cost, freq = F)

# 확률 밀도 분포 곡선 
lines(density(cost), col='blue')

# 표준정규분포 곡선 
x <- seq(0, 8, 0.1)
curve(dnorm(x, mean(cost), sd(cost)), col='red', add = T)


# attach() / detach() 함수로 기술 통계량 구하기 
# - 기존 선언 변수와 컬럼의 이름이 중복시 기존 변수가 global 변수로 잡힘.
# - attach() 부터 detach()가 올때까지 객체의 이름 없이 사용해도 문제 없이 수행 
# - detach() 이후 부터는 객체 이름을 넣어줘야 함

search()
attach(iris)
search()
length(Sepal.Width)
summary(Sepal.Width) # 요약 통계량 - 의미있음(mean)
mean(Sepal.Width)
min(Sepal.Width)
max(Sepal.Width)
range(Sepal.Width) # [1] 2.1(min) ~ 7.9(max)
var(Sepal.Width, na.rm = T)

sd <- sd(Sepal.Width, na.rm = T)
sqrt(var(Sepal.Width, na.rm=T))

sort(Sepal.Width) # 오름차순
sort(Sepal.Width, decreasing = T) # 내림차순 
detach(iris)

attach(data) # data$cost 접근.
search()
length(cost) # [1] 248
summary(cost) # 요약 통계량 - 의미있음(mean)
mean(cost)
min(cost)
max(cost)
range(cost) # [1] 2.1(min) ~ 7.9(max)
var(cost, na.rm = T)

sd <- sd(cost, na.rm = T)
sqrt(var(cost, na.rm=T))

sort(cost) # 오름차순
sort(cost, decreasing = T) # 내림차순 
detach(data)


## 3. 패키지 이용 기술 통계량 구하기 

# 3.1 Hmisc 패키지 이용 
install.packages("Hmisc")
library(Hmisc)

View(data)
# 전체 변수 대상 기술통계량 제공 - 빈도와 비율 데이터 일괄 수행 
describe(data) 


# 개별 변수 기술 통계량
describe(data$gender) # 특정 변수(명목) 기술통계량-범주/빈도수/비율 제공.
describe(data$age) # 특정 변수(비율) 기술통계량 - lowest / highest

summary(data$age)


# 3.2 prettyR 패키지 이용 
install.packages("prettyR")
library(prettyR)

# 전체 변수 대상 
freq(data) # 각 변수별 : 빈도, 결측치, 백분율, 특징-소수점 제공 


# 개별 변수 대상
freq(data$gender) # 빈도, 결측치, 백분율


# 4. 기술 통계량 보고서 작성

# 4.1 기술 통계량 구하기 

# 변수 리코딩과 빈도분석

# 1) 거주지역 변수 리코딩과 비율 계산 
data$resident2[data$resident==1] <- "특별시"
data$resident2[data$resident>=2 & data$resident<=4] <- "광역시"
data$resident2[data$resident==5] <- "시구군"

freq(data$resident2)
#     특별시 광역시 시구군   NA
#      110     87     34     17    : 빈도수
# %    44.4   35.1   13.7    6.9 
# %!NA 47.6   37.7   14.7          : 비율


# 2) 성별 변수 리코딩과 비율 계산 
data$gender2[data$gender==1] <- "남자"
data$gender2[data$gender==2] <- "여자"

freq(data$gender2)
#     남자 여자  NA
#     146  102    0
#%    58.9 41.1   0 
#%!NA 58.9 41.1 


# 3) 나이 변수 리코딩과 비율 계산
summary(data$age)

data$age2[data$age <= 45] <- "중년층"
data$age2[data$age >= 46 & data$age <= 59] <- "장년층"
data$age2[data$age >= 60] <- "노년층"

freq(data$age2)
#    장년층 노년층 중년층  NA
#     169     61    18      0
#%    68.1   24.6   7.3     0 
#%!NA 68.1   24.6   7.3 


# 4) 학력 수준 변수 리코딩과 비율계산 
data$level2[data$level == 1] <- "고졸"
data$level2[data$level == 2] <- "대졸"
data$level2[data$level == 3] <- "대학원졸"

freq(data$level2)
#     고졸 대졸 대학원졸  NA
#      93   86     57     12
#%     37.5 34.7   23     4.8 
#%!NA  39.4 36.4   24.2 


# 5) 합격 여부 변수 리코딩과 비율 계산
data$pass2[data$pass == 1] <- "합격"
data$pass2[data$pass == 2] <- "불합격"

freq(data$pass2)
#     합격 불합격 NA
#      139   96   13
#%      56  38.7  5.2 
#%!NA  59.1 40.9


# 최종 결론과 관련된 내용은 pdf를 참조.









