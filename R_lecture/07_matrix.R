# matrix : 동일한 data type을 가지는 2차원 형태의 자료구조
# matrix의 생성
var1 = matrix(c(1:5))  # matrix의 생성 기준은 열!!
                       # 5행 1열짜리 matrix가 생성
var1

var1 = matrix(c(1:10), nrow=2)
var1                   # 2행 5열짜리 matrix

var1 = matrix(c(1:10), nrow=3)
var1                   # 3행 4열짜리 matrix

var1 = matrix(c(1:10), nrow=2, byrow = T)
var1

# vector를 연결해서 matrix를 만들 수 있어요!
# vector를 가로방향, 세로방향으로 붙여서 2차원 형태로
# 만들 수 있어요!
var1 = c(1,2,3,4)
var2 = c(5,6,7,8)

mat1 = rbind(var1, var2)
mat1

mat2 = cbind(var1, var2)
mat2

var1 = matrix(c(1:21), nrow=3, ncol=7)
var1                   # 3행 7열짜리 matrix

var1[1,4]

var1[2,]               # 2행의 모든 열
var1[,3]               # 3열의 모든 행

# 11 12 14 15의 값을 가져올려면??
var1[c(2,3),c(4:5)]

length(var1)
nrow(var1)
ncol(var1)

# matrix에 적용할 수 있는 함수가 있어요!
# apply() 함수를 이용해서 matrix에 특정 함수를 적용
# apply() 함수는 속성이 3개 들어가요
# X => 적용할 matrix
# MARGIN => 1이면 행 기준, 2이면 열 기준
# FUN => 적용할 함수명
var1 = matrix(c(1:21), nrow=3, ncol=7)
var1                   # 3행 7열짜리 matrix

apply(X=var1, MARGIN = 1, FUN=mean)
# 이미 우리에게 제공되는 함수만 이용할 수 있나요?
# 적용할 함수를 우리가 직접 만들어서 사용할 수 있어요!

## matrix의 연산
# matrix의 요소단위의 곱연산
# 전치행렬을 구해보아요!
# 행렬곱(matrix product)
# 역행렬(matrix inversion) => 가우스 소거법이용

var1 = matrix(c(1:6), ncol=3)
var1
var2 = matrix(c(1,-1,2,-2,1,-1), ncol=3)
var2
var3 = matrix(c(1,-1,2,-2,1,-1), ncol=2)
var3
# elementwise product (요소단위 곱연산)
var1 * var2
# matrix product (행렬곱)
var1 %*% var3

# 전치행렬( transpose )
var1
t(var1)

# 역행렬 : matrix A가 nxn 일 때 다음의 조건을
# 만족하는 행렬 B가 존재하면 행렬 B를 A의 역행렬
# 이라고 해요!!
# AB = BA = I(단위행렬 E)
solve(var1)

################################################

# Array : 3차원 이상. 같은 데이터 타입으로 구성
var1 = array(c(1:24), dim=c(3,2,4))
var1







