
# 時系列データの扱い
library(xts)
library(forecast)
library(ggplot2)
library(ggfortify)
library(urca)

#tsは月次以外使い難い
ts_s <- ts(cumsum(rnorm(12, mean=0.03, sd=0.05)), start=c(2018, 1), freq=12)

window(ts_s, start=c(2018, 4), end=c(2018,6))
attributes(ts_s)
typeof(ts_s)
mode(ts_s)
class(ts_s)
subset(ts_s, month=3)
ts_s["2018-Mar"]

xts_s <- xts(
  matrix(cumsum(rnorm(31, mean=0.005, sd=0.01))),
  order.by=seq(as.Date("2018-01-01"),length=31,by="day")
  )
xts_s["2018-01-15::2018-01-20"]

plot(ts_s, xlab="yyyymm", ylab="price")
autoplot(xts_s, xlab="yyyymm", ylab="price")

summary(ur.kpss(log(xts_s)))
ndiffs(log(xts_s))


head(Seatbelts)
class(Seatbelts)
## ts
Seatbelts[, "front"]
plot(Seatbelts[, "front"])
autoplot(Seatbelts[, "front"])

ts_s2 <- Seatbelts[, "front"]
autoplot(log(ts_s2))
ggtsdisplay(ts_s2)

diff(ts_s2)
lag(ts_s2, -1)
ts_s2
xts_s
class(ts_s)
frequency(xts_s)
ggtsdisplay(diff(log(ts_s2), lag=frequency(ts_s2)))

ts_log_d <- diff(log(ts_s2), lag=frequency(ts_s2))
acf(ts_log_d)
ggsubseriesplot(ts_s2)





library(xts)
library(forecast)
library(ggplot2)
library(ggfortify)
library(urca)

library(tseries)


head(Seatbelts)

ts_log_s <- Seatbelts[, c("front", "PetrolPrice", "law")]
ts_log_s[, c("front", "PetrolPrice")] <- ts_log_s[, c("front", "PetrolPrice")]
train_s <- window(ts_log_s, end=c(1983, 12))
test_s <- window(ts_log_s, start=c(1984, 1))

sarimax_s <- auto.arima(y=train_s[, "front"],
                       xreg=train_s[, c("PetrolPrice", "law")],
                       ic="aic",
                       max.order=7,
                       stepwise=F,
                       approximation=F,
                       parallel=T,
                       num.cores=4)
sarimax_s
checkresiduals(sarimax_s)
jarque.bera.test(resid(sarimax_s))

sarimax_f <- forecast(
  sarimax_s,
  xreg = test_s[, c("PetrolPrice", "law")],
  h=12,
  level=c(95, 70)
)

rep(1, 12)

-- 1969.1 - 1983.12

meanf(train_s[, "front"])
rwf(train_s[, "front"])

arima.sim(n=20, model=list(order=c(1,0,0), ar=c(0.8)))

