# chap06_DataHandling

####################################################
#             chapter06. 데이터 조작               #
####################################################

## 1. plyr 패키지 활용. 
# - 두개 이상의 데이터프레임을 대상으로 key 값을 이용하여 하나의 패키지로 병합(merge) 하거나, 
#   집단 변수를 기준으로 데이터 프레임의 변수에 함수를 적용하여 요약집계 결과를 제공하는 패키지.

# 1.1 데이터 병합 (merge)
install.packages('plyr')
library(plyr)

# package ‘Rcpp’ successfully unpacked and MD5 sums checked
# package ‘plyr’ successfully unpacked and MD5 sums checked
# R 은 사용할때 필요한 pakage를 함께 다운 받아준다. 

# 병합할 데이터프레임 셋 만들기 
x <- data.frame(id = c(1,2,3,4,5), height = c(160,171,173,162,165))
y <- data.frame(id = c(5,4,1,3,2), weight = c(55,73,60,57,80))

x;y
# id height
#  1    160
#  2    171
#  3    173
#  4    162
#  5    165

# id weight
#  5     55
#  4     73
#  1     60
#  3     57
#  2     80

z <- join(x,y, by = 'id') # by = 'id' 공통인 id를 기준으로 데이터 병합 
z
# id height weight
#  1    160     60
#  2    171     80
#  3    173     57
#  4    162     73
#  5    165     55

# 순서가 다르게 저장되어 있어도 정렬하여 출력된다. 


# merge와join 같은 결과값을 낸다. 
a <- merge(x,y,by= 'id') # by = 'id' 공통인 id를 기준으로 데이터 병합 
a
# id height weight
#  1    160     60
#  2    171     80
#  3    173     57
#  4    162     73
#  5    165     55

# 1) join의 추가적인 기능 - 왼쪽(left) 조인하기 
# x, y 의 데이터에서 6과 5 다른 값으로 저장 되어 있다. 
x <- data.frame(id = c(1,2,3,4,6), height = c(160,171,173,162,165))
y <- data.frame(id = c(5,4,1,3,2), weight = c(55,73,60,57,80))

left <-join( x , y , by = 'id') # by = 'id' 공통인 id를 기준으로 데이터 병합
# 왼쪽 조인 방법이 default 값으로, 왼쪽 변수를 기준으로 하여  삽이 되어 있는 값이 없으면 NA(결측치)를 반환한다. 
# (왼쪽변수 기준 : NA(결측치;누락된 값, 비어있는 값))

left
#  id height weight
#  1    160     60
#  2    171     80
#  3    173     57
#  4    162     73
#  6    165     NA

# 2) join의 추가적인 기능 - 내부(inner) 조인 
x <- data.frame(id = c(1,2,3,4,6), height = c(160,171,173,162,165))
y <- data.frame(id = c(5,4,1,3,2), weight = c(55,73,60,57,80))

inner <-join( x , y , by = 'id' , type = 'inner') # type='inner' : 값이 있는 것만 조인
# default 값을 변경 하고 싶을 때 type 사용

inner
#  id height weight
#  1    160     60
#  2    171     80
#  3    173     57
#  4    162     73

# 3) join의 추가적인 기능 - 전체(full) 조인하기 
x <- data.frame(id = c(1,2,3,4,6), height = c(160,171,173,162,165))
y <- data.frame(id = c(5,4,1,3,2), weight = c(55,73,60,57,80))

full <-join( x , y , by = 'id' , type = 'full') # type ='full' : 모든 항목 조인
full
#  id   height weight
#1  1    160     60
#2  2    171     80
#3  3    173     57
#4  4    162     73
#5  6    165     NA
#6  5     NA     55

# id의 순서는 먼저 오는 데이터 순으로 입력 된다. 


# 4) join의 추가적인 기능 - key 값으로 병합하기
x <- data.frame(key1 = c(1,1,2,2,3) , key2 = c('a', 'b' , 'c' , 'd', 'e'), val1 = c(10,20,30,40,50)) 
y <- data.frame(key1 = c(3,2,2,1,1) , key2 = c('e', 'd' , 'c' , 'b', 'a'), val1 = c(500,400,300,200,100)) 

xy <- join(x,y,by=c('key1','key2'))
xy 

#   key1 key2 val1 val1
#1    1    a   10  100
#2    1    b   20  200
#3    2    c   30  300
#4    2    d   40  400
#5    3    e   50  500

# 1.2 그룹별 기술 통계량 구하기 

# (1) tapply() 함수 이용 : 이용한집단별(그룹별) 통계치구하기(활용도높음)

# apply : matrix 객체에서 1이면 행으로 , 2이면 열을 중심으로 출력 하는데, min, max 등의 기능을 값으로 출력한다. 
# lapply : list 의 객체를 받아 결과를 list로 받환 
# sapply : list 의 객체를 받아 결과를 matrix로 반환


# iris 데이터 셋을 대상을 tupply() 함수 적용하기 

head(iris)
#Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#1          5.1         3.5          1.4         0.2  setosa
#2          4.9         3.0          1.4         0.2  setosa
#3          4.7         3.2          1.3         0.2  setosa
#4          4.6         3.1          1.5         0.2  setosa
#5          5.0         3.6          1.4         0.2  setosa
#6          5.4         3.9          1.7         0.4  setosa

names(iris)
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"    
# 컬럼의 값이 없으면 이름을 넣어줄 수 있고, 단독으로 사용되면 컴럼의 이름을 출력한다. 

iris$Species # 3종류 별로 50개씩 가지고 있다. - 총 150개 출력한다. 

unique(iris$Species)
# [1] setosa     versicolor virginica  - 중복된 데이터를 제외한 값 출력 (꽃의 종류 보기 - 3가지 )
# Levels: setosa versicolor virginica

tapply(iris$Sepal.Length, iris$Species, mean) # 평균
# 데이터 셋 <꽃받침의 길이>, 그룹핑할 데이터 셋 <종(3가지를 그룹핑을 함)>, 기능(함수) 

# 3종류 꽃받침 데이터의 평균 출력 - 특정 그룹의 

# setosa versicolor  virginica 
# 5.006      5.936      6.588 


tapply(iris$Sepal.Length, iris$Species, sd) # 표준편차(sd) 

# 종류 꽃받침 데이터의 표준편차 출력

# setosa     versicolor virginica 
# 0.3524897  0.5161711  0.6358796 


# (2) ddply() 함수 이용 : 집단 변수 대상 통계치 구하기
# 형식) ddply(dataframe, .(집단변수), 요약집계, 컬럼명=함수(변수))
# 설명) dataframe의 집단변수를 기준으로 변수에 함수를 적용하여 컬럼명으로 표현
# 꽃의 종류별(Species)로 꽃받침 길이의 평균 구하기 

avg_df <- ddply(iris, .(Species), summarise, avg = mean(Sepal.Length))

avg_df
#   Species    avg
#1     setosa 5.006
#2 versicolor 5.936
#3  virginica 6.588

str(avg_df) # 'data.frame':	3 obs. of  2 variables: / 3행(데이터) 2열(컴럼) 

# 꽃의 종(Species)으로 여러 개의 함수 적용하기 
# tapply 와 차이점 추가적으로 여러개의 값을 출력할 수 있다. 
val <- ddply(iris, .(Species), summarise, avg = mean(Sepal.Length), 
             std =sd(Sepal.Length), 
             max = max(Sepal.Length),
             min = min(Sepal.Length))
val
#    Species   avg      std   max min
#1     setosa 5.006 0.3524897 5.8 4.3
#2 versicolor 5.936 0.5161711 7.0 4.9
#3  virginica 6.588 0.6358796 7.9 4.9

# 결과값의 단위가 다르므로 같도로 처리. 

# round() 함수를 적용하여 반올림 처리하기 . 

round <- ddply(iris, .(Species), summarise, avg = round(mean(Sepal.Length),2), 
               std = round(sd(Sepal.Length),2), 
               max = round(max(Sepal.Length),2),
               min = round(min(Sepal.Length),2))
round # 소수점 둘째 자리까지 출력. 
#    Species  avg  std  max min
#1     setosa 5.01 0.35 5.8 4.3
#2 versicolor 5.94 0.52 7.0 4.9
#3  virginica 6.59 0.64 7.9 4.9

################################################################################

## 2. dplyr 패키지 활용 : 데이터를 분석에 필요한 형태로 만드는 데이터 전처리 관련 함수 제공 패키지
# - 기존 plyr 패키지는 R 언어로 개발되었으나, dplyr 패키지는 C++ 언어로 개발되어 처리 속도를 개선하였다. 
# plyr의 뼈대를 가지고 와서 추가적인 함수를 넣었으므로 그대로 적용한 개념은 아니다. 

install.packages(c("dplyr", "hflights"))
# combine 함수를 이용하여 여러개의 함수를 한번에 설치 가능하다. 

# 연동되어지는 pakage들이 함께 설치 된다. 
#package ‘purrr’ successfully unpacked and MD5 sums checked
#package ‘generics’ successfully unpacked and MD5 sums checked
#package ‘tidyselect’ successfully unpacked and MD5 sums checked
#package ‘dplyr’ successfully unpacked and MD5 sums checked
#package ‘hflights’ successfully unpacked and MD5 sums checked


library(dplyr)
library(hflights)

head(hflights)
str(hflights) # 'data.frame':	227496 obs. of  21 variables: 데이터 227496 , 컬럼 21 개 
unique(hflights)

help(hflights)
############## hflights데이터셋########################
# 2011년도 미국 휴스턴에서 출발하는 모든 비행기의     #
# 이착륙 기록이 수록된 것으로 227,496건의 이착륙기록에#
# 대해 21개 항목을 수집한 데이터                      #
#######################################################


# 2.1 콘솔 창의 크기에 맞게 데이터 추출
#  tbl_df() : 콘솔 창 안에서 한 눈으로 파악하기 - 데이터셋 화면창 크기 만큼 데이터 제공

hflights_df<-tbl_df(hflights) 
hflights_df
# Source: local data frame [227,496 x 21]


# 2.2 조건에 맞는 데이터 필터링 

# hflights_df를 대상으로 1월2일 데이터 추출하기 
# filter(dataframe, 조건1, 조건2) 함수 이용 데이터 추출

filter(hflights_df, Month == 1 &  DayofMonth == 2) # and(, or &) - Source: local data frame [678 x 21]
# filter 는 객체가 매개변수로 전달 되기 때문에 전달받은 변수로 찾으므로 $를 넣지 않아도 된다. 


# 1월 혹은 2월 데이터 추출
filter(hflights_df, Month == 1 | Month == 2) # or(|) -  Source: local data frame [36,038 x 21]

# 1월 2일의 비행 시간 
filter(hflights_df, Month == 1, DayofMonth == 2, AirTime >=300) #  Source: local data frame [6 x 21]



# 2.3 컬럼으로 데이터 정렬
# 년, 월, 출발시간, 도착시간 순으로 오름차순 정렬
# arrange() 함수를 이용한 오름차순 / 내림차순 정렬

# 년, 월, 출발시간, 도착시간 순으로 오름차순 정렬
arrange(hflights_df, Year, Month, DepTime, ArrTime) # 오름차순은 넣어준 순서로 정렬해서 출력해준다. 


# 도착시간 내림차순 정렬
arrange(hflights_df, Year, Month, desc(DepTime), ArrTime)



# 2.4 컬럼으로 데이터로 겈색 
# hflights_df에서 년, 월, 출발시간, 도착 시간 컬럼 검색하기. - (특정 컬럼의 데이터 읽어오기)
select(hflights_df, Year, Month, DepTime, ArrTime) # 4개의 컬럼 선택

# 컬럼의 범위 지정하기 
select(hflights_df, Year:ArrTime) # Year ~ ArrTime 까지의 모든 컬럼이 지정되어서 출력한다. 

# 컬럼의 범위 제외 : Year 부터 DayOfWeek 제외
select(hflights_df, -(Year:DayOfWeek))



# 2.5 데이터 셋 컬럼 추가 

# 출발 지연 시간(DepDelay)과 도착 지연 시간(ArrDelay)과의 차이를 계산하는 컬럼 추가하기
mutate(hflights_df, gain  = ArrDelay - DepDelay, gain_per_hour= gain/(AirTime/60)) # mutate() : 함수를 이용하여 열 추가(변형)

select(mutate(hflights_df, gain = ArrDelay-DepDelay,gain_per_hour= gain/(AirTime/60)), Year, Month, ArrDelay, DepDelay,gain, gain_per_hour)

select(hflights_df, Year)



# 2.6 요약 통계치 계산 

# 비행시간 평균 계산하기 
summarise(hflights_df, avgAirTime = mean(AirTime, na.rm = T))  # NA 항목을 제외하고 계산 
#avgAirTime
#  <dbl>
#   108. # 평균 운행 시간. 

# 데이터 셋의 관측치 길이. 출발 지연 시간 평균 구하기 
summarise(hflights_df, cnt = n(), delay=mean(DepDelay, na.rm = T))         # n() 개수를 출력해준다. 
# n(), sum(), mean(), sd(), var(), median() 등의 함수 사용-기초 통계량
# cnt delay
#<int> <dbl>
#227496  9.44

# 도착시간(ArrTime) 의 표준편차와 분산 계산하기
summarise(hflights_df, arrTimeSd=sd(ArrTime, na.rm = T), arriTimeVar = var(ArrTime, na.rm = T))  # state 패키지 안에 분석과 관련된 함수를 담고 있다.   
# arrTimeSd arriTimeVar
# <dbl>       <dbl>
#  472.     223163.



# 2.7 집단변수 대상 그룹화  

# 집단변수를 이용하여 그룹화하기
# group_by(dataframe, 기준변수) 함수를 이용한 그룹화 - 데이터 프레임을 대상으로 기준 변수 로그룹화
species <- group_by(iris, Species) # 범주별로 그룹핑해서 결과를 출력한다.  

str(species)
#    tibble [150 x 5] (S3: grouped_df/tbl_df/tbl/data.frame)
#    $ Sepal.Length: num [1:150] 5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#    $ Sepal.Width : num [1:150] 3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#    $ Petal.Length: num [1:150] 1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#    $ Petal.Width : num [1:150] 0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#    $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
#    - attr(*, "groups")= tibble [3 x 2] (S3: tbl_df/tbl/data.frame)
#    ..$ Species: Factor w/ 3 levels "setosa","versicolor",..: 1 2 3
#    ..$ .rows  : list<int> [1:3] 
#    .. ..$ : int [1:50] 1 2 3 4 5 6 7 8 9 10 ...
#    .. ..$ : int [1:50] 51 52 53 54 55 56 57 58 59 60 ...
#    .. ..$ : int [1:50] 101 102 103 104 105 106 107 108 109 110 ...
#    .. ..@ ptype: int(0) 
#    ..- attr(*, ".drop")= logi TRUE

planes <- group_by(hflights_df, TailNum) # TailNum : 항공기 일련번호

delay <- summarise(planes, count = n(), dist = mean(Distance, na.rm = T), delay = mean (ArrDelay, na.rm = T))
delay <- filter(delay, count > 20 , dist < 2000)

install.packages("UsingR")
library(ggplot2) # ggplot2 : 고급 시각화(다양성) 기능
ggplot(delay,aes(dist,delay)) + geom_point(aes(size=count), alpha=1/2) + geom_smooth() + scale_size_area()
# 축(aes(dist,delay)) + 점(geom_point) + 선(geom_smooth()) 

################################################################################


# 파이프(pipe) 연산자 이용하기 - 많이 사용 된다./  # %>% : 파이프(pipe) 연산자 - (단축키 : ctrl, shift , m )
getwd()
setwd("C:/workspaces/R/data")

exam <- read.csv("csv_exam.csv")
exam

# filter()
exam %>% filter(class == 1) # 객체를 통해서 접근하기 때문에 변수를 명시하지 않아도 된다.            
#   id class math english science
#1  1     1   50      98      50
#2  2     1   60      97      60
#3  3     1   45      86      78
#4  4     1   30      98      58

# select()
exam %>% select(class, math, english)

# class가 1인 행만 추출한 다음 enlish 추출
exam %>% filter(class==1) %>%  select(english)

# 혹은 밑의 형태로 사용한다. 
exam %>%  
  filter(class==1) %>% 
  select(english)

#english
#1      98
#2      97
#3      86
#4      98

# 과목별 초엊ㅁ과 총점 기준 정렬해서 상위 6개 데이터만을 출력
exam  %>%  
  mutate(total = math + english + science) %>% 
  arrange(desc(total)) %>% 
  head

#   id  class math english science total
#31 18     5   80      78      90   248
#2  19     5   89      68      87   244
#3   6     2   50      89      98   237
#4  17     5   65      68      98   231
#5  16     4   58      98      65   221
#6  20     5   78      83      58   219



## 3. reshape2 패키지 활용 

# 3.1 긴 형식을 넓은 형식으로 변경

# 패키지 설치 
install.packages("reshape2")
library(reshape2)

data <- read.csv("data.csv")
data
View(data)

# 긴 형식 -> 넓은 형식으로 변경
wide <- dcast(data, Customer_ID ~ Date, sum)
View(wide)

# 파일 저장 및 읽기 
setwd("C:/workspaces/R/output")
write.csv(wide, 'wide.csv', row.names = F)

wide_read <- read.csv('wide.csv')
colnames(wide_read) <- c('id','day1','day2','day3','day4','day5','day6','day7')
wide_read


# 3.2 넓은 형식을 긴 형식으로 변경

# melt() 함수 이용
long <- melt(wide_read, id = 'id')
long

# 컬럼명 수정
colnames(long) <- c("id", "Date", "Buy")
head(long)

# reshape2 패키지의 smiths 데이터 셋 구조를 활용 2개의 기준 넣기. 
data("smiths")
View(smiths) # 넓은 형식 
#  subject    time age  weight height
# John Smith    1  33     90   1.87
# Mary Smith    1  NA     NA   1.54

# wide -> long 
long <- melt(smiths, id = 1:2) # subject, time 가 기준. 
long # 긴 형식 
#       subject time variable value
#1 John Smith    1      age 33.00
#2 Mary Smith    1      age    NA
#3 John Smith    1   weight 90.00
#4 Mary Smith    1   weight    NA
#5 John Smith    1   height  1.87
#6 Mary Smith    1   height  1.54

# long -> wide 
dcast(long,  subject+time ~ ...) # ... 기준을 주지 않음. / 앞의 변수만 기준을 잡아준다. 
#   subject   time age weight height
# John Smith    1  33     90   1.87
# Mary Smith    1  NA     NA   1.54


# 3.3 3차원 배열 형식으로 변경 

data("airquality") #New York의 대기에 대한 질 
# <airquality>
# 데이터 셋은 R 에서 기본으로 제공되는 데이터 셋으로 New York의
# 대기에 대한 질을 측정한 데이터 셋이다 전체 153 개의 관측치와 6 개의
# 변수로 구성되어 있으며 변수명은 모두 대문자로 되어있다
# 주요변수
# Ozone(오존 수치), Solar.R(태양광) Wind(바람) Temp(온도)
# Month(측정 월 5~9), Day(측정 날짜 1~31 일)

str(airquality) # 'data.frame':	153 obs. of  6 variables:

# 컬럼명 대문자 일괄 변경
names(airquality) <- toupper(names(airquality)) # 컬럼명 대문자 변경  /  toupper ; 기존의 이름을 다 대문자로 변경
head(airquality)
#    OZONE SOLAR.R WIND TEMP MONTH DAY
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#5    NA      NA 14.3   56     5   5
#6    28      NA 14.9   66     5   6


# 월과 일 컬럼으로 나머지 4개 컬럼을 묶어서 긴 형식 변경
air_melt <- melt(airquality, id = c("MONTH", "DAY"), na.rm = T)
head(air_melt) # MONTH DAY variable value
#    MONTH DAY variable value
#1     5   1    OZONE    41
#2     5   2    OZONE    36
#3     5   3    OZONE    12
#4     5   4    OZONE    18
#6     5   6    OZONE    28
#7     5   7    OZONE    23


View(air_melt)


# 일과 월 컬럼으로 variable 컬럼을 3차원 형식으로 분류 
names(air_melt) <- tolower(names(air_melt)) #tolower: 컬럼명 소문자로 변경
acast <- acast(air_melt, day~month~variable) # 3차원 구조 변경  

View(acast)
class(acast) # [1] "array" = 행, 열, 면 으로 이루어진다. 

# 월 단위 variable(대기과련 컬럼) 컬럼 합계
acast(air_melt, month~variable,sum)
#   OZONE SOLAR.R WIND TEMP
#5   614    4895 360.3 2032
#6   265    5705 308.0 2373
#7  1537    6711 277.2 2601
#8  1559    4812 272.6 2603
#9   912    5023 305.4 2307










