
# R Preparation -----------------------------------------------------------

# get current directory 
getwd()
# set current directory
setwd("C:/Users/mas/learning/book-tsa-ssm-foundation/MyObjects")

# Read Data
# from clipboard
data.0.clip <-  read.delim("clipboard")
head(data.0.clip)
pairs(data.0.clip[, c("length", "food", "medicine")]) #scatter plot
data.0 <- read.csv("data0.csv")
pairs(data.0)

# Check Data
names(data.0)
data.0$length
class(data.0)

# Plot, Y ~ X
plot(data.0$length ~ data.0$food)
plot(data.0$length ~ data.0$medicine)

# Writing Rule
# par
plot(
  data.0$length ~ data.0$food,
  col = c(2, 3)[data.0$medicine], # color
  pch = 16, # marker type
  ylab = "Lenght",
  xlab = "food",
  main = "length, food and medicine",
  cex.main = 1.5, # size for main
  font.lab = 2 # font for labels
)
legend(
  "topleft",
  legend = c("medicine", "not"),
  col = c(2, 3),
  bty = "n", # character type
  pch = 16
)

# modeling
lm.model.0 <- lm(length ~ food + medicine, data = data.0)
anova(lm.model.0)

# predict
predict(lm.model.0,
        newdata = data.frame(food=50, medicine="medicine")
        )
predict(lm.model.0,
        newdata = data.frame(food=50, medicine="medicine"),
        interval = "prediction", # 予想のレンジ設定
        level = 0.95
)
?predict
predict(lm.model.0) # forcast for training data
newfood <- seq(from = min(data.0$food), to = max(data.0$food), by = 1)
new.1 <- data.frame(
  food = newfood,
  medicine = "medicine"
)
new.2 <- data.frame(
  food = newfood,
  medicine = "na"
)
pred.1 <- predict(lm.model.0,
        newdata = new.1,
        interval = "prediction",
        level = 0.95)
pred.2 <- predict(lm.model.0,
                  newdata = new.2,
                  interval = "prediction",
                  level = 0.95)
plot(
  data.0$length ~ data.0$food,
  col = c(2, 3)[data.0$medicine], # color
  pch = 16, # marker type
  ylab = "Lenght",
  xlab = "food",
  main = "length, food and medicine",
  cex.main = 1.5, # size for main
  font.lab = 2 # font for labels
)

lines(pred.1[, 1] ~ newfood, col = 2, lwd = 2) #line width
lines(pred.1[, 2] ~ newfood, col = 2, lwd = 1, lty = 2) #line type
lines(pred.1[, 3] ~ newfood, col = 2, lwd = 1, lty = 2) #line type
lines(pred.2[, 1] ~ newfood, col = 3, lwd = 2) #line width
lines(pred.2[, 2] ~ newfood, col = 3, lwd = 1, lty = 2) #line type
lines(pred.2[, 3] ~ newfood, col = 3, lwd = 1, lty = 2) #line type

legend(
  "topleft",
  legend = c("medicine", "na"),
  col = c(2, 3),
  bty = "n", # character type
  pch = 16
)

# Data formation
vec <- c(1:3, 4.5, 5, 6, 7.2, 8, 9, 9.9)
int <- 1:10
seq(from = 0.1, to = 1, by = 0.1)
d <- data.frame(
  vec = vec,
  int = int,
  seq = seq(from = 0.1, to = 1, by = 0.1)
)
?par


# Basic -------------------------------------------------------------------

osaka <- c(rep(19, 1), rep(20, 4), rep(21, 3))
mean(osaka)
length(osaka) # sample size
var(osaka)

tokyo <- c(-50, rep(0, 2), rep(20, 5), rep(70, 2))
mean(tokyo)
var(tokyo)
sqrt(var(tokyo))
sd(tokyo)

d <- c(-1, -1, 0, 0, 1, 3, 5, 6, 7, 7)
mean <- mean(d)
sd(d)
length(d)
std.error <- sd(d) / sqrt(length(d))
t.value <- mean / std.error
# p-value, pt: t distribution %
(1 - pt(t.value, df = length(d) - 1)) * 2
t.test(d)


# t inference -------------------------------------------------------------
getwd()
data.0 <- read.csv("data0.csv")
head(data.0)
names(data.0)
pairs(data.0)
lm.model.0 <- lm(length ~ food + medicine, data = data.0)
lm.model.0
summary(lm.model.0)


# ANOVA -------------------------------------------------------------------

d2 <- data.frame(
  Y = c(1:5, 4:8, 7:11),
  option = rep(c("A", "B", "C"), each = 5)
)
plot(d2$Y ~ d2$option)
# Graph Parameter, 余白
par(mar = c(5, 6, 3, 3))
plot.default(
  d2$Y ~ d2$option,
  ylim = c(0, 12), xlim = c(0.5, 3.5),
  ylab = "結果", xlab = "選択肢",
  cex = 2, #marker font
  cex.lab = 2, cex.main = 3,
  xaxt = "n"
)
axis(side = 1, 1:3, LETTERS[1:3])

mean(d2$Y)
tapply(d2$Y, d2$option, mean)

#重回帰的
#離散値を変数に回帰にかける⇒ 各離散値は 0 or 1 のフラグとなる
lm.model.anova <- lm(Y ~ option, data = d2)
summary(lm.model.anova)

predict(lm.model.anova, data.frame(option = c("A", "B", "C")))
tapply(d2$Y, d2$option, mean)


#条件別期待値の分散
d2.effect <- data.frame(
  Y = c(rep(3, 5), rep(6, 5), rep(9, 5)),
  option = rep(c("A", "B", "C"), each = 5)
)
plot(d2.effect$Y ~ d2.effect$option)
plot.default(d2.effect$Y ~ d2.effect$option)
#自由度は変数の数から１を引いたもの
effect <- sum((d2.effect$Y - mean(d2.effect$Y)) ^ 2) / 2

#予測残差の分散
d2.noise <- data.frame(
  Y = d2$Y - d2.effect$Y,
  option = rep(c("A", "B", "C"), each = 5)
)
plot(d2.noise$Y ~ d2.noise$option)
plot.default(d2.noise$Y ~ d2.noise$option)
#自由度はサンプルサイズから変数の数を引いたもの
#自由度はサンプルサイズから１と予測の自由度を引いたものでもある
sum.sq.ANOVA <- sum((d2.noise$Y - mean(d2.noise$Y)) ^ 2)
noise <- sum((d2.noise$Y - mean(d2.noise$Y)) ^ 2) / (length(d2.noise$Y) - 3)

# F-value, pf: F distribution %
# 条件別期待値の分散と予測残差の分散の比の検定
F.ratio <- effect / noise
1 - pf(F.ratio, 2, 12)

# Module
lm.model.anova <- lm(Y ~ option, data = d2)
anova(lm.model.anova)
summary(lm.model.anova)

# Comparison
# Naive Model
lm.model.NULL <- lm(Y ~ 1, data = d2)
predict(lm.model.NULL)
d2.noise.NULL <- data.frame(
  Y = d2$Y - 6,
  option = rep(c("A", "B", "C"), each = 5)
)
sum.sq.NULL <- sum((d2.noise.NULL$Y - mean(d2.noise.NULL$Y)) ^ 2)
#ナイーブモデルと条件別期待値モデルの予測残差の差の検定
#分母（基準化）条件別期待値モデルの残差分散を用いる
F.ratio2 <- (sum.sq.NULL - sum.sq.ANOVA) / 2 / noise
1 - pf(F.ratio2, 2, 12)

anova(lm.model.NULL, lm.model.anova)
anova(lm.model.NULL)
# ⇒ 結果は同じになる


# Regression --------------------------------------------------------------

d3 <- data.frame(
  Y = c(3, 4, 5, 6, 7),
  X = 1:5
)

nrow(d3)
pairs(d3)
plot(d3$Y ~ d3$X)
summary(lm(Y ~ X, data = d3))
lm(Y ~ X, data = d3)
anova(lm(Y ~ X, data = d3))

# Estimate
yosoku <- function(a, b, X){
  Yhat <- a * X + b
  return(Yhat)
}
yosoku(a = 1, b = 2, X = 1)

# Residual
zansa <- function(Y, Yhat){
  zansa <- (Y - Yhat) ^ 2
  return(zansa)
}
zansa(2, 3)

# Residual vectors
zansa2 <- numeric()
a <- 2
b <- 2
for (i in 1:nrow(d3)){
  Yhat <- yosoku(a, b, d3$X[i])
  zansa2[i] <- zansa(d3$Y[i], Yhat)
}
sum.zansa2 <- sum(zansa2)

plot(d3$Y ~ d3$X, ylim = c(0, 15), main = c("a=2, b=2の時の予測結果"))
abline(a = 2, b = 2)

# Original Function
# 指定した予測モデルについて残差ベクトルを算出
OLS <- function(para){
  zansa2 <- numeric()
  for (i in 1:nrow(d3)){
    Yhat <- yosoku(para[1], para[2], d3$X[i])
    zansa2[i] <- zansa(d3$Y[i], Yhat)
  }
  sum.zansa2 <- sum(zansa2)
  return(sum.zansa2)
}

OLS(c(2, 2))
#第一変数を初期値として、第二変数に指定した関数を最小化するパラメータを求める
optim(c(2, 2), OLS)
#線形回帰の結果は残差平方和を最小化する
lm.model <- lm(Y ~ X, data = d3)
#完全にフィットした回帰直線はANOVAできない
anova(lm.model)

# Vector
OLS2 <- function(para){
  Yhat <- yosoku(para[1], para[2], d3$X)
  zansa2 <- zansa(d3$Y, Yhat)
  sum.zansa2 <- sum(zansa2)
  return(sum.zansa2)
}
OLS2(c(2, 2))
optim(c(2, 2), OLS2)

# Function
bai <- function(x){
  return(2 * x)
}
bai <- function(x) return(2 * x)
sample.data <- 1:10
bai(sample.data)

# ANOVAで線形モデルを評価
lm.model <- lm(Y ~ X, data = d3)
lm.model$coef
yosokuti <- yosoku(lm.model$coef[2], lm.model$coef[1], d3$X)

#予測値の変動（分子）
#線形予測の自由度は１（説明変数が決まれば予測値が決まる）
heihou <- zansa(mean(yosokuti), yosokuti)
Effect <- sum(heihou) / 1

#予測残差の変動
#自由度はサンプル数から１（標本平均の制約）と予測値の変動の自由度１を引いたもの
gosa <- zansa(d3$Y, yosokuti)
Error <- sum(gosa) /  3

F.value <- Effect / Error
1 - pf(F.value, 1, 3)
anova(lm.model)

#ナイーブ予測と線形予測の比較
#定数項のみのモデル
lm.model.NULL <- lm(Y ~ 1, data = d3)
predict(lm.model.NULL)
mean(d3$Y)
#全て同じ
anova(lm.model.NULL, lm.model)
anova(lm.model, lm.model.NULL)
anova(lm.model)
summary(lm.model)

# Boot Strap --------------------------------------------------------------

# Data
d3 <- data.frame(
  Y = c(3, 4, 5, 6, 7),
  X = 1:5
)

lm.model.NULL <= lm(Y ~ 1, data = d3)
predict(lm.model.NULL)

lm.model <- lm(Y ~ X, data = d3)
anova(lm.model)

simulate(lm.model.NULL, 1)
sim.data <- cbind(
  simulate(lm.model.NULL, 1),
  1:5
)
colnames(sim.data) <- c("Y", "X")
mean(sim.data$Y)

summary(lm(Y ~ X, data = sim.data))
anova(lm(Y ~ X, data = sim.data))

# Symulation
# ランダムなデータに対して線形予測モデルを作成
set.seed(1)
Nsim <- 10000
#5個の予測を行う1000回のシミュレーション
#条件と同じ自由度のF分布を作る作業
sim <- simulate(lm.model.NULL, Nsim)
sim.F.value <- numeric()
for(i in 1:Nsim){
  sim.data <- cbind(sim[i], 1:5)
  colnames(sim.data) <- c("Y", "X")
  model <- lm(Y ~ X, data = sim.data)
  sim.F.value[i] <- summary(model)$fstatistic[1] 
}
max(sim.F.value)
F.value <- subset(sim.F.value, sim.F.value < 20)
length(F.value)
hist(F.value, xlim = c(0, 20))
stem(F.value)
# ⇒　ランダムな系列に線形モデルを適用しても予測精度は上がらない
# F値は低い

2 < 3
2 > 3
1:10 > 6
sum(1:10 > 6)
summary(lm.model)$fstatistic[1]
sum(sim.F.value >= summary(lm.model)$fstatistic[1]) / Nsim
anova(lm.model)
# 当然、完全フィットのF値は異常に高く、p値はゼロ⇒意味のない数字

# pf: 指定値を下回る確率（累積密度分布）
# df: 密度分布
x <- seq(0, 20, by = 0.1)
F <- df(x, 1, 3)
hist(F.value, xlim = c(0, 20), ylim = c(0, 1), prob = T, breaks = 50)
lines(x, F, col = 2, lwd = 2)

#分布の作成
#鞍点
x <- seq(-10, 10, by = 0.1)
N1 <- dnorm(x, mean = 0, sd = 1)
N2 <- dnorm(x, mean = 2, sd = 1)
N3 <- dnorm(x, mean = 0, sd = 2)
#枠だけ、"n"はプロットしない
plot(0, 0, type = "n", xlim = c(-7, 7), ylim = c(0, 0.5), 
     xlab = "", ylab = "確率", main = "正規分布", cex.main = 1.2)
lines(N1 ~ x, col = 1, lwd = 4)
lines(N2 ~ x, col = 2, lwd = 4)
lines(N3 ~ x, col = 3, lwd = 4)
abline(v = 0)
legend("topleft",
       lwd = 4,
       col = c(1, 2, 3),
       bty = "n",
       legend = c("平均0、分散1", "平均2、分散1", "平均0、分散2"),
       cex = 0.8)


# Excercise1
getwd()
data0 <- read.csv("data0.csv")
head(data0)
pairs(data0)
summary(data0)
hist(data0$length)
plot(data0$length ~ data0$medicine)

model.0 <- lm(length ~ food + medicine, data = data0)
#モデル全体のF値を得る
summary(model.0)
#各説明変数のF値を得る
anova(model.0)

# Exercise2
set.seed(1)
x.sim <- rnorm(mean = 5, sd = 10, n = 100)
hist(x.sim)
y.sim <- x.sim * 0.8 + 5 + rnorm(mean = 0, sd = 10, n = 100)
hist(y.sim)
plot(y.sim ~ x.sim)
model.sim <- lm(y.sim ~ x.sim)
summary(model.sim)
new.sim <- data.frame(x.sim = seq(min(x.sim), max(x.sim), by = 0.1))
#se.fit: 標準誤差を出力、interval: 出力する予測値のタイプ
#信頼区間、95%のモデルがこの範囲に収まる
sinrai <-  predict(
  model.sim, newdata = new.sim, se.fit = T, interval =  "confidence"
)
plot(y.sim ~ x.sim)
lines(sinrai$fit[, 1] ~ new.sim$x.sim, lwd = 2)
lines(sinrai$fit[, 2] ~ new.sim$x.sim, lwd = 2, col = 4)
lines(sinrai$fit[, 3] ~ new.sim$x.sim, lwd = 2, col = 2)

#予測区間、95%のデータがこの範囲に収まる
yosoku <- predict(
  model.sim, newdata = new.sim, se.fit = T, interval = "predict"
)
plot(y.sim ~ x.sim)
lines(yosoku$fit[, 1] ~ new.sim$x.sim, lwd = 2)
lines(yosoku$fit[, 2] ~ new.sim$x.sim, lwd = 2, col = 4)
lines(yosoku$fit[, 3] ~ new.sim$x.sim, lwd = 2, col = 2)
yosoku$residual.scale

plot(y.sim ~ x.sim)
lines(sinrai$fit[, 1] ~ new.sim$x.sim, lwd = 2)
lines(sinrai$fit[, 2] ~ new.sim$x.sim, lwd = 2, col = 4)
lines(sinrai$fit[, 3] ~ new.sim$x.sim, lwd = 2, col = 2)
lines(yosoku$fit[, 2] ~ new.sim$x.sim, lwd = 2, col = 4, lty = 2)
lines(yosoku$fit[, 3] ~ new.sim$x.sim, lwd = 2, col = 2, lty = 2)

# 中心極限定理の確認
N.sample <- 1
# replace: 重複の有無
saikoro <- sample(1:6, size = N.sample, replace = T)
N.sim <- 10000
kekka <-  numeric()
for(i in 1:N.sim){
  kekka[i] <- sample(1:6, size = N.sample, replace = T)
}
hist(kekka, breaks = 0:6)

# ５回の合計値
N.sample <- 5
N.sim <- 1000
kekka <- numeric()
for(i in 1:N.sim){
  kekka[i] <- sum(sample(1:6, size = N.sample, replace = T))
}
hist(kekka, breaks = min(kekka):max(kekka))

# １０回の合計値①
N.sample <- 10
N.sim <- 1000
kekka <- numeric()
for(i in 1:N.sim){
  kekka[i] <- sum(sample(1:6, size = N.sample, replace = T))
}
hist(kekka, breaks = min(kekka):max(kekka))

# １０回の合計値②
N.sample <- 10
N.sim <- 10000
kekka <- numeric()
for(i in 1:N.sim){
  kekka[i] <- sum(sample(1:6, size = N.sample, replace = T))
}
hist(kekka, breaks = min(kekka):max(kekka))




# AIC ---------------------------------------------------------------------
#check
data1 <- read.csv("data1.csv")
head(data1)
nrow(data1)
ncol(data1)
class(data1)
pairs(data1)
pairs(data1, panel = panel.smooth)
summary(data1)
names(data1)
levels(data1$option1)
levels(data1$option2)

#modeling
lm.model.1 <- lm(Y ~ ., data = data1)
summary(lm.model.1)
anova(lm.model.1)

lm.model.2 <- update(lm.model.1, ~ .-option2)
summary(lm.model.2)

anova(lm.model.1, lm.model.2)

anova(lm.model.2)

lm.model.3 <- update(lm.model.2, ~.-x1)
anova(lm.model.3)

lm.model.4 <- update(lm.model.3, ~.-x2)
anova(lm.model.4)

anova(lm.model.3, lm.model.4)

anova(lm.model.2, lm.model.3)

best.model.anova <- lm.model.3
summary(best.model.anova)
summary(lm.model.1)


rm(list = ls())

#複数モデル検定用モジュール
install.packages("MuMIn")
library(MuMIn)
lm.model.1 <- lm(Y ~ ., data = data1, na.action = "na.fail")

list <- dredge(lm.model.1, rank = "AIC")
all.model <- get.models(list, subset = TRUE)
best.model.AIC <- all.model[1]


# ANOVA Type2 -------------------------------------------------------------

data2 <- read.csv("data2.csv")
head(data2)
summary(data2)
pairs(data2)
pairs(data2, panel = panel.smooth)
hist(data2$sell, breaks = 20)
hist(data2$experience, breaks = 10)
hist(data2$n.sheets, breaks = 10)

#ダメな例
summary(lm(sell ~ experience, data = data2))
summary(lm(sell ~ n.sheets, data = data2))
anova(lm(sell ~ experience, data = data2))
anova(lm(sell ~ n.sheets, data = data2))
t.test(data2$sell ~ data2$sex)
t.test(data2$sell ~ data2$time)

summary(lm(sell ~ sex, data = data2))
summary(lm(sell ~ time, data = data2))

mean(data2$sell[data2$time == "day"])
mean(data2$sell[data2$time == "night"])
mean(data2$sell[data2$sex == "female"])
mean(data2$sell[data2$sex == "male"])

#正しい例、まとめて行う
sell.model1 <- lm(sell ~ ., data = data2)
sell.model1$coef
anova(sell.model1)
summary(sell.model1)

par(mfrow = c(1, 2))
plot(data2$n.sheets ~ data2$experience)
plot(data2$sex ~ data2$time)
plot(data2$time ~ data2$sex)
plot(data2$sell ~ data2$n.sheets)
plot(data2$sell ~ data2$time)

#回帰関連パッケージ
#Type2 Anovaがある
install.packages("car")
library(car)
sell.model1
anova(sell.model1)
Anova(sell.model1, type = c("II"))
sell.model2 <- update(sell.model1, ~.-sex)
anova(sell.model2)
Anova(sell.model2)
sell.model3 <- update(sell.model2, ~.-experience)
anova(sell.model3)
Anova(sell.model3)
summary(sell.model3)

library(MuMIn)
lm.model.1 <- lm(Y ~ ., data = data1, na.action = "na.fail")
sell.list <- dredge(sell.model1, rank = "AIC")
all.model.sell <- get.models(sell.list, subset = TRUE)
best.sell.AIC <- all.model.sell[1]
summary(best.sell.AIC)

# 交互作用 --------------------------------------------------------------------

data3 <- read.csv("data3.csv")
head(data3)
summary(data3)
pairs(data3)


#変数を個別に分析するのは悪い例
summary(lm(beer ~ temperature, data = data3))
t.test(data3$beer ~ data3$weather)　#差の検定

#まずはまとめてやる
model.beer0 <- lm(beer ~ ., data = data3)
summary(model.beer0)
anova(model.beer0)
library(car)
Anova(model.beer0)

fine <- subset(data3, weather == "fine")
rain <- subset(data3, weather == "rain")
par(mfrow = c(1, 2))
plot(fine$beer ~ fine$temperature, main = "fine")
plot(rain$beer ~ rain$temperature, main = "rain")
summary(rain)

lm(beer ~ temperature + weather + temperature:weather, data = data3)
lm(beer ~ temperature * weather, data = data3)
lm(beer ~ (.)^2, data = data3)
model.beer <- lm(beer ~ (.)^2, data = data3, na.action = "na.fail")
summary(model.beer)
anova(model.beer)
Anova(model.beer)
#ANOVA Type2は交差項を無視する
Anova(model.beer, type = "II") #同じ
#Type3でやる
Anova(model.beer, type = "III")
model.chk <- lm(beer ~ temperature + weather, data = data3)
anova(model.chk)
model.beer$coef
library(MuMIn)
dredge(model.beer, rank = "AIC")
c(1, 2)[data3$weather]
plot(data3$beer ~ data3$temperature,
     col = c(1, 2)[data3$weather],
     pch = 16,
     xlab = "temperature",
     ylab = "beer",
     main = "beer by weather",
     font.lab = 2)
legend("bottomright", 
       pch = 16, 
       col = c(1, 2), 
       legend = c("fine", "rain"))
abline(
  model.beer$coef[1],
  model.beer$coef[2],
  lwd = 2
)
abline(
  model.beer$coef[1] + model.beer$coef[3],
  model.beer$coef[2] + model.beer$coef[4],
  lwd = 2,
  col = 2
)







1347






