# chap07_DataPreprocessing


####################################################
#           chapter07. 데이터 전처리               #
####################################################

# - 자료분석에 필요한 데이터를 대상으로 불필요한 데이터를 처리하는 필터링과 전처리 방법에 대해서 알아본다. 

# 1. EDA(Exploratory Data Analysis) - 탐색적 자료 분석. 
#   : 수집한 자료를 다양한 각도에서 관찰하고 이해하는 과정으로 그래프나 통계적 방법을 이용해서 자료를 직관적으로 파악하는 과정.

# 1.1 데이터 셋 보기 

# 데이터 가져오기 
getwd()
setwd("C:/workspaces/R/data")

dataset <- read.csv("dataset.csv", header = T) # 헤더가 있는 경우
head(dataset)
View(dataset)

# 1) 데이터 조회 
#   - 탐색적 데이터 북석을 위한 데이터 조회 


# 전체 데이터 보기 
print(dataset) # 콘솔창 출력
View(dataset) # utils pakage, 뷰어창 출력


# 데이터의 앞부분과 뒷부분 보기 
head(dataset)
tail(dataset)



# 1.2 데이터 셋 구조 보기 

# 데이터 셋 구조
names(dataset) #변수명(컬럼)
attributes(dataset) # $names(컬럼명), $class(데이터 구조), $row.names(행의 이름 - 이름이 없으면 숫자 default 값 출력)  
str(dataset) # 데이터 구조 보기 (자료구조/관측치(행),컬럼(열)/자료형)



# 1.3 데이터 셋 조회
dataset$age # 데이터 셋 접근 방법. 
dataset$resident

length(dataset) # 7 : 컬럼의 개수  - 자료 구조에 따라서 정도의 inform 이 다르다. 
length(dataset$age) # 300 : 행(데아터)의 갯수 - 변수의 이름을 넣어주면 전체 데이터 개수를 알려준다. 


# 조회 결과 변수 저장
x <- dataset$gender
y <- dataset$price


# 산점도 형태로 변수 조회 
plot(x,y) # 성별과 구매금액 분포 - 극단치(적절하지 않은 값) 발견 
# <범용적 사용 :  전처리 작업이 올바로 이루어졌는지 확인, 분석 결과를 시각화 >


# 산점도 형태로 변수 조회
plot(dataset$price) # 특정 항목의 특징을 파악하는 용도로 사용. 


# ["컬럼명'] 형식으로 특정 변수 조회 
dataset["gender"] # = dataset$gender
dataset["price"]


#[색인(index)] 형식으로 변수 조회 
dataset[2] # 두번째 컬럼(gender) - 출력형태: 열 중심 
dataset[6] # price
head(dataset[6])
dataset[3,] # 3행의 데이터 전체 
dataset[,3] # 3열의 데이터 전체 출력 = dataset[3] 


# 두 개 이상의 [색인(index)] 형식으로 변수 조회
dataset[c("job","price")] # job , price 의 전체 데이터 출력
dataset[c(2,6)]  # gender/price 의 전체 데이터 출력력


dataset[c(1,2,3)] # combine 함수로 개수의 제한 없이 불러 올 수 있다. 
dataset[c(1:3)] # 연속된 숫자
dataset[1:3] # c 생략 가능 

dataset[c(2,4:6,3,1)] # 순서를 변경하여도 결과 데이터를 가져올 수 있다. - gender age position  price job resident
dataset[-c(2)] # (-) 제외 하는 것으로 dataset[c(1,3:7)] 동일하다. 

# dataset 의 특정 행/ 열을 조회하는 경우
dataset[,c(2:4)] # 2~4 열 출력
dataset[c(2:4),] # 2~4  행 출력
dataset[-c(1:100),]  # 1~100핵 제외, 101~300행까지 출력


# 2. 결측치(NA) 처리

# 2.1 결측치 확인

# summary() 함수 이용
summary(dataset$price)
# summary(dataset$price)
#   Min    1st Qu.    Median    Mean    3rd Qu.  Max.       NA's 
#-457.200    4.425    5.400    8.752    6.300  675.000       30 

sum(dataset$price) # NA가 하나라도 담겨 있으면 결과값으로 [1] NA 를 반환한다. 

# 2.2 결측치 제거

# sum() 함수에서 제공되는 속성 이용
sum(dataset$price, na.rm = T) # NA의 값 제외 

# 결측데이터 제거 함수 이용
price2 <- na.omit(dataset$price) 
# NA 항목을 다 삭제 하기 때문에 NA가 담겨있는 같은 행의 다른 항목들의 데이터들도 삭제 될 수 있는 위험이 있다. 
# 데이터가 적을수록 분석결과가 신뢰도가 예측도가 떨어질 수 있다. 
sum(price2)
length(price2) # 270 


# 2.3 결측치 대체 

# 결측치를 0으로 대체하기 
x <- dataset$price # price vector 생성
head(x)  # [1] 5.1 4.2 4.7 3.5 5.0 5.4

dataset$price2 <- ifelse(is.na(x),0,x) # true 일 때 0, false 일 때 x로 출력.  / $를 붙이고 컬럼 이름을 넣으면 추가 
ifelse(!is.na(x),x,0) # true 일 때 x, false 일 때 0로 출력. 

View(dataset)

sum(dataset$price2) # [1] 2362.9


# 결측치를 평균으로 대체하기 

x <- dataset$price # price vector 생성
head(x)  # [1] 5.1 4.2 4.7 3.5 5.0 5.4

dataset$price3 <- ifelse(is.na(x),round(mean(x, na.rm = T),2),x) # true 일 때 평균 : round(mean(x, na.rm = T),2), false 일 때 x로 출력.  / $를 붙이고 컬럼 이름을 넣으면 추가
# 넣어준 평균 안에 이상치가 존재할 수 있기 때문에 결과의 값의 오류가 생길 수 있다. 

ifelse(!is.na(x),x,round(mean(x, na.rm = T),2)) # true 일 때 x, false 일 때 평균: round(mean(x, na.rm = T),2) 출력. 

View(dataset)

sum(dataset$price3) # [1] 2625.4


# 3. 이상치(극단치) 처리 /  이상치(극단치) - 예(gender - m/w 아닌 값)

# 3.1 범주형 변수 극다치 처리 - 이산변수 (정수형 변수)

table(dataset$gender)
#  0   1   2   5  (요인-범주) / 1,2 = 여자, 남자 / 0,5 = 이상치 결과
#  2  173 124  1  (빈도수)

pie(table(dataset$gender)) # 파이차트 

# subset() 함수를 이용한 데이터 정제하기 
dataset <-subset(dataset, gender==1 | gender==2) # // 1,2 외의 값 필터링 
str(dataset) # 'data.frame':	297 obs. of  9 variables: / 300 -> 297

View(dataset)
length(dataset$gender) # [1] 297

pie(table(dataset$gender))


# 3.2 연속형 변수의 이상치 처리 
dataset <- read.csv('dataset.csv', header = T)
dataset$price 
plot(dataset$price) # plot 차트 
summary(dataset$price) # 다양한 값 출력 (Min, 1st.Qu, Median, Mean, 3rd Qu, Max, NA's) 

# price 변수의 데이터 정제와 시각화
dataset2 <- subset(dataset, price >=2 & price <= 8)
length(dataset2$price) # [1] 251 / 이상치 49개 

stem(dataset2$price) # 줄기와 잎 도표 보기 (n.n)

# The decimal point is at the |

# 2 | 133
# 2 | 
# 3 | 0000003344
# 3 | 55555888999
# 4 | 000000000000000111111111222333334444
# 4 | 566666777777889999
# 5 | 00000000000000000011111111111222222222333333344444
# 5 | 55555555566667777778888899
# 6 | 00000000000000111111112222222222222333333333333333344444444444
# 6 | 55557777777788889999
# 7 | 000111122
# 7 | 777799

# 의미 : 2~8 사이의 값이 출력 (각 숫자별로 2개씩 / 2 - 2.1, 2.3 ,2.3) 

# age 변수에서 NA 발견
# 나이는 정수의 값을 가지니깐 이산변수로 분류하게 되면 안되고 연속 변수로 봐야한다.
# 인산변수는 카테고리 값을 가지고 discribe 한 값을 이산변수라고 한다.- 요인에 의해 얻을 수 있는 값 
# 나이는 순차적으로 데이터 값을 가져가므로 연속적인 개념으로 연속 변수이다 .
# 유사 - 키, 나이, 몸무게 들... 중간에 숫자가 뛰는 것이 아니다. 

summary(dataset2$age)
#    Min. 1st Qu.  Median   Mean   3rd Qu.  Max.     NA's 
#   20.0    28.5    43.0    42.6    54.5    69.0      16 

boxplot(dataset2$age) 


# 4.코딩 변경

# 4.1 가독성을 위한 코딩 변경

table(dataset2$resident)
# 1   2   3   4   5   (거주지)
#111  47  27  15  34  (빈도수)


dataset2$resident2[dataset2$resident == 1] <- '1. 서울 특별시' # 거주의 값이 1일 때, 1. 서울 특별시를 넣어주겠다. 
dataset2$resident2[dataset2$resident == 2] <- '2. 인천 광역시'
dataset2$resident2[dataset2$resident == 3] <- '3. 대구 광역시'
dataset2$resident2[dataset2$resident == 4] <- '4. 광주 광역시'
dataset2$resident2[dataset2$resident == 5] <- '5. 부산 광역시'


View(dataset2$resident)

dataset2[c("resident")]

View(dataset2)


# job 컬럼을 대상으로 코딩 변경하기 
dataset2$job2[dataset2$job == 1] <- '공무원'
dataset2$job2[dataset2$job == 2] <- '회사원'
dataset2$job2[dataset2$job == 3] <- '개인사업'

View(dataset2)

names(dataset2$job2)

# 4.2 척도 변경을 위한 코딩 변경

# 나이(age) 변수를 청년층, 중년층 , 장년층 으로 코딩 변경하기 
dataset2$age2[dataset2$age <= 30] <- "청년층"
dataset2$age2[dataset2$age > 30 & dataset2$age <=55] <- "중년층"
dataset2$age2[dataset2$age > 55] <- "장년층 "


View(dataset2)

# 4.3 역코딩을 위한 코딩 변경 (survey) 활용.  
# survey 에서 가장 만족한 것이 1 , 가장 불만족이 5이므로 평균을 내면 문제가 생긴다. 

survey <- dataset2$survey

rsurvey <- 6-survey # 역코딩
rsurvey

dataset2$survey2 <- rsurvey
mean(dataset2$survey2, na.rm = T) # 3.358566 


# 5. 탐색적 분산을 위한 시각화 

# 5.1 범주형 vs 범주형 
getwd()
setwd("C:/workspaces/R/data")
new_data <- read.csv("new_data.csv", header = T)
View(new_data)

# 범주형(resident) vs 범주형(gender) 데이터 분포 시각화

## 성별에 따른 거주지역 분포 현황
resident_gender <- table(new_data$resident2, new_data$gender2)  # table (행, 열) - 빈도수 확인 
resident_gender
#              남자 여자 <빈도수> 
#1.서울특별시   67   43
#2.인천광역시   26   20
#3.대전광역시   16   10
#4.대구광역시    6    9
#5.시구군       19   15

barplot(resident_gender, beside = T, horiz = F, col=rainbow(5), legend = row.names(resident_gender), main = "성별에 따른 거주지역 분포 현황") 

# beside = T : 막대의 개별적 출력 , beside = F : 막대의 누적으로 출력. 
# horiz = F : 세로 막대 출력, horiz = T : 가로 막대 출력
# col : rainbow(n) : 서로 다른 색으로 n개 출력
# legend = row.names( ) : 범례, 행의 이름으로 추가. 
# main = title 


## 거주지역에 따른 성별 분포 현황
gender_resident <- table(new_data$gender2, new_data$resident2) 
#         1.서울특별시 2.인천광역시 3.대전광역시 4.대구광역시 5.시구군
#남자           67           26           16            6        19
#여자           43           20           10            9        15


barplot(gender_resident, beside = F, horiz =T, col=rainbow(2), legend = row.names(gender_resident), main = "거주지역에 따른 성별 분포 현황") 

# 누적 그래프 = 비율적 그래프로 비중적인 의미를 부여할 수 있다. 


# 5.2 연속형 vs 범주형

# 나이(age/연속형) vs 직업(job2/범주형) 데이터 분포 시각화 
install.packages("lattice")
library(lattice)

# 직업유형에 따른 나이 분포 형황
densityplot( ~ age, data = new_data, groups = job2, plot.points=T, auto.key = T)
# plot.points= F : 밀도점 표시 여부(X) , T : 밀도점 표시 
# auto.key = T : 범례 출력 여부 

# x축 : 나이 , y축 : default(밀도 - 빈도)

# 5.3 연속형 vs 범주형 vs 범주형 

# price(연속형) vs gender(범주형) vs position(범주형) 데이터 분포 시각화 

# (1) 성별에 따른 직급별 구매비용 분포 현황 분석
densityplot( ~ price|factor(gender2), data=new_data, groups = position2,  plot.points=T, auto.key = T)

# factor - 값의 범주 카테고리를 빈도수와 같이 출력 (요인화)

# (2) 직급에 따른 성별 구매비용 분포 현황 분석 
densityplot( ~ price|factor(position2), data=new_data, groups = gender2,  plot.points=T, auto.key = T)


# 5.4 연속형 vs 연속형 vs 범주형

# price(연속형) vs age(연속형) vs gender(범주형)
xyplot(price ~ age|factor(gender2), data=new_data)






