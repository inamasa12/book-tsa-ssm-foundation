# R Preparation -----------------------------------------------------------

# get current directory 
getwd()
# set current directory
setwd("C:/Users/mas/learning/book-tsa-ssm-foundation/MyObjects")


# Basic -------------------------------------------------------------------

#パーセンタイル値
pnorm(q=0, mean=3, sd=2)

#区分値、信頼区間を求める
qnorm(p=0.025, mean=3, sd=sqrt(4/3))
qnorm(p=0.975, mean=3, sd=sqrt(4/3))
qnorm(p=0.025, mean=0, sd=1)
qnorm(p=0.975, mean=0, sd=1)

#t検定
x <- c(-1, -1, 0, 0, 1, 3, 5, 6, 7, 7)
m <- mean(x)
sd <- sd(x)
n <- length(x)
se <- sd /  sqrt(n)
t <- (m - 0) / se
(1 - pt(t, n-1)) * 2

trand <- rt(1000, n-1)
sum(trand >= t) / length(trand) * 2

#カイ二乗検定
ABtest_data <- data.frame(
  button = c("blue", "blue", "red", "red"),
  result = c("press", "not", "press", "not"),
  number = c(70, 180, 30, 120)
)
cross_data <- xtabs(number ~ ., ABtest_data)
chisq.test(cross_data, correct=F)
chisq.test(cross_data)

#Fisherの正確確率検定
fisher.test(cross_data)

#t検定
data <- data.frame(
  X = c(2, 0, 3, -3, 4, 1, -1, 4),
  Y = c(5, -1, 2, -1, 7, 3, 4, 5)
)

#１群
t.test(data$X)

mean(data$X)
mean(data$Y)

#対応のある
t.test(data$X, data$Y, paired=T)

#分散比の検定
var.test(data$X, data$Y)
var(data$X)/var(data$Y)

#2群のt検定
t.test(data$X, data$Y, var.equal=T)
t.test(data$X, data$Y, var.equal=F)


#主成分分析
sample_data <- data.frame(
  X = c(2, 4, 6, 5, 7, 8, 10),
  Y = c(6, 8, 10, 11, 9, 12, 14))
plot(Y~X, data=sample_data)

pcr_model_sample <- prcomp(sample_data, scale=T)
#寄与率
summary(pcr_model_sample)
#主成分得点、新しい座標軸上の点
pcr_model_sample$x

par(mfrow=c(1, 2))
plot(Y ~ X, data=sample_data, main="original data")
biplot(pcr_model_sample, main="pcr")
par(mfrow=c(1, 1))

var(sample_data)
cor(sample_data)

#固有ベクトルは主成分（の軸）に一致する
eigen_m <- eigen(cor(sample_data))
eigen_m$vectors
pcr_model_sample$rotation

sample_mat <- as.matrix(sample_data)
par(mfrow=c(1, 2))
plot(
  sample_mat%*%eigen_m$vectors[, 1],
  sample_mat%*%eigen_m$vectors[, 2],
  main="固有ベクトルを使った回転"
)
plot(pcr_model_sample$x[, 1], pcr_model_sample$x[, 2])
par(mfrow=c(1, 1))

#アヤメ
iris
summary(iris)

install.packages("ggplot2")
install.packages("GGally")
install.packages("devtools")

library(ggplot2)
library(GGally)

#分類別のpairs
ggpairs(iris, aes_string(colour="Species", alpha=0.5))

pca_data <- iris[, -5]
model_pca_iris <- prcomp(pca_data, scale=T)
summary(model_pca_iris)

devtools::install_github("vqv/ggbiplot")
remove.packages("digest")
remove.packages("rlang")

library(ggbiplot)




# 単回帰 ---------------------------------------------------------------------

N <- 100
b0 <- 5
b1 <- 3
x <- rnorm(N)
e <- rnorm(n = N, sd = 2)
y <- b0 + b1 * x + e
plot(x, y)

model <- lm(y ~ x)

#新しいサンプルに対する予測
new <- data.frame(x=seq(min(x), max(x), 0.1))

#予測モデル、つまり期待値
lines(as.matrix(new), A$fit[, 1])

#信頼区間
#平均（期待値）の95%誤差範囲
A <- predict(model, new, se.fit = T, interval = "confidence")
lines(as.matrix(new), A$fit[, 2], col = "red")
lines(as.matrix(new), A$fit[, 3], col = "red")

#予測区間
#データの95%誤差範囲
B <- predict(model, new, se.fit = T, interval = "prediction")
lines(as.matrix(new), B$fit[, 2], col = "blue")
lines(as.matrix(new), B$fit[, 3], col = "blue")

c <- predict(model, new, se.fit=T)

#se.fitは標準誤差の集合
#下記は信頼区間（95%）を表す
C$fit - C$se.fit * qt(0.975, c$df)
C$fit + C$se.fit * qt(0.975, c$df)

#標準誤差プラス残差分散
#下記は予測区間（95%）を表す
C$fit - sqrt(C$se.fit^2 + C$residual.scale^2) * qt(0.975, C$df)
C$fit + sqrt(C$se.fit^2 + C$residual.scale^2) * qt(0.975, C$df)


# モデル選択
set.seed(0)
N <- 100
Intercept <- 5
B1 <- 10
B2 <- 5
x1 <- sort(rnorm(N, sd=2))
x2 <- rnorm(N, sd=2)
e <- rnorm(n=N, sd=3)
y <- Intercept + B1 * x1 + B2 * x2 + e

model1 <- lm(y ~ x1)
model2 <- lm(y ~ x1 + x2)
model3 <- lm(y ~ x1*x2)

#複雑なモデルから簡単なモデルへ修正していくのが基本
summary(model3)

#分散分析
anova(model2, model3)
anova(model1, model2)

#AIC
AIC(model1)
AIC(model2)
AIC(model3)

#最も複雑なモデル
model.best1 <- step(model3)
model.best1

library(MuMIn)
options(na.action="na.fail")
kekka.AIC <- dredge(model3, rank="AIC")
best.model <- get.models(kekka.AIC, subset=1)

avg.model <- model.avg(get.models(kekka.AIC, subset=delta < 4))
summary(avg.model)
summary(model3)

all.model <- get.models(kekka.AIC, subset=T)
all.model[1]
model2

#予測
A <- predict(model2, se.fit=T, interval="confidence")
B <- predict(model2, se.fit=T, interval="prediction")

plot(x1, y)
lines(x1, A$fit[, 1], lwd=1)
lines(x1, A$fit[, 2], col="red")
lines(x1, A$fit[, 3], col="red")
lines(x1, B$fit[, 2], col="blue")
lines(x1, B$fit[, 3], col="blue")
legend(2.5, 0, c("avg", "conf", "pred"), col=c(1, 2, 4), lwd=1)

# 平滑化スプラインと加法モデル
install.packages("mgcv")
library(mgcv)
head(airquality)
#線形回帰
lm.model <- lm(Ozone ~ Temp, data=airquality)
lm.model <- gam(Ozone ~ Temp, data=airquality)
#平滑化スプライン
gam.model <- gam(Ozone ~ s(Temp), data=airquality)

summary(lm.model)

#一番詳しい
str(summary(lm.model))
#構成要素名
attributes(summary(lm.model))

class(summary(lm.model))


summary(gam.model)
plot(gam.model, residuals=T, se=T, pch=".",
     main="spline", cex.main=2)
new <- data.frame(
  Temp=seq(min(airquality$Temp), max(airquality$Temp), 0.1)
)
lm.pred <- predict(lm.model, new)
gam.pred <- predict(gam.model, new)

plot(airquality$Ozone ~ airquality$Temp,
     xlab="Temp", ylab="Ozone",
     main="result", cex.main=1, cex.lab=1)
lines(lm.pred ~ as.matrix(new), col=2, lwd=2)
lines(gam.pred ~ as.matrix(new), col=4, lwd=2)
legend("topleft", lwd=2, col=c(2, 4), legend=c("lm", "spline"))

#モデル選択
anova(lm.model, gam.model, test="F")

DF <- summary(gam.model)$n

gam.dev <- sum(resid(gam.model)^2)
lm.dev <- sum(resid(lm.model)^2)

gam.df <- DF - summary(gam.model)$residual.df
lm.df <- DF - summary(lm.model)$residual.df

F <- ((lm.dev - gam.dev)/(gam.df - lm.df))/(gam.dev/(DF - gam.df))
1 - pf(F, gam.df - lm.df, DF - gam.df)

#平滑化パラメータ
sp <- seq(from=0.001, to=0.5, by=0.005)
GCV <- numeric()
for(i in 1:length(sp)){
  g.m <- gam(Ozone ~ s(Temp), sp=sp[i], data=airquality)
  GCV[i] <- g.m$gcv.ubre
}

plot(GCV ~ sp, main='GCV & spline paramater', cex.main=1)
points(gam.model$sp, gam.model$gcv.ubre, col=2, pch=18, cex=2)

windows(width = 14, height = 7)
par(mfrow=c(2, 2))
plot(gam(Ozone~s(Temp), sp=1000, data=airquality), residuals=T)
plot(gam(Ozone~s(Temp), sp=1, data=airquality), residuals=T)
plot(gam(Ozone~s(Temp), sp=0.00001, data=airquality), residuals=T)
plot(gam(Ozone~s(Temp), sp=0.00000000001, data=airquality), residuals=T)
par(mfrow=c(1, 1))

lm.modoki <- gam(Ozone~s(Temp), sp=100000, data=airquality)
plot(
  lm.modoki$fitted.values ~ lm.model$fitted.values,
  xlab="lm", ylab="spline", cex.lab=1.2
)
abline(a=0, b=1, col=2)

par(mfrow=c(2, 2))
gam.check(gam.model)
par(mfrow=c(1, 1))

#薄版平滑化スプライン
#変数間の相互効果を加味している
gam2 <- gam(Ozone ~ s(Wind, Temp), data=airquality)
vis.gam(gam2, color="cm", theta=45)
vis.gam(gam2, color="cm", plot.type = "contour")
gg <- gam(Ozone ~ s(Solar.R) + s(Wind, Temp), data=airquality)
vis.gam(gg, view=c("Wind", "Temp"), color="cm", theta=45)

Air <- na.omit(airquality)
length(Air[, 1])

set.seed(1)
S1 <- sample(1:111, size=30)
teach <- Air[-S1, ]
test <- Air[S1, ]

l.model <- lm(Ozone ~ Solar.R + Wind + Temp, data=teach)
g.model <- gam(Ozone ~ s(Solar.R) + s(Wind) + s(Temp),data=teach)

library(MuMIn)
options(na.action="na.fail")
a1 <- dredge(l.model, rank="AIC")
a2 <- dredge(g.model, rank="AIC")

lm.pred <- predict(l.model, test)
g.pred <- predict(g.model, test)
lm.resid <- sum((lm.pred - test$Ozone)^2)
g.resid <- sum((g.pred - test$Ozone)^2)
lm.resid
g.resid


#カオス時系列
install.packages("digest")
install.packages("nonlinearTseries")
library(nonlinearTseries)
logMap <- logisticMap(
  r=4,
  n.sample=100,
  start=0.4,
  n.transient=0,
  do.plot=TRUE
)

K <- 1
b <- 3
c <- 1
x <- seq(-5, 10, 0.1)
y <- K / (1 + b * exp(- c * x))
plot(y ~ x, type="l", main="logistic")

#ラグのペアを生成
1:5
embed(1:5, 2)

lagData <- embed(y, 2)
y[1:5]
lagData[1:5, ]

#差分
diffData <- lagData[, 1] - lagData[,2]

plot(diffData ~ lagData[, 1],
     ylab="delta y",
     xlab="y",
     main="delta y")

lagLogMap <- embed(logMap, 2)
lagLogMap[1:5,]
plot(lagLogMap[, 1] ~ lagLogMap[, 2],
     xlab="CY",
     ylab="FY",
     main="CY vs FY")


logMap[1:5]
4 * 0.4 * (1-0.4)

x0 <- 0.4
x <- numeric(100)
x[1] <- x0
r <- 4
for (i in 2:100){
  x[i] <- r * x[i-1] * (1 - x[i-1])
}
x[-1]

logMap2 <- logisticMap(
  n.sample=100,
  start=0.400000001,
  n.transient=0,
  do.plot=F
)
ts.plot(
  ts(logMap),
  ts(logMap2),
  col=c(1,2),
  lty=c(1,2),
  lwd=c(1,2),
  main="logistic"
)
logMap3 <- logisticMap(
  r=3.5,
  n.sample=100,
  start=0.4,
  n.transient=0,
  do.plot=F
)

#ロジスティック写像の微分関数
logMapDifferential <- function(r, x){
  return(-2*r*x+r)
}

#リアプノフ指数、カオス時系列かどうかを判定
sum(log(abs(logMapDifferential(4, logMap)))) / length(logMap)
sum(log(abs(logMapDifferential(3.5, logMap3)))) / length(logMap)

#サロゲートテスト
#カオス系列をテスト
#帰無仮説へ「線形の確率過程である」
surrogateTest(
  time.series = logMap,
  significance = 0.05,
  K = 1,
  one.sided = FALSE,
  FUN = timeAsymmetry
)

#正規乱数をテスト
set.seed(1)
surrogateTest(
  time.series = rnorm(100),
  significance = 0.05,
  K = 1,
  one.sided = FALSE,
  FUN = timeAsymmetry
)

#カオスをARIMAで表現
install.packages("forecast")
install.packages("rlang")
library(forecast)
logMapArima <- auto.arima(
  logMap,
  ic = "aic",
  trace = T,
  stepwise = F,
  approximation = F
)
logMapArima

logMapNext <- logisticMap(
  r = 4,
  n.sample = 120,
  start = 0.4,
  n.transient = 0,
  do.plot = FALSE
)
plot(forecast(logMapArima, h=20))
lines(logMapNext)

#予測誤差
f <- forecast(logMapArima, h=20)$mean
sqrt(sum((f - logMapNext[100:119])^2)/20)
sum(abs(f - logMapNext[100:119]))/20
accuracy(forecast(logMapArima, h=20), logMapNext[100:119])

# カオス時系列をニューラルネットワークで予測
# 三層、中間ノード4
set.seed(1)
logMapNnet <- nnetar(
  y = logMap,
  p = 1,
  size = 4
)
plot(forecast(logMapNnet, h=20))
lines(logMapNext)
accuracy(forecast(logMapNnet, h=20), logMapNext[100:119])
accuracy(forecast(logMapNnet, h=5), logMapNext[100:104])
    

## MIC

install.packages("minerva")
library(minerva)

x <- 1:100
y <- 3 * x + 2
plot(y ~ x, xlab="", ylab="", type="l", lwd=3, main="linear", cex.main=2)

mine(x, y)
cor(y, x)

x <- 1:500
y <- x * 10 - 0.02 * x ^ 2 + 13
plot(y ~ x, xlab="", ylab="", type="l", lwd=3, main="x^2", cex.main=2)
mine(x, y)
cor(x, y)

x <- seq(1, 20, by=0.01)
y <- 1/x
plot(y ~ x, xlab="", ylab="", type="l", lwd=3, main="1/x", cex.main=1)
mine(x, y)

set.seed(10)
para <- 20
x2 <- c(rnorm(n=50, mean=10, sd=para), rnorm(n=50, mean=200, sd=para))
y2 <- c(rnorm(n=50, mean=10, sd=para), rnorm(n=50, mean=200, sd=para))
plot(y2 ~ x2, xlab="", ylab="", pch=16, main="imitate", cex.main=1)
mine(x2, y2)
cor(x2, y2)


# Stock Selection, 
getStockFromKdb <- function(code, year){
  stocks <- NULL
  for(i in 1:length(code)){
    for (j in 1:length(year)){
      url <- paste(code[i], "_", year[j], ".csv", sep="")
      stock <- read.csv(url, skip = 1, header = T)
      colnames(stock) <- c("Date", "Open", "High", "Low", "Close", "Volume", "Volume_money")
      stock["Volume_money"] <- as.numeric(stock[,"Close"]) * as.numeric(stock[,"Volume"])
      tickerSymbol <- data.frame(tickerSymbol = rep(code[i], nrow(stock)))
      stock <- cbind(tickerSymbol, stock)
      if(is.null(stocks)){
        stocks <- stock
      } else {
        stocks <- rbind(stocks, stock)
      }
      if(i < length(code) || j < length(year)){
        Sys.sleep(0.5)
      }
    }
  }
  return(stocks)
}

res <- getStockFromKdb(c(7201, 7203), 2017:2018)

head(nissan)

nissan <- res[res$tickerSymbol == 7201, -1]
toyota <- res[res$tickerSymbol == 7203, -1]


library(quantmod)
nissan_xts <- as.xts(read.zoo(nissan))
toyota_xts <- as.xts(read.zoo(toyota))
class(nissan_xts)

first(nissan_xts)
last(nissan_xts)
nissan_xts["2017-02-02"]
nissan_xts["2017-02"]
nissan_xts["2017-02-01::2017-02-06"]
nissan_xts["2017-02-01::"]
nissan_xts["2018-08::"]

chartSeries(
  nissan_xts,
  type = "candlestick"
)

chartSeries(
  nissan_xts,
  subset = "2017-7",
  type = "candlestick"
)

chartSeries(
  nissan_xts,
  subset = "2018-7::",
  type = "candlestick",
  TA = "addSMA(n=25, col='white'); addSMA(n=75, col='green')"
)

chartSeries(
  toyota_xts,
  subset = "2018-7::",
  type = "candlestick",
  TA = "addSMA(n=25, col='white'); addSMA(n=75, col='green')"
)

chartSeries(
  nissan_xts,
  subset = "2018-7::",
  type = "candlestick",
  TA = "addSMA(n=25, col='white'); addSMA(n=75, col='green'); addVo()",
  theme = chartTheme('white', up.col='white', up.col='white', dn.col='blue')
)

mean(nissan_xts['2017', 'Close'])
idx <- index(nissan_xts['2017'])
N <- length(idx)
mean_data <- xts(rep(mean(nissan_xts['2017', 'Close']), N), order.by=idx)

chartSeries(nissan_xts, subset="2017")
addTA(mean_data, on=1, lwd=2)


#予測の評価
library(forecast)
set.seed(1)

#データ
white_noise <- ts(rnorm(n=450, mean=0, sd=10), start=1)
train_wn <- window(white_noise, end=400)
test_wn <- window(white_noise, start=401)
length(test_wn)


#ナイーブ予測、50期
#過去平均値
model_wn <- meanf(train_wn, h=50)
accuracy(model_wn, test_wn)
plot(model_wn)
lines(white_noise)

#前期値を予測
set.seed(8)
random_walk <- ts(cumsum(rnorm(n=450, mean=0, sd=10)), start=1)
train_rw <- window(random_walk, end=400)
test_rw <- window(random_walk, start=401)
model_rw <- rwf(train_rw, h=50)
train_rw[400]
accuracy(model_rw, test_rw)

model_wn_2 <- meanf(train_rw, h=50)
mean(train_rw)
par(mfrow=c(2, 1), mar=c(2.5, 4, 2.5, 4))
plot(model_rw)
lines(random_walk)
plot(model_wn_2)
lines(random_walk)

accuracy(model_rw, test_rw)
accuracy(model_wn_2, test_rw)


#ARIMA
nissan <- getStockFromKdb(c(7201), 2017:2018)
toyota <- getStockFromKdb(c(7203), 2017:2018)

library(quantmod)
head(nissan)
nissan_xts <- as.xts(read.zoo(nissan[, -1]))
toyota_xts <- as.xts(read.zoo(toyota[, -1]))

chartSeries(
  nissan_xts,
  type="candlesticks"
)

chartSeries(
  toyota_xts,
  type="candlesticks"
)

nissan_log_diff <- diff(log(nissan_xts$Close))[-1]
nissan_train <- nissan_log_diff["::2017-12-31"]
nissan_test <-  nissan_log_diff["2018-07-01::"]

toyota_log_diff <- diff(log(toyota_xts$Close))[-1]
toyota_train <- toyota_log_diff["::2017-12-31"]
toyota_test <-  toyota_log_diff["2018-01-01::"]
toyota_test <- toyota_test[1:9]


library(forecast)

model_arima_nissan <- auto.arima(
  nissan_train,
  ic="aic",
  stepwise=F,
  approximation=F,
  max.p=10,
  max.q=10,
  max.order=20
)

model_arima_toyota <- auto.arima(
  toyota_train,
  ic="aic",
  stepwise=F,
  approximation=F,
  max.p=10,
  max.q=10,
  max.order=20
)


f_arima <- forecast(model_arima_toyota, h=1)$mean
f_rw <- rwf(toyota_train)
f_mean <- meanf(train)

accuracy(f_arima, toyota_test)
accuracy(f_rw, toyota_test)
accuracy(f_mean, toyota_test)

#一期先予想
calcForecast <- function(data){
  model <- Arima(data, order=c(0, 1, 1))
  return(forecast(model, h=1)$mean)
}

length(toyota_train)
f_arima_2 <- rollapply(toyota_log_diff, 245, calcForecast)
f_arima_2 <- lag(f_arima_2)
f_arima_2 <- f_arima_2[!is.na(f_arima_2)]

f_mean_2 <- rollapply(toyota_log_diff, 245, mean)
f_mean_2 <- lag(f_mean_2)
f_mean_2 <- f_mean_2[!is.na(f_mean_2)]

f_rw_2 <- lag(toyota_log_diff["2017-12-29::"])
f_rw_2 <- f_rw_2[!is.na(f_rw_2)]

accuracy(as.ts(f_arima_2), test)
accuracy(as.ts(f_mean_2), test)
accuracy(as.ts(f_rw_2), test)
plot(toyota_log_diff["2017-10::"])
lines(f_arima_2, col=2, lwd=2)
lines(f_mean_2, col=4, lwd=2)
lines(f_rw_2, col=5, lwd=2)
