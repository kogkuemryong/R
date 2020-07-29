# chap05_DataVisualization

####################################################
#           chapter05. 데이터 시각화               #
####################################################

# 이산변수와 연속변수 시각화 

# 1. 이산변수(discrete quantitative data) 시각화 
#   - 정수단위로 나누어 측정할 수 있는 변수
#   - 연속적이지 않은 변수 (예시, 돈 - 1원은 있지만 1.5원은 없다) 

# 1) 막대차트 함수 - barplot() 형식 - barplot() 
# (1) 세로 막대차트 

# 막대 차트 데이터 생성
chart_data <- c(305, 450, 320, 460, 330, 480, 380, 520) # 1차원 배열 
names(chart_data) <- c("2019 1분기", "2020 1분기", "2019 2분기", "2020 2분기", "2019 3분기", "2020 3분기", "2019 4분기", "2020 4분기")

mode(chart_data)
class(chart_data)

str(chart_data) # chat_data dataset의 특징
chart_data

# 세로 막대 차트
help("barplot") # barplot : 막대 그래프로 시각화 해주는 함수 
barplot(chart_data , ylim = c(0,600), col = rainbow(8), main = "2019년도 vs 2020년도 분기면 매출 현황 비교") 
#  ylim : y축 값의 범위 / 지정하지 않으면 default값으로 함수에서 잡아주는데 직관력이 떨어지는 경우가 많다.
#        일정 크기를 넣어주면 그 값에 맞춰서 보기 좋게 조정하여 출력해준다. 
#  col : color 의 약자로 색을 넣어주는 함수 / rainbow(n) , n의 수만큼 서로 다른 색으로 출력한다.  
#  main : 타이틀을 넣어주는 매개변수 

barplot(chart_data , ylim = c(0,600), col = rainbow(8), xlab ="년도별 분기현황", ylab = "매출액(단위:만원)", main = "2019년도 vs 2020년도 분기면 매출 현황 비교") 
# xlab = x축 이름 
# ylab = y축 이름 


# (2) 가로 막대 차트 

barplot(chart_data, xlim = c(0,600) , xlab = "매출액(단위:만원)", ylab = "년도별 분기현황", col = rainbow(8), main = "2019년도 vs 2020년도 분기면 매출 현황 비교",horiz = T)
# 매개변수의 이름과 함께 데이터를 입력하게 되면 순서는 상관없다. 
# horiz : default = F(세로 막대 차트 출력) , T (가로 막대 차트 출력)

# 속성 추가 
barplot(chart_data, xlim = c(0,600) , xlab = "매출액(단위:만원)", ylab = "년도별 분기현황", col = rainbow(8), main = "2019년도 vs 2020년도 분기면 매출 현황 비교",horiz = T, space = 1.5, cex.names = 0.8)
# space : 막대 그래프 사이의 간격을 정의하는 매개변수 
# cex.naems : 텍스트의 크기를 바꿀 수 있는 매겨변수, default 값 = 1 / 0.8 입렵하면 80% 크기로 출력


# red 와 blue 색상 4회반복 
barplot(chart_data, xlim = c(0,600), xlab = "매출액(단위:만원)", ylab = "년도별 분기현황", main = "2019년도 vs 2020년도 분기면 매출 현황 비교", horiz = T, space = 1.5, cex.names = 0.8, col=rep(c(2,4),4))
# rep : 색상 반복 /  rep(c(2(빨강)-2019년 색상, 4(파랑)-2020년 색상), 4(반복))
# rep(c(n, n), n(반복)) : 검은색 (1), 빨간색(2), 초록색(3), 파란색(4), 하늘색(5), 자주색(6), 노란색(7)

barplot(chart_data, xlim = c(0,600), xlab = "매출액(단위:만원)", ylab = "년도별 분기현황", main = "2019년도 vs 2020년도 분기면 매출 현황 비교", horiz = T, space = 1.5, cex.names = 0.8, col=rep(c("green","yellow"),4))
# 원하는 색상을 키워드를 이용해서 직접넣어줄 수 있다.
# col=rep(c("color_name","color_name"),반복수))


# 누적 막대 차트 
data("VADeaths")
VADeaths

# VADeaths
#R에서 기본으로 제공되는 데이터 셋으로 1940 년 미국 버지니아주의
#하위계층 사망비율을 기록한 데이터 셋이다 전체 5 행 4 열의 numeric 자료형의
#matrix 자료구조를 갖고 있다

#변수구성 Rural Male( 시골출신 남자 Urban Male( 도시출신 남자))
#         RuralFemale( 시골출신 여자 Urban Female( 도시출신 여자))


#           Rural Male Rural Female Urban Male Urban Female
#50-54       11.7          8.7       15.4          8.4
#55-59       18.1         11.7       24.3         13.6
#60-64       26.9         20.3       37.0         19.3
#65-69       41.0         30.9       54.6         35.1
#70-74       66.0         54.3       71.1         50.0

str(VADeaths) # 자료의 특징
#num [1:5, 1:4] 11.7 18.1 26.9 41 66 8.7 11.7 20.3 30.9 54.3 ...
#- attr(*, "dimnames")=List of 2
#..$ : chr [1:5] "50-54" "55-59" "60-64" "65-69" ...
#..$ : chr [1:4] "Rural Male" "Rural Female" "Urban Male" "Urban Female"

mode(VADeaths) # 자료형 
# [1] "numeric"

class(VADeaths) # 자료 구성 
# [1] "matrix"


# 개별 차트와 누적 차트 그리기 
# 누적 차트 
par(mfrow=c(1,2)) # 1행 2열 그래프 보기 (개별차트 + 누적 차트)

barplot(VADeaths, col=rainbow(5), main = "미국 버지니아주 하위계층 사망 비율")
# 1컬럼 - 5 데이터 / 나이 별로 누적되어 각 컬럼별 특징을 시각화 해준다. 
legend(0, 200, c("50-54","55-59","60-64","65-69","70-74"), cex = 0.8 , fill = rainbow(5))   
# legend : (x, y, 수식) - 범례 작성  


# 개별 차트 
barplot(VADeaths, col=rainbow(5), main = "미국 버지니아주 하위계층 사망 비율", beside = T)
legend(0, 71, c("50-54","55-59","60-64","65-69","70-74"), cex = 0.8 , fill = rainbow(5))
# beside : default = F : 행의 값을 하나의 막대에 넣어준다 , T : 각행의 데이터를  하나의 막대 그래프로 구별해서 출력해준다.   



# 2) 점 차트 시각화 - dotchart()  
help("dotchart")

par(mfrow=c(1,1)) # 1행 1열 그래프 보기 
chart_data
#2019 1분기 2020년 1분기   2019 2분기   2020 2분기   2019 3분기   2020 3분기   2019 4분기   2020 4분기 
#305          450          320          460          330          480          380          520 

dotchart(chart_data, color = c("blue", "red"), xlab = "매출액(단위:만원)" , cex = 1.2, main="분기별 판매현환 점 차트 시각화화" , labels=names(chart_data)) 
# color = c("blue"-2019년, "red"-2020년) 색상 넣기  
# xlab = x축 이름 
# cex = 레이블과 점의 크기 확대
# main = title 
# labels = 기존에 데이터가 가지고 있는 컬럼의 이름을 반환하여 labels에 담아준다(y축). 

# names(chart_data) <- c(내용) : 컬럼 이름 넣기 


# + 추가 속성 

dotchart(chart_data, color = c("blue", "red"), xlab = "매출액(단위:만원)" , cex = 1.2, main="분기별 판매현환 점 차트 시각화화" , labels=names(chart_data), lcolor="purple", pch = 2:1) 
# lcolor : 줄의 색상 지정 
# pch(plotting character) : (n:n) : 원(○) - (1) , 삼각형(△) -(2), 십자가 모양 (+) - (3) , 출력되는 기호 지정 
# cex(character expansion) : 레이블과 점의 크기 확대



# 3) 원형 차트 시각화화 - pie()
help(pie)

chart_data
#2019 1분기 2020년 1분기   2019 2분기   2020 2분기   2019 3분기   2020 3분기   2019 4분기   2020 4분기 
#305          450          320          460          330          480          380          520 

pie(chart_data , labels = names(chart_data), border = 'blue', col=rainbow(8), cex=1.2) 
title("2019~2020년도 분기별 매출 현황")
# labels : 기존에 데이터가 가지고 있는 컬럼의 이름을 반환하여 labels에 담아준다. 
# border : 테두리의 속성 
# title : title 출력 





################################################################################



# 2. 연속변수(Continuous quantitative data) 시각화 
#   - 시간, 길이 등과 같은 연속성을 가진 실수 단위 변수

#  1) 상자 그래프 시각화 : 요약정보를 시각화 하는데 효과적. 특히 데이터의 분포 정도와 이상치 발견을 목적으로 하는 경우 유용

boxplot(VADeaths, range=0) # 상자그래프 시각화. 
# range = 0 : 최소값과 최대값 점선으로 연결하는 역할 - 주식에서 많이 사용 
# 최대값과 최소값의 격차를 보여주며, 분포도를 보여준다. 

abline(h = 37, lty = 3, col="red")점 # abline : 기준선 추가(lty = 3 : 선 (lty : linetype)) 

summary(VADeaths) # 데이터의 다양한 값읃 쉽게 알 수 있다.(min, max, mean...등)

#  2) 히스토그램 시각화 - 탐색과정에서 연속 변수에 관하여 가장 많이 사용한다. 
#    - 측정갓의 범위(구간)를 그래프의 x축으로 놓고, 범위에 속하는 측정값의 빈도수를 y축으로 나타낸 그래프 형태. 

data("iris") # iris(붓꽃) 데이터 셋 가져오기 - iris 모델을 설명할 때 많이 사용한다. 

head(iris) # 데이터 상위 6개만 출력 

# R에서 제공되는 기본 데이터 셋으로 3 가지 꽃의 종류별로 50 개씩 전체
# 150개의 관측치로 구성된다.
# iris는 붓꽃에 관한 데이터를 5 개의 변수로 제공하며각 변수의 내용은 다음과 같다.
# Sepal.Length(꽃받침 길이) Sepal.Width(꽃받침 너비)
# Petal.Length(꽃잎 길이)   Petal.Width(꽃잎 너비)
# Species(꽃의 종류) :  3 가지 종류별 50 개 (전체 150 개 관측치) 

table(iris$Species) # 각 종별 데이터 개수 
# setosa versicolor  virginica 
# 50         50         50 

names(iris) # 컬럼의 이름이 존재하며 컬럼 이름을 반환한다. 
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"    

summary(iris) # 컬럼별 특징 
# Sepal.Length    Sepal.Width     Petal.Length    Petal.Width          Species  
# Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100   setosa    :50  
# 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300   versicolor:50  
# Median :5.800   Median :3.000   Median :4.350   Median :1.300   virginica :50  
# Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199                  
# 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800                  
# Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500   

summary(iris$Sepal.Width)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 2.000   2.800   3.000   3.057   3.300   4.400 

hist(iris$Sepal.Width, xlab = "꽃받침의 너비" , col= "green", xlim = c(2.0,4.5), 
     main="iris 꽃받침 너비 histogram") 
# xlim : x축의 최소와 최대 범위 표현 
# 붓꽃의 너비, 길이 연속함수 
# 의미 : 막대그래프의 2.0~2.25 너비를 가진 것들의 빈도수가 5정도 된다. 

summary(iris$Sepal.Length)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 4.300   5.100   5.800   5.843   6.400   7.900 

hist(iris$Sepal.Length, xlab = "꽃받침의 길이" , col= "mistyrose", xlim = c(4.0,8.0), 
     main="iris 꽃받침 길이 histogram") 

# 의미 4.0 ~ 4.5 의 길이의 막대 그래프의 빈도수는 5정도 된다.   

# 확률 밀도로 히스토그램 그리기 - 연속형변수의 확률 
hist(iris$Sepal.Width, xlab = "꽃받침 너비", col = "gray", xlim=c(2.0,4.5), main="iris 꽃받침 너비 histogram", freq=F)
# freq : 빈도수 default = T 빈도수 , F = Density (확률밀도)로 출력 

# 밀도를 기준으로 line을 그려준다. 
lines(density(iris$Sepal.Width), col = "red") 


# 정규분포곡선 추가 
# - 분포곡선 : 빈도수의 값을 선으로 연결하여 얻어진 곡선 

x <- seq(2.0,4.5,0.1)
x
# [1] 2.0 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5

curve(dnorm(x, mean = mean(iris$Sepal.Width), sd=sd(iris$Sepal.Width)), col="blue", add = T)
# curve() : 정규분포 곡선 특징 지정
# dnorm() : 랜덤 변수 생성
# sd() : 표준 편차
# add() : 추가 


# 3) 산점도 시각화 
#   - 두 개 이상의 변수들 사이의 분포를 점으로 표시한 차트를 의미

# 기본 산점도 시각화 
price <- runif(10, min = 1, max = 100) # 1~100 사이 10개 난수 발생
# runif() : 난수 발생 함수 / runif(생성개수 n개의 랜덤 난수 , 최소 , 최대 ) 최소 ~ 최대 까지에서 n개 난수 생성

plot(price)

# 대각선 추가 
par(new=T) #  기존 그래프에서 추가적으로 차트을 넣어준다 
# par - plot 안에서 시각화의 개수를 제공해주는 함수 

line_chart <- c(1:100)
line_chart
#[1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30
#[31]  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60
#[61]  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90
#[91]  91  92  93  94  95  96  97  98  99 100

plot(line_chart, type = "l", col = "red", axes = F, ann = F)
# type = "l" : 실선을 넣어준다. 
# axes : 축의 대한 매개변수 
# ann : T,F의 값을가진다. 

# 텍스트 추가 
text(70,80,"대각선 추가",col = "blue" )
# text(x축,y축,"내용") + col = "색상"


# type 속성 그리기 
par(mfrow=c(2,2)) # 2행 2열 차트 / 4개의 이미지를 한번에 볼 수 있도록 셋팅

plot(price, type = "l") # 유형 : 실선
plot(price, type = "o") # 유형 : 원형과 실선(원형통과)
plot(price, type = "h") # 유형 : 직선 
plot(price, type = "s") # 유형 : 꺾은선 

# pch 속성으로 그리기
plot(price, type = "o", pch = 5) # 빈 사각형 
plot(price, type = "o", pch = 15) # 채워진 사각형
plot(price, type = "o", pch = 20) # 채워진 원형
plot(price, type = "o", pch = 20, col = "blue") # 파란 채워진 원형
plot(price, type = "o", pch = 20, col = "orange", cex = 3.0)  # 오랜지색 으로 채워진 원형(x3)
plot(price, type = "o", pch = 20, col = "orange", cex = 3.0, lwd=3) # lwd : line width (선의 너비)


# 4) 중첩 자료 시각화 



par(mfrow=c(1,1))  # 1행 1열 : default 값

# 두 개의 벡터 객체 
x <- c(1,2,3,4,2,4) 
y <- rep(2,6) # rep(시작과 끝 : 반복 횟수)
x;y
# [1] 1 2 3 4 2 4
# [1] 2 2 2 2 2 2

# 교차테이블 작성
table(x) # table : 빈도수 
# 1 2 3 4 
# 1 2 1 2 

table(y)
# 2 
# 6 

table(x,y)
#     y
# x   2
#   1 1 
#   2 2
#   3 1
#   4 2 
# x가 1일 때, y가 2인 값 = 1, x가 2일 때, y가 2인 값 = 2 ,  x가 3일 때, y가 2인 값 = 1, x가 4일 때, y가 2인 값 = 2


# 산점도 시각화 
plot(x,y)
# x가 1,2,3,4 일 때 y는 2 - 4개의 데이터만 있는 것으로 보인다(데이터의 개수가 시각적으로 확인하기 어렵다)

# 중복된 자료의 수 만큼 점의 크기 확대하기 

# 데이터 프레임 생성
xy.df <- as.data.frame(table(x,y))
xy.df

# x y Freq
# 1 2  1
# 2 2  2
# 3 2  1
# 4 2  2


a<-as.data.frame(x,y)
# 경고메시지(들): 
#In as.data.frame.numeric(x, y) :
#'row.names' is not a character vector of length 6 -- omitting it. Will be an error!
# = 'row.names'는 길이가 6 인 문자형 벡터가 아니므로 생략합니다. 오류가 될 것입니다!

# 좌표에 중복된 수 만큼 점 확대 
plot(x,y,pch = 20 , col = "black", xlab =  "x 벡터 원소" , ylab= "y 벡터 원소" , cex = 0.8 * xy.df$Freq) 
# pch : 출력해주는 점의 모양 변경 
# col : 색상
# xlab : x 레이블 이름
# ylab : y 레이블 이름
# cex : 점의 크기 -  cex = 0.8 * xf.df$Freq)  // 빈도수를 곱해서 중복되었을 때 그기가 배가 되도록 만든다. 

################################################################################

# galton 데이터 셋 대상 중복 자료 시각화 


#galon 데이터 셋 가져오기 
install.packages("UsingR")

library(UsingR)

data("galton")

# galton은 psych 패키지에서 제공되는 데이터 셋으로 갈턴에 의해서 연구된
# 부모와 자식의 키 사이의 관계를 기록한 데이터를 제공한다 전체 관측치는
# 928 개 이며 2 개의 변수 (child 와 parent) 를 제공한다 프랜시스 칼턴은
# 영국 유전학자로 우생학 창시자 종의 기원를 저술한찰스 다윈의 
# 사촌이다 우생학이란 유전학 의학 통계학을 기초로우수 유전자 증대를 목적으로 한 학문이다


head(galton)
# child parent
# 1  61.7   70.5
# 2  61.7   68.5
# 3  61.7   65.5
# 4  61.7   64.5
# 5  61.7   64.0
# 6  62.2   67.5

str(galton) #'data.frame':	928 obs. of  2 variables: - 928개의 열 , 2개의 행 

class(galton) #"data.frame"


# 데이터프레임으로 변환 
galtonData <- as.data.frame(table(galton$child , galton$parent)) 
# class를 통해서 galton$child 행으로 galton$parent 열로 분포도를 알려준다. 
# 그 값을 as.data.frame 에 넣으면 Freq의 값을 도출해 낼 수 있다. 

head(galtonData)

# Var1  Var2  Freq
# 61.7   64    1
# 62.2   64    0
# 63.2   64    2
# 64.2   64    4
# 65.2   64    1
# 66.2   64    2

str(galtonData)
# 'data.frame':	154 obs. of  3 variables: - 154개 열 , 3개의 행 = 928 -> 154 개 : 중복이 많다. 

# 컬럼 단위 추출 
names(galtonData) <- c("child" , "parent" , "freq") # 컬럼에 이름 지정

head(galtonData)

#  child  parent freq
#  61.7     64    1
#  62.2     64    0
#  63.2     64    2
#  64.2     64    4
#  65.2     64    1
#  66.2     64    2

parent <- as.numeric(galtonData$parent)
child <- as.numeric(galtonData$child)


# 점의 크기 확대 

plot(parent, child, pch = 21, col = "black", bg="gray", xlab = "parent" , ylab = "child" , cex = 0.1 * galtonData$freq)
# 부모의 키가 자녀에게 얼마나 영향을 미치는지 파악 
# 중간 지점에 분포한다는 것 - 부모의 키가 자녀의 키의 영향을 미친다고 보기 어렵다. 만약에 영향을 미친다면 
# 선형적인 형태의 그래프가 출력되어야 한다. 
# galton 회기를 주장 - 평균으로 돌아간다. 전체적인 키는 평균값으로 회기하는 경향을 가진다. 


# 5) 변수 간의 비교 시각화 

# iris 4개 변수의 상호 비교 

# R에서 제공되는 기본 데이터 셋으로 3 가지 꽃의 종류별로 50 개씩 전체
# 150개의 관측치로 구성된다.
# iris는 붓꽃에 관한 데이터를 5 개의 변수로 제공하며각 변수의 내용은 다음과 같다.
# Sepal.Length(꽃받침 길이) Sepal.Width(꽃받침 너비)
# Petal.Length(꽃잎 길이)   Petal.Width(꽃잎 너비)
# Species(꽃의 종류) :  3 가지 종류별 50 개 (전체 150 개 관측치) 

attributes(iris) # attributes : 행의 이름 , 열의 이름, 데이터 구조  출력 


# $names
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species" 


# $class
# [1] "data.frame"

#$row.names
#[1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30
#[31]  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60
#[61]  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90
#[91]  91  92  93  94  95  96  97  98  99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120
#[121] 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150

data(iris)
help(pairs)
# pairs : matrix 또는 데이터프레임의 numeric 컬럼을 대상으로 변수 사이의 비교 결과를 행렬구조의 분산된 그래프로 제공.

pairs(iris[,1:4]) # 1~4열 ("Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width")을 선택 
# 두 변수 간의 분포도를 볼 수 있도록 한다. 


# 꽃의 종류 : "virginica" ,  "setosa" , "versicolor"를 종별 대상으로 4개 변수 상호 비교. 

pairs(iris[iris$Species=="virginica", 1:4])

pairs(iris[iris$Species=="setosa", 1:4])

pairs(iris[iris$Species=="versicolor", 1:4])


# 3차원 산점도 시각화 
# 패키지 설치 및 로딩 
install.packages("scatterplot3d")
library(scatterplot3d)

# Factor의 level 보기 
levels(iris$Species)
# [1] "setosa" "versicolor" "virginica"  / 3개의 값이 담겨있음을 알 수 있다. 
# levels() : 요인형으로 컬럼이 가지고 있는 카테고리(범주)를 출력 /  요인 = 데이터에서 가지는 값의 카테고리 

# 붓꽃(iris)의 종류별 분류 
iris_setosa <- iris[iris$Species == 'setosa', ] # 50개의 데이터가 저장되다. 

iris_versicolor <- iris[iris$Species == 'versicolor', ]

iris_virginica <- iris[iris$Species == 'virginica', ]

# 3차원 틀 생성

# scatterplot3d(밑변, 오른쪽변 컬럼, 왼쪽변 컬럼, type)

d3 <- scatterplot3d(iris$Petal.Length,iris$Sepal.Length, iris$Sepal.Width, type = 'n' ) 
# type : h -> 수직선 , p -> 점, l-> 선, n -> 



# 3차원 산점도 시각화 
d3$points3d(iris_setosa$Petal.Length, 
            iris_setosa$Sepal.Length, 
            iris_setosa$Sepal.Width,bg='yellow', 
            pch = 21) # pch = 21 : 타원 산점도 

# 결과 해석 : setosa 왼쪽으로 붙어서 출력 된다. 


d3$points3d(iris_versicolor$Petal.Length, 
            iris_versicolor$Sepal.Length, 
            iris_versicolor$Sepal.Width,bg='blue', 
            pch = 23) # pch = 23 : 마름모꼴

# 결과 해석 : versicolor 중간에 분포 

d3$points3d(iris_virginica$Petal.Length, 
            iris_virginica$Sepal.Length, 
            iris_virginica$Sepal.Width,bg='red', 
            pch = 25) # pch = 25 : 역삼각형 모양 

# 결과 해석 : virginica 오른쪽에 분포 

# 각각의 특징들을 볼 수 있으며, 특징을 통해서 구분 할 수 있다. 



































