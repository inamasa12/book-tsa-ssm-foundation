
# get current directory 
getwd()
# set current directory
setwd("C:/Users/mas/learning/book-tsa-ssm-foundation/MyObjects")


# ポアソン回帰 ------------------------------------------------------------------

y <- c(7, 9, 8, 11)
plot(y, pch = 16, ylim = c(0, 15), cex = 2)

  lambda <- 9
dpois(7, lambda = lambda)
dpois(9, lambda = lambda)
dpois(8, lambda = lambda)
dpois(11, lambda = lambda)

kaijou <- function(x) gamma(x + 1)
kaijou(3)

exp(-lambda) * lambda ^ 7 / kaijyou(7)

x <- 1:20
par(mfrow = c(1, 2))
lambda <- 5
plot(x, dpois(x, lambda = lambda), type = "b", ylab = "probability", main = "lambda = 5")
plot(dpois(x, lambda = lambda) ~ x, type = "b", ylab = "probability", main = "lambda = 5")
points(7, dpois(7, lambda = lambda), pch = 16, cex = 2, col = 2)
points(9, dpois(9, lambda = lambda), pch = 16, cex = 2, col = 2)
points(8, dpois(8, lambda = lambda), pch = 16, cex = 2, col = 2)
points(11, dpois(11, lambda = lambda), pch = 16, cex = 2, col = 2)

lambda <- 9
plot(x, dpois(x, lambda = lambda), type = "b", ylab = "probability", main = "lambda = 9")
points(7, dpois(7, lambda = lambda), pch = 16, cex = 2, col = 2)
points(9, dpois(9, lambda = lambda), pch = 16, cex = 2, col = 2)
points(8, dpois(8, lambda = lambda), pch = 16, cex = 2, col = 2)
points(11, dpois(11, lambda = lambda), pch = 16, cex = 2, col = 2)

dpois(lambda = 5, y)
prod(dpois(lambda = 5, y))
log(prod(dpois(lambda = 5, y)))
sum(log(dpois(lambda = 5, y)))

dpois(lambda = 9, y)
prod(dpois(lambda = 9, y))
log(prod(dpois(lambda = 9, y)))

x <- seq(0, 15, by = 0.01)
y <- c(7, 9, 8, 11)
kekka <- numeric()

for(i in 1:length(x)){
  kekka[i] <- prod(dpois(lambda = x[i], y))
}
plot(kekka ~ x, type = "l", xlab = "lambda", ylab = "probability", lwd = 4)
max(kekka)
kekka.list <- data.frame(x = x, kekka = kekka)
kekka.list
subset(kekka.list, kekka.list$kekka == max(kekka))

f.Lik <- function(para){
  f.Lik <- -prod(dpois(lambda = para, y))
  return(f.Lik)
}

f.Lik(9)
f.Lik(10)
f.Lik(15)

optim(fn = f.Lik, par = c(8), method = "Brent", lower = 0, upper = 10)
optim(fn = f.Lik, par = c(8), method = "BFGS")
optim(fn = f.Lik, par = c(8))

f.logLik <- function(para){
  f.logLik <- -sum(log(dpois(lambda = para, y)))
  return(f.logLik)
}

f.logLik(9)
f.logLik(10)

optim(fn = f.logLik, par = c(8), method = "Brent", lower = 0, upper = 10)
optim(fn = f.logLik, par = c(8), method = "BFGS")
optim(fn = f.logLik, par = c(8))
mean(y)

x <- 1:4
y <- c(5, 7, 10, 15)

plot(y ~ x, pch = 16, cex = 2)

para <- c(1, 0.2)
a <- para[1]
b <- para[2]

lambda <- exp(a + b * x)
Lik <- dpois(y, lambda = lambda)
prod(Lik)
logLik <- log(dpois(y, lambda = lambda))
sum(logLik)
log(prod(Lik))

ML <- function(para){
  a <- para[1]
  b <- para[2]
  lambda <- exp(a + b * x)
  logLik <- - sum(log(dpois(y, lambda = lambda)))
  return(logLik)
}


result <- optim(fn = ML, par = c(1, 0.2))
result.par <- result$par

result.par[1] + result.par[2] * x
best.lambda <- exp(result.par[1] + result.par[2] * x)

plot(y ~ x, pch = 16, cex = 3)
lines(best.lambda ~ x, lwd = 4, col = 2)

y <- 1:20
dpois(y, best.lambda[1])
plot(dpois(y, best.lambda[1]) ~ y, type = "b", lwd = 3, pch = 16, cex = 2)

dpois(0, best.lambda[1])

par(mfrow = c(2, 2))
plot(dpois(y, best.lambda[1]) ~ y, type = "b", lwd = 3, pch = 16, cex = 1.2,
     main = "x=1", xlab = "", ylab = "", cex.main = 1.5)
plot(dpois(y, best.lambda[2]) ~ y, type = "b", lwd = 3, pch = 16, cex = 1.2,
     main = "x=2", xlab = "", ylab = "", cex.main = 1.5)
plot(dpois(y, best.lambda[3]) ~ y, type = "b", lwd = 3, pch = 16, cex = 1.2,
     main = "x=3", xlab = "", ylab = "", cex.main = 1.5)
plot(dpois(y, best.lambda[4]) ~ y, type = "b", lwd = 3, pch = 16, cex = 1.2,
     main = "x=4", xlab = "", ylab = "", cex.main = 1.5)
par(mfrow = c(1, 1,))



# deviance ----------------------------------------------------------------

x <- 1:4
y <-  c(5, 7, 10, 15)
plot(y ~ x, pch = 16, ylim = c(3, 17), cex = 2)

#Perfect estimates ⇒ データと分布の平均値が一致
dpois(5, lambda = 5)
dpois(7, lambda = 7)
dpois(10, lambda = 10)
dpois(15, lambda = 15)
logLik.full <- log(dpois(5, lambda = 5)) + log(dpois(7, lambda = 7)) + log(dpois(10, lambda = 10)) + log(dpois(15, lambda = 15))

#Model Estimate
dpois(5, best.lambda[1])
dpois(7, best.lambda[2])
dpois(10, best.lambda[3])
dpois(15, best.lambda[4])
logLik.ML <- log(dpois(5, lambda = best.lambda[1])) + log(dpois(7, lambda = best.lambda[2])) + log(dpois(10, lambda = best.lambda[3])) + log(dpois(15, lambda = best.lambda[4]))

#Residual deviance
logLik.full - logLik.ML
(logLik.full - logLik.ML) * 2

model.poisson <- glm(y ~ x, family = "poisson")
summary(model.poisson)
coef(model.poisson)
result.par
deviance(model.poisson)
#response
#実際の予測残差
resid(model.poisson, type = "response")
y - exp(predict(model.poisson))
y - predict(model.poisson, type = "response")

#deviance
resid(model.poisson, type = "deviance")
resid(model.poisson)

best.lambda <- predict(model.poisson, type = "response")

sqrt((log(dpois(5, lambda = 5)) - log(dpois(5, lambda = best.lambda[1]))) * 2)
sqrt((log(dpois(7, lambda = 7)) - log(dpois(7, lambda = best.lambda[2]))) * 2)
sqrt((log(dpois(10, lambda = 10)) - log(dpois(10, lambda = best.lambda[3]))) * 2)
sqrt((log(dpois(15, lambda = 15)) - log(dpois(15, lambda = best.lambda[2]))) * 2)
sign(y - best.lambda)

sum(resid(model.poisson)^2)
deviance(model.poisson)
summary(model.poisson)


#尤度比検定
rm(list = ls())
x <- 1:4
y <- c(5, 7, 10, 15)
plot(y ~ x, pch = 16, ylim = c(3, 17), cex = 2)
model.poisson <- glm(y ~ x, family = "poisson")
summary(model.poisson)
model.null <- glm(y ~ 1, family = "poisson")
summary(model.null)

deviance(model.poisson)
deviance(model.null)

#対数尤度
logLik(model.poisson)
logLik(model.null)

#尤度比
2 * (logLik(model.poisson) - logLik(model.null))
dev <- deviance(model.null) - deviance(model.poisson)

1 - pchisq(dev, df = 1)
anova(model.poisson, test = "Chisq")


# AIC ---------------------------------------------------------------------

AIC(model.poisson)
#モデル（予測値）の対数尤度
logLik(model.poisson)
#対数尤度の期待値とするためバイアス調整
logLik(model.poisson) - 2
#AIC
(logLik(model.poisson) - 2) * -2
summary(model.poisson)



# poisson -----------------------------------------------------------------

data4 <- read.csv("data4.csv")
head(data4)
summary(data4)
pairs(data4)
plot(data4$y ~ data4$x)
dim(data4)

#切片、傾き
para <- c(1, 0.2)
a <- para[1]
b <- para[2]

#ポアソン分布を仮定して、yの期待値を予測
lambda = exp(a + b * data4$x)
#尤度
Lik <- dpois(data4$y, lambda = lambda)
logLik <- -log(Lik)
prod(Lik)
sum(logLik)
prod.ML <- function(para){
  a <- para[1]
  b <- para[2]
  lambda <- exp(a + b * data4$x)
  Lik <- - prod(dpois(data4$y, lambda = lambda))
  return(Lik)
}
ML <- function(para){
  a <- para[1]
  b <- para[2]
  lambda <- exp(a + b * data4$x)
  logLik <- - sum(log(dpois(data4$y, lambda = lambda)))
  return(logLik)
}
optim(fn = ML, par = c(1, 0.2))

prod.ML(para)

model.poisson <- glm(y ~ x, data = data4, family = "poisson")
summary(model.poisson)
coef(model.poisson)
optim(fn = ML, par = c(1, 0.2))$par
optim(fn = prod.ML, par = c(1, 0.2))$par

logLik(model.poisson)
optim(fn = ML, par = c(1, 0.2))$value

new <- data.frame(x = seq(0, 10, by = 0.1))
head(new)
names(new)
colnames(new)
pred <- predict(model.poisson, new, type = "response")

plot(data4$y ~ data4$x)
lines(pred ~ new$x, lwd = 2)

predict(model.poisson, type = "response")
predict(model.poisson, type = "link")
predict(model.poisson)
predict(model.poisson, type = "term")
model.poisson$coef


data4$x[1]
predict(model.poisson, type = "response")[1]
predict(model.poisson, type = "link")[1]
predict(model.poisson, type = "term")[1]


predict(model.poisson, type = "response")[1]
exp(predict(model.poisson, type = "link")[1])

predict(model.poisson, type = "link")[1]
predict(model.poisson, type = "term")[1] + mean(model.poisson$coef[1] + model.poisson$coef[2] * data4$x)

#予想の信頼区間
p.lower <- qpois(0.025, pred)
p.upper <-  qpois(0.975, pred)
  
plot(data4$y ~ data4$x, xlim = c(0, 10), ylim = c(-1, 55),
     xlab = "x", ylab = "y", main = "predict", cex.main = 1)
lines(pred ~ new$x, lwd = 1)
lines(p.lower ~ new$x, lwd = 1, col = 4)
lines(p.upper ~ new$x, lwd = 1, col = 2)
abline(h = 0)


#r, p, q, d
x <- seq(-2.5, 2.5, by = 0.1)
plot(dnorm(x) ~ x, type = "l")
abline(v = qnorm(0.975))
abline(v = qnorm(0.025))

plot(pnorm(x) ~ x, type = "l")
pnorm(qnorm(0.975))


?pnorm


# Advanced Poisson --------------------------------------------------------
# SSTの影響を排除したCPUEを予測する

rm(list = ls())

data5 <- read.csv("data5_CPUE.csv")
head(data5)
summary(data5)
pairs(data5)

CPUE <- data5$Catch / data5$Effort
CPUE
summary(CPUE)
data5 <- cbind(data5, CPUE)
head(data5)

par(mfrow = c(2, 2))
plot(data5$Catch ~ data5$SST, main = "Catch~SST")
plot(data5$CPUE ~ data5$SST, main = "CPUE~SST")
plot(log(data5$CPUE) ~ data5$SST, main = "log(CPUE)~SST")
boxplot(data5$CPUE ~ data5$Year, main = "CPUE ~ Year")
par(mfrow = c(1, 1))

Mean.CPUE <- tapply(data5$CPUE, data5$Year, mean)
Mean.CPUE <- as.numeric(tapply(data5$CPUE, data5$Year, mean))
Y <- 2001:2010
plot(Mean.CPUE ~ Y, type = "l", xlim = c(2001, 2010), lwd = 1)

head(data5)
model.CPUE <- glm(
  Catch ~ as.factor(Year) + offset(log(Effort)) + SST
  , family = "poisson", data = data5)
summary(model.CPUE)
library(car)
Anova(model.CPUE)

par(mfrow = c(2, 2))
plot(model.CPUE, which = 1:4)


head(data5)


#オフセット項を「１」とすることでCPUEを予測することができる
#SSTは全平均値で標準化
new.CPUE <- data.frame(Year = 2001:2010, Effort = rep(1, 10),
                       SST = mean(data5$SST))
head(new.CPUE)

plot(data5)

s.CPUE <- predict(model.CPUE, new.CPUE, type = "response")
Mean.CPUE <- as.numeric(tapply(data5$CPUE, data5$Year, mean))

Y <- 2001:2010

plot(Mean.CPUE ~ Y, type = "l", lwd = 2,
     xlim = c(2001, 2010), ylim = c(0, 2.5), main = "CPUE")
lines(s.CPUE ~ Y, col = 2, lwd = 2)
legend("topleft", lwd = 2, col = c(1, 2),
       legend = c("average CPUE per yera", "standardized CPUE"))



#SSTの項を完全に無視

model.CPUE$coef
model.CPUE$coef[1]
exp(model.CPUE$coef[1])

s.CPUE.2 <- numeric()
#2001
s.CPUE.2[1] <- exp(model.CPUE$coef[1])
#2002 - 2010
for (i in 1:9){
  s.CPUE.2[i + 1] <- exp(model.CPUE$coef[1] + model.CPUE$coef[i + 1])
}

s.CPUE.2  

par(mfrow = c(1, 2))
plot(s.CPUE ~ Y, type = "l")
plot(s.CPUE.2 ~ Y, type = "l")
par(mfrow = c(1, 1))




# SAS Format --------------------------------------------------------------

options("contrasts" = c("contr.SAS", "contr.SAS"))
model.CPUE.SAS <- glm(
  Catch ~ as.factor(Year) + offset(log(Effort)) + SST,
  family = 'poisson', data = data5)
summary(model.CPUE.SAS)
summary(model.CPUE.SAS)$coef
summary(model.CPUE)$coef

#2001
model.CPUE$coef[1]
model.CPUE.SAS$coef[1] + model.CPUE.SAS$coef[2]

#2002
model.CPUE$coef[1] + model.CPUE$coef[2]
model.CPUE.SAS$coef[1] + model.CPUE.SAS$coef[3]

#2010
#SASは最終年の水準が切片になる
model.CPUE$coef[1] + model.CPUE$coef[10]
model.CPUE.SAS$coef[1]


predict(model.CPUE, new.CPUE, type = "response")
#2001
exp(model.CPUE$coef[1] + model.CPUE$coef[11] * mean(data5$SST))
#2002
exp(model.CPUE$coef[1] + model.CPUE$coef[2] + model.CPUE$coef[11] * mean(data5$SST))

s.CPUE / s.CPUE.2
exp(model.CPUE$coef[11] * mean(data5$SST))

model.CPUE$coef
model.CPUE.SAS$coef

s.CPUE.2.SAS <- numeric()
for (i in 1:9){
  s.CPUE.2.SAS[i] <- exp(model.CPUE.SAS$coef[i + 1])
}
s.CPUE.2.SAS[10] <- exp(0)

#実績の年別平均
Mean.CPUE
#年別の予測値（SSTは全期間平均を想定）
s.CPUE
#SST分を除く年別予測値
s.CPUE.2
#SAS表示のSST分を除く年別予測値
s.CPUE.2.SAS

par(mfrow = c(1, 2))
plot(s.CPUE ~ Y, type = "l")
plot(s.CPUE.2 ~ Y, type = "l")
plot(s.CPUE.2.SAS ~ Y, type = "l")

s.CPUE / s.CPUE.2
s.CPUE / s.CPUE.2.SAS

exp(model.CPUE$coef[11] * mean(data5$SST))
#2010のSST分を除く年別予測値の差
exp(model.CPUE.SAS$coef[11] * mean(data5$SST) + model.CPUE.SAS$coef[1])



# logistic ----------------------------------------------------------------

rm(list = ls())

Titanic2 <- data.frame(Titanic)
head(Titanic2)
?Titanic

summary(Titanic2)
pairs(Titanic2)
plot(Titanic2$Freq ~ Titanic2$Class)

Titanic.Y <- Titanic2[Titanic2[, "Survived"] == "Yes", ]
plot(Titanic.Y$Freq ~ Titanic.Y$Class)
plot(Titanic.Y$Freq ~ Titanic.Y$Sex)
plot(Titanic.Y$Freq ~ Titanic.Y$Age)

data.Titanic <- data.frame(
  cbind(Titanic2[1:16, -4], Survive = Titanic2[17:32, 5])
)
names(data.Titanic)[4] <- "Death"
head(data.Titanic)

model.binom_1 <- glm(
  cbind(Survive, Death) ~ .,
  data = data.Titanic,
  family = "binomial",
  na.action = "na.fail"
)

exp(coef(model.binom_1))[-1]
par(mfrow = c(2, 2))
plot(model.binom_1, which = 1:4)
par(mfrow = c(1, 1))

#glmの場合Residualsにはdevianceが用いられている
predict(model.binom_1, type = "link")
resid(model.binom_1, type = "deviance")

#lmの場合
x <- rnorm(30, 0, 1)
y <- 2 * x + 3 + rnorm(30, 0, 2)
plot(y ~ x, type = "p")
lmodel <- lm(y ~ x)
par(mfrow = c(2, 2))
plot(lmodel, which = 1:4)

#過分散の場合、推定値の精度を過大評価してしまうため調整を行う
#⇒疑似尤度
#分布型を特定しない
summary(model.binom_1)
summary(lmodel)
model.binom_2 <- glm(
  cbind(Survive, Death) ~ .,
  data = data.Titanic,
  family = "quasibinomial",
  na.action = "na.fail"
)
summary(model.binom_2)
coef(model.binom_2)
coef(model.binom_1)
exp(coef(model.binom_2))
library(car)
Anova(model.binom_2, test = "F")

library(MuMIn)
dredge(model.binom_1)
dredge(model.binom_2)

#gamma
rm(list = ls())

cars
plot(cars)
model.Gamma <- glm(dist ~ speed, data = cars, family = "Gamma"(link = log))
summary(model.Gamma)
par(mfrow = c(2, 2))
plot(model.Gamma, which = 1:4)
par(mfrow = c(1, 1))

new <- data.frame(
  speed = seq(min(cars$speed), max(cars$speed), by = 0.1)
)
pred.Gamma.response <- predict(model.Gamma, new, type = "response")
plot(pred.Gamma.response ~ new$speed, type = "l")
plot(cars$dist ~ cars$speed, type = "p")
lines(pred.Gamma.response ~ new$speed)

library("MASS")
#ガンマ分布のパラメータはshapeとscale
#alpha(shape)、スカラー
shape <- gamma.shape(model.Gamma)$alpha
#ガンマ分布の期待値はshape * scale
#beta(scale) = 期待値 / shape
scale <- pred.Gamma.response / shape
#各予測のパーセンタイル値
lower <- qgamma(0.025, shape = shape, scale = scale)
upper <- qgamma(0.975, shape = shape, scale = scale)

par(mfrow = c(1, 2))
plot(cars, ylim = c(-50, 120), main = "gamma", cex.main = 1.2)
lines(new$speed, pred.Gamma.response, lwd = 2)
lines(new$speed, lower, lwd = 2, lty = 2, col = 4)
lines(new$speed, upper, lwd = 2, lty = 2, col = 4)
abline(h = 0)


#対数線形モデル
rm(list = ls())
sample.table <- data.frame(
  type = rep(c("type_A", "type_B"), 2),
  Result = rep(c("Good", "Bad"), each = 2),
  Freq = c(35, 45, 50, 30)
)
#分割表の作成
sample.table2 <- xtabs(Freq ~ ., sample.table)

#カイ二乗検定
#割合に差がないかどうか
chisq.test(sample.table2)
chisq.test(sample.table2, correct = F)
fisher.test(sample.table2)

#ポアソン回帰
glm.loglin <- glm(Freq ~ (.)^2, data = sample.table, family = "poisson")
summary(glm.loglin)
library(car)
#交差項を含むためタイプ３
Anova(glm.loglin, type ="III")

#分割表分析
m.loglin <- loglin(sample.table2, margin = list(c(1), c(2)),
                   param = T, fit = F)

summary(m.loglin)

#対数尤度比
#対数尤度比のカイ二乗検定
m.loglin$lrt
1 - pchisq(m.loglin$lrt, m.loglin$df)

#ピアソン統計量
#カイ二乗検定
m.loglin$pearson
1 - pchisq(m.loglin$pearson, m.loglin$df)
chisq.test(sample.table2, correct = F)


#例
rm(list = ls())

HairEyeColor
#三変数
Hair <- data.frame(HairEyeColor)
head(Hair)
summary(Hair)
pairs(Hair)

#ポアソン回帰
#頻度を被説明変数、他のカテゴリカル変数を説明変数としたモデル
#3変数の交差項までを考慮
model.loglin.full <- glm(Freq ~ (.)^3, data = Hair, family = "poisson",
                         na.action = "na.fail")
summary(model.loglin.full)
library(car)
Anova(model.loglin.full, type = "III")

#分割表分析
#p値が小さいと棄却⇒差がある
#対数線形回帰
fm <- loglin(HairEyeColor, list(c(1, 2), c(1, 3), c(2, 3)))
fm
#対数尤度比のカイ二乗検定
1 - pchisq(fm$lrt, fm$df)

model.loglin.2 <- update(model.loglin.full, ~. - Hair:Eye:Sex)
summary(model.loglin.2)
Anova(model.loglin.2, type =  "III")

model.loglin.3 <- update(model.loglin.2, ~. - Eye:Sex)
Anova(model.loglin.3, type =  "III")
summary(model.loglin.3)

windows(width = 14, height = 7)
par(mfrow = c(2, 2))
plot(model.loglin.3, which = 1:4)
par(mfrow = c(1, 1))

library(MuMIn)
dredge(model.loglin.full, rank = "AIC")
plot(dredge(model.loglin.full, rank = "AIC"))




# 特殊なモデル ------------------------------------------------------------------
rm(list = ls())

install.packages("VGAM")
install.packages("pscl")

library(VGAM)
library(pscl)
library(car)

set.seed(1)
Y <- rpois(lambda = 1, n = 30)

#一致
mean(Y)
exp(glm(Y ~ 1, family = "poisson")$coef)

Y.cut <- subset(Y, Y > 0)
mean(Y.cut)

model.pois <-  glm(Y.cut ~ 1, family = "poisson")
model.pos.pois <- vglm(Y.cut ~ 1, family = "pospoisson")

summary(model.pois)
summary(model.pos.pois)

mean(Y.cut)
mean(Y)

#model.pos.poisの推定値がYの期待値に近い
exp(coef(model.pois))
exp(coef(model.pos.pois))


#要因付きのモデル
set.seed(1)
N <- 200

#正規乱数
x <- rnorm(n = N)
#ポアソン分布の期待値（対数化してある）
log.lambda <- x * 1.3 - 0.5
Y2 <- numeric()
#ポアソンモデルに従う乱数の生成
for(i in 1:N){
  Y2[i] <- rpois(lambda = exp(log.lambda[i]), n = 1)
}
plot(Y2 ~ x)

glm(Y2 ~ x, family = "poisson")

#ポアソン分布はゼロを取りうる
data <- data.frame(Y2 = Y2, x = x)
data.cut <- subset(data, data$Y2 > 0)
#ゼロは半分程度存在する
nrow(data.cut)

par(mfrow = c(1, 2))
plot(data$Y2 ~ data$x, ylim = c(0, 25))
plot(data.cut$Y2 ~ data.cut$x, ylim = c(0, 25))
par(mfrow = c(1, 1))

#通常のポアソン回帰⇒不正確
model.pois_2 <- glm(Y2 ~ x, data = data.cut, family = "poisson",
                    na.action = "na.fail")
summary(model.pois_2)
coef(model.pois_2)

#ゼロ切断モデル⇒正確
model.pos.pois_2 <- vglm(Y2 ~ x, data = data.cut, family = "pospoisson",
                         na.action = "na.fail")
summary(model.pos.pois_2)
coef(model.pos.pois_2)
#尤度比検定はできない
Anova(model.pos.pois_2)
#これならできる
lrtest(model.pos.pois_2)

#予測値と残差の関係
#不明
plot(model.pos.pois_2)
#working residuals
plot(resid(model.pos.pois_2) ~ exp(predict(model.pos.pois_2)))

plot(data.cut$Y2 ~ data.cut$x, ylim = c(0, 25))
new <- data.frame(x = seq(-2, 3, by = 0.1))
#正解
lines(predict(glm(Y2 ~ x, family = "poisson", data = data), new, 
              type = "response") ~ new$x, lwd = 3)
#ゼロ切断モデル
lines(predict(model.pos.pois_2, new, type = "response") ~ new$x,
      lwd = 2, col = 2)
#通常のポアソン
lines(predict(model.pois_2, new, type = "response") ~ new$x,
      lwd = 2, col = 4)

legend("topleft", lwd = c(3, 2, 2), col = c(1, 2, 4),
       legend = c("正解", "ゼロ切断", "通常のポアソン"))

rm(list = ls())

#ゼロ過剰モデル
#Zero Inflated Model
library(pscl)
library(lmtest)

#pscl、最尤推定法パッケージ、zeroinfl
#lmtest、線形回帰モデルの検定
#MASS、負の二項回帰モデル
??lmtest


#PhDの属性別論文数
data("bioChemists", package = "pscl")
head(bioChemists)
summary(bioChemists)
?bioChemists
hist(bioChemists$art)
pairs(bioChemists)

#ポアソン回帰
model_pois <- glm(art ~ ., data = bioChemists, family = "poisson")
#疑似ポアソン回帰
model_qpois <- glm(art ~ ., data = bioChemists, family = "quasipoisson")

#負の二項回帰
#実現回数に対する試行回数の分布 ⇒ 負の二項分布
#ポアソン分布に比べて形状が柔軟
library(MASS)
model_nb <- glm.nb(art ~ ., data = bioChemists)

summary(model_pois)
summary(model_qpois)
summary(model_nb)

zeroinfl(art ~ ., data = bioChemists)

#カウント部分のモデル | ゼロインフレ部分のモデル（この場合、定数項のみ）
model_zip <- zeroinfl(art ~ . | 1, data = bioChemists)
model_zinb <- zeroinfl(art ~. | 1, data = bioChemists, dist = "negbin", na.action = "na.fail")
summary(model_zip)
summary(model_zinb)
AIC(model_zip, model_zinb)

#ゼロインフレーテッドモデル、ゼロ過剰モデル
#ゼロが過剰に多いデータにあてはめ
#誤って観測したゼロと本当の観測値としてのゼロが混ざっている
#誤った観測はベルヌーイ分析に従い発生すると仮定（ゼロインフレーションモデルで表現）
#偽のゼロの対数オッズ比を予測
#今回のケースでは論文を書いているのに提出しなかった確率の対数オッズ比を予測
#正しい観測は設定した分布（ポアソン分布や負の二項分布）に従う（カウントモデルで表現）
#thetaは負の二項分布のパラメータ
summary(model_zinb)
summary(model_nb)
AIC(model_nb, model_zinb)

library(MuMIn)
#ゼロインフレモデルにも使用できる
list.1 <- dredge(model_zinb, rank = "AIC")
list.1
windows(width = 14, height = 7)
plot(list.1)

all.model <- get.models(list.1, subset = TRUE)
best.model <- all.model[1]
best.model


#どちらのモデルにも全ての説明変数を使用
model_zip2 <- zeroinfl(art ~ fem + mar + kid5 + phd + ment |
                         fem + mar + kid5 + phd + ment, data = bioChemists)
model_zinb2 <- zeroinfl(art ~ fem + mar + kid5 + phd + ment |
                         fem + mar + kid5 + phd + ment, data = bioChemists,
                       dist = "negbin", na.action = "na.fail")

AIC(model_zip2, model_zinb2)
summary(model_zinb2)

system.time(list.2 <- dredge(model_zinb2, rank = "AIC"))


plot(list.2)
head(list.2, 10)
all.model.2 <- get.models(list.2, subset = TRUE)
best.model.2 <- all.model.2[1]
summary(best.model.2)
warnings()

#1355
#ハードルモデル、pscl
#ゼロもしくはゼロ以外のモデル
#自然数のカウントモデル
#ともに大きいほど数が多い
model_hurdle <- hurdle(
  art ~ fem + mar + kid5 + phd + ment |
    fem + mar + kid5 + phd + ment,
  data = bioChemists, dist = "negbin")

summary(model_hurdle)
summary(model_zinb2)

# Yes or No
data("bioChemists", package = "pscl")

head(bioChemists)

bioChemists.bin1 <- cbind(subset(bioChemists, art == 0), bin = 0)
bioChemists.bin2 <- cbind(subset(bioChemists, art != 0), bin = 1)
bioChemists.bin <- rbind(bioChemists.bin1, bioChemists.bin2)
head(bioChemists.bin, 5)
head(bioChemists, 5)

model_bin <- glm(
  bin ~ fem + mar + kid5 + phd + ment,
  data = bioChemists.bin,
  family = "binomial")

summary(model_bin)

bioChemists.pos <- subset(bioChemists, art != 0)

library(VGAM)

model.pos <- vglm(
  art ~ fem + mar + kid5 + phd + ment,
  family = "posnegbinomial",
  data = bioChemists.pos)
  
summary(model.pos)

#ゼロインフレモデル
#ゼロインフレモデル＋カウント
#ゼロインフレモデルは偽のゼロである確率を予測する
#カウントモデルは回数を多くする
#よって両モデルの係数の符号は逆であることが多い
summary(model_zinb2)

#ハードルモデル
#ゼロでないかどうかの二項モデル＋ゼロ切断のカウントモデル
summary(model_hurdle)
summary(model_bin)
summary(model.pos)


#混合モデル
data6 <- read.csv("data6.csv")
head(data6)
pairs(data6)

#シンプルなglm
#ポアソン回帰
model.glm.pois <- glm(
  y ~ x1 + x2,
  family = "poisson", 
  data = data6
)
summary(model.glm.pois)
plot(model.glm.pois)

#Type2 Anova
library(car)
Anova(model.glm.pois)

#過分散対応
model.glm.quasi.pois <- glm(
  y ~ x1 + x2,
  family = "quasipoisson",
  data = data6
)
summary(model.glm.quasi.pois)
Anova(model.glm.quasi.pois)

#GLMM
library(lme4)
ID <- 1:nrow(data6)
head(data6)

#各サンプルにランダム（変量）効果を想定
model.glmm <- glmer(y ~ x1 + x2 + (1 | ID),
                    data = data6,
                    family = "poisson")
summary(model.glmm)
Anova(model.glmm)

summary(model.glm.pois)
summary(model.glm.quasi.pois)
summary(model.glmm)



#疑似反復

head(sleepstudy)
pairs(sleepstudy)
summary(sleepstudy)
nrow(sleepstudy)
sleepstudy

#線形回帰
glm.sleep <- glm(Reaction ~ Days, data = sleepstudy)
summary(glm.sleep)
Anova(glm.sleep)

#被験者毎のランダム効果を入れる
glm.sleep_1 <- lmer(Reaction ~ Days + (1|Subject), sleepstudy)

#更に追加して毎日のランダム効果を入れる
glm.sleep_2 <- lmer(Reaction ~ Days + (1|Subject) + (0 + Days|Subject), sleepstudy)
#Subjectのランダム効果が二重に入ってしまう
glm.sleep_3 <- lmer(Reaction ~ Days + (1|Subject) + (Days|Subject), sleepstudy)


summary(glm.sleep_1)
summary(glm.sleep_2)
summary(glm.sleep_3)


Anova(glm.sleep_1)
Anova(glm.sleep_2)
anova(glm.sleep_1, glm.sleep_2)


# 疑似反復と過分散
head(cbpp)
pairs(cbpp)

#ロジスティック回帰
#群れのランダム効果を考慮
glm.bin <- glm(
  cbind(incidence, size - incidence) ~ period,
  family = binomial, data = cbpp)
summary(glm.bin)

glmm.bin_1 <- glmer(
  cbind(incidence, size - incidence) ~ period + (1 | herd),
  family = binomial, data = cbpp)

summary(glmm.bin_1)

#更に過分散も考慮
#過分散にサンプル毎のランダム効果で対応
cbpp$ID <- 1:nrow(cbpp)
glmm.bin_2 <- glmer(
  cbind(incidence, size - incidence) ~ period + (1|herd) + (1|ID),
  family = binomial,
  data = cbpp)
summary(glmm.bin_2)

anova(glmm.bin_1, glmm.bin_2)
anova(glm.bin, glmm.bin_1)
anova(glm.bin, glmm.bin_2)


AIC(glmm.bin_1, glmm.bin_2)
AIC(glmm.bin_1, glm.bin)

