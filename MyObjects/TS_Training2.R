
# Regression --------------------------------------------------------------

# Reset Variables
rm(list=ls())

# Package
install.packages("prais")

library(urca)
#Test
library(lmtest)
library(tseries)
#Prais-Winsten Estimate
library(forecast)
library(prais)
library(ggplot2)
library(ggfortify)
#Graphic
library(gridExtra)

# Constans Variables
n_sample = 400

# White Noise Simuration
set.seed(1)
y_wn <- rnorm(n=n_sample)
x_wn <- rnorm(n=n_sample)
mod_ols_wn <- lm(y_wn ~ x_wn)
summary(mod_ols_wn)

# Random Walk (unit root) Simulation
set.seed(1)
y_rw <- cumsum(rnorm(n=n_sample))
x_rw <- cumsum(rnorm(n=n_sample))
mod_ols_rw <- lm(y_rw ~ x_rw)
summary(mod_ols_rw)

# Data Processing
# white noise
df_wn <- data.frame(x_wn = x_wn, y_wn = y_wn)
p_wn <- ggplot(df_wn, aes(x=x_wn, y=y_wn)) +
  geom_point() +
  geom_smooth(method="lm", colour=1) +
  ggtitle("White-Noise")

# random walk
df_rw <- data.frame(x_rw = x_rw, y_rw=y_rw)
p_rw <- ggplot(df_rw, aes(x=x_rw, y=y_rw)) +
  geom_point() +
  geom_smooth(method="lm", colour=1) +
  ggtitle("Random-Walk")

grid.arrange(p_wn, p_rw, ncol=2)

# AR Process
set.seed(2)
y_ar <- arima.sim(
  n = n_sample,
  model = list(order = c(1, 0, 0), ar = c(0.8))
)
x_ar <-arima.sim(
  n = n_sample,
  model = list(order = c(1, 0, 0), ar = c(0.8))
)
model_ols_ar <- lm(y_ar ~ x_ar)
summary(model_ols_ar)

# DW ratio
resid_ols <- mod_ols_rw$residuals
dw <- sum(diff(resid_ols)^2) / sum((resid_ols)^2)
dw

dwtest(mod_ols_wn)
dwtest(mod_ols_rw)
dwtest(mod_ols_ar)

# Simulation

summary(mod_ols_rw)$coefficients
summary(mod_ols_rw)$coefficients["x_rw", "Pr(>|t|)"]

n_sim <- 200
n_sample <- 400
p_wn <- numeric(n_sim)
p_rw <- numeric(n_sim)

set.seed(1)
for(i in 1:n_sim){
  # white noise
  y_wn <- rnorm(n = n_sample)
  x_wn <- rnorm(n = n_sample)
  mod_wn <- lm(y_wn ~ x_wn)
  p_wn[i] <- summary(mod_wn)$coefficients["x_wn", "Pr(>|t|)"]
  # random walk
  y_rw <- cumsum(rnorm(n = n_sample))
  x_rw <- cumsum(rnorm(n = n_sample))
  mod_rw <- lm(y_rw ~ x_rw)
  p_rw[i] <- summary(mod_rw)$coefficients["x_rw", "Pr(>|t|)"]
}

# white noise
sum(p_wn < 0.05) / n_sim
# random walk
sum(p_rw < 0.05) / n_sim


p_ar <- numeric(n_sim)
set.seed(1)
for(i in 1:n_sim){
  # AR
  y_ar <- arima.sim(
    n = n_sample,
    model = list(order=c(1, 0, 0), ar=c(0.8))
  )
  x_ar <- arima.sim(
    n = n_sample,
    model = list(order=c(1, 0, 0), ar=c(0.8))
  )
  mod_ar <- lm(y_ar ~ x_ar)
  p_ar[i] <- summary(mod_ar)$coefficients["x_ar", "Pr(>|t|)"]
}

# AR
sum(p_ar < 0.05) / n_sim


# Unit Root Inference

summary(ur.df(y_rw, type="none"))
summary(ur.df(x_rw, type="none"))
summary(ur.df(y_ar, type="none"))
summary(ur.df(x_ar, type="none"))
summary(ur.kpss(y_rw))
summary(ur.kpss(x_rw))
summary(ur.kpss(y_ar))
summary(ur.kpss(x_ar))














# Original Analysis -------------------------------------------------------

# ARIMAX(0, 0, 0)と通常の線形回帰は同じか

head(Seatbelts, n=3)
autoplot(Seatbelts[, "front"])
Seatbelts[, "PetrolPrice"]

#lm
OA1_lm <- lm(Seatbelts[, "front"] ~ Seatbelts[, "PetrolPrice"])
dwtest(OA1_lm)
summary(OA1_lm)

#Arima
OA1_arima <- Arima(
  y = Seatbelts[, "front"],
  xreg = Seatbelts[, "PetrolPrice"],
  order = c(0, 0, 0)
)
checkresiduals(OA1_arima)
jarque.bera.test(resid(OA1_arima))
summary(OA1_arima)

# ⇒推定結果は同じ
# ARIMAでやった方が検定は充実




set.seed(0)
y <- rep(0, 100)
y[1] <- 9
for (i in 2:length(y)) {
  y[i] <- 2 - 0.8 * y[i - 1] + rnorm(1, mean = 0, sd = 1) 
}

y <- rep(0, 100)
y[1] <- 9
y[2] <- 9
for (i in 3:length(y)) {
  y[i] <- 2 - 0.8 * y[i - 2] + rnorm(1, mean = 0, sd = 1) 
}

plot(y, type = 'l')
acf(y)
pacf(y)

y
cor(y[1:99], y[2:100])
cor(y[1:98], y[3:100])


# Prais-Winsten -----------------------------------------------------------
# 残差に自己相関が残る場合に用いる


library(xts)
library(forecast)
library(ggplot2)
library(ggfortify)
library(urca)
library(tseries)

set.seed(2)
n_sample <- 400

y_ar <- arima.sim(n=n_sample, model=list(order=c(1,0,0), ar=c(0.8)))
x_ar <- arima.sim(n=n_sample, model=list(order=c(1,0,0), ar=c(0.8)))

mod_ols_ar <- lm(y_ar ~ x_ar)
summary(mod_ols_ar)
resid_ols_ar <- mod_ols_ar$residuals
#切片なし
mod_ols_resid <- lm(resid_ols_ar[-1] ~ resid_ols_ar[-n_sample] - 1)
ro <- as.numeric(mod_ols_resid$coefficients)

y_trans_1 <- sqrt(1-ro^2)*y_ar[1]
x_trans_1 <- sqrt(1-ro^2)*x_ar[1]
psi_trans_1 <-  sqrt(1-ro^2)

y_trans_2 <- y_ar[-1] - ro*y_ar[-n_sample]
x_trans_2 <- x_ar[-1] - ro*x_ar[-n_sample]
psi_trans_2 <- rep(1-ro, n_sample-1)

y_trans_all <- c(y_trans_1, y_trans_2)
x_trans_all <- c(x_trans_1, x_trans_2)
psi_trans_all <- c(psi_trans_1, psi_trans_2)

mod_gls_hand <- lm(y_trans_all ~ psi_trans_all + x_trans_all - 1)
summary(mod_gls_hand)

resid(mod_ols_ar)

d <- data.frame(
  y_ar = y_ar,
  x_ar = x_ar
)
library(prais)
mod_gls_PW <- prais_winsten(y_ar ~ x_ar, data=d, iter=1)
summary(mod_gls_PW)

jarque.bera.test(resid(mod_gls_PW))
checkresiduals(mod_gls_PW)
checkresiduals(mod_gls_hand)

head(x_ar)
class(x_ar)
autoplot(x_ar)
ggtsdisplay(x_ar)

autoplot(ts(cumsum(rnorm(n_sample))))
y_rw <- cumsum(rnorm(n_sample))
x_rw <- rnorm(n_sample))
autoplot(ts(x_rw))
mod_lm_diff <- lm(diff(y_rw) ~ diff(x_rw))               
summary(mod_lm_diff)               


set.seed(10)
rw <- cumsum(rnorm(n_sample))
x_co <- 0.6 * rw + rnorm(n_sample)
y_co <- 0.4 * rw + rnorm(n_sample)
autoplot(ts(y_co))
summary(ur.df(y_co, type="none"))
summary(ur.df(x_co, type="none"))

df <- data.frame(
  y_co = y_co,
  x_co = x_co,
  z = x_co - (0.6/0.4) * y_co
)

ts_df <- ts(df)
autoplot(ts_df, facets=T)

#二変数の共和分
data_mat <- matrix(nrow = n_sample, ncol = 2)
data_mat[, 1] <- y_co
data_mat[, 2] <- x_co
summary(ca.po(data_mat, demean="none"))

y_co_diff <- diff(y_co)
x_co_diff <- diff(x_co)
mod_lm_diff_co <- lm(y_co_diff ~ x_co_diff)
summary(mod_lm_diff_co)


df_diff <- data.frame(
  y_co_diff = y_co_diff,
  x_co_diff = x_co_diff
)
autoplot(ts(df_diff), facets=T)


# var ---------------------------------------------------------------------

install.packages("fpp")
install.packages("vars")

library(urca)
library(fpp)
library(vars)
library(ggplot2)
library(ggfortify)
library(xts)

usconsumption
autoplot(usconsumption, facets=T)
class(usconsumption)
str(usconsumption)
attributes(usconsumption)

summary(usconsumption)
head(window(usconsumption, frequency=1))
head(window(usconsumption, start=c(1970, 1), end=c(1970, 4)))
head(usconsumption)
apply.yearly(as.xts(usconsumption), sum)
index(usconsumption)


attributes(index(us_con) %/% 1)
head(aggregate(usconsumption, nfrequency=1, FUN=sum))
head(usconsumption)

summary(iris)
summary(usconsumption)

install.packages("psych")
library(psych)
describeBy(usconsumption)
autoplot(usconsumption, facets = T)

#共に「単位根である（非定常）」は棄却される
summary(ur.df(usconsumption[, "consumption"], type="drift"))
summary(ur.df(usconsumption[, "income"], type="drift"))

#相互相関
autoplot(
  ccf(
    usconsumption[, "consumption"],
    usconsumption[, "income"],
    plot=F
  )
)


#VAR
select_result <- VARselect(usconsumption, lag.max=10, type="const")
select_result$selection[1]
var_bestorder <- VAR(
  y=usconsumption,
  type="const",
  p=select_result$selection[1]
)
summary(var_bestorder)

predict(var_bestorder, n.ahead=4)
autoplot(predict(var_bestorder, n.ahead=8),
         ts.colour=1,
         predict.colour=1)

causality(var_bestorder, cause="income")
causality(var_bestorder, cause="consumption")

irf_consumption <- irf(var_bestorder,
                       impulse = "consumption",
                       response = c("consumption", "income"),
                       n.ahead=12,
                       boot=T)

plot(irf_consumption)
plot(fevd(var_bestorder, n.ahead=12))


# GARCH -------------------------------------------------------------------
install.packages("fGarch")
install.packages("rugarch")

library(xts)
library(forecast)
library(tseries)
library(ggplot2)
library(ggfortify)
library(gridExtra)
library(fGarch); library(rugarch)

n_sample <- 1000

# GARCH Model
spec1 <- garchSpec(model = list(omega=0.001, alpha=0.4, beta=0.5, mu=0.1),
                   cond.dist="norm")

set.seed(1)
sim_garch <- garchSim(spec1,
                      n=n_sample,
                      extended=T)
class(sim_garch)
attributes(sim_garch)
sim_garch <- ts(sim_garch)
autoplot(sim_garch[, -3], facets=T, ylab="")

# 自己相関の確認
p_acf <- autoplot(acf(sim_garch[, "garch"], plot=F),
                      main="original"
                      )
p_acf_sq <- autoplot(acf(sim_garch[, "garch"]^2, plot=F),
                     main="square"
                     )
grid.arrange(p_acf, p_acf_sq, ncol=1)

# モデルの推定
mod_fGarch <- garchFit(formula=~garch(1, 1),
                       data=sim_garch[, "garch"],
                       include.mean=T,
                       trace=F)
coef(mod_fGarch)
class(sim_garch)


# GARCH Model
spec_rugarch1 <- ugarchspec(
  variance.model=list(model="sGARCH", garchOrder=c(1, 1)),
  mean.model=list(armaOrder=c(0, 0), include.mean=T),
  distribution.model="norm")

# モデルの推定
mod_rugarch <- ugarchfit(
  spec=spec_rugarch1, data = sim_garch[, "garch"], solver="hybrid"
)

coef(mod_rugarch)


# ARMA+GARCH Model データ生成
spec2 <- garchSpec(model = list(omega=0.001, alpha=0.4, beta=0.5, mu=0.1, ar=-0.6, ma=-0.5),
                   cond.dist="norm")
set.seed(0)
sim_arma_garch <- garchSim(spec2,
                      n=n_sample,
                      extended=F)

# ARMA
mod_arma <- Arima(sim_arma_garch, order=c(1,0,1))

checkresiduals(mod_arma)
jarque.bera.test(mod_arma$residuals)

spec_rugarch2 <- ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1, 1)),
                            mean.model=list(armaOrder=c(1, 1), include.mean=T),
                            distribution.model="norm")
mod_arma_garch <- ugarchfit(
  spec=spec_rugarch2, data=sim_arma_garch, solver="hybrid")
)
coef(mod_arma_garch)

resid_arma_garch <- residuals(mod_arma_garch) / sigma(mod_arma_garch)
resid_arma <- mod_arma$residuals / sqrt(mod_arma$sigma2)

d <- data.frame(arma_garch=resid_arma_garch,
                arma=resid_arma)
autoplot(ts(d), facets=T, ylab="", main="normalized residuals")

#GJR
data(spyreal)
head(spyreal)
spec_rugarch3 <- ugarchspec(variance.model=list(model="gjrGARCH", garchOrder=c(1, 1)),
                           mean.model=list(armaOrder=c(1, 1)),
                           distribution.model="std")
  
mod_gjr <- ugarchfit(
  spec=spec_rugarch3, data=spyreal[, 1], solver="hybrid") 

coef(mod_gjr)

spec_rugarch4 <- ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1, 1)),
                            mean.model=list(armaOrder=c(1, 1)),
                            distribution.model="std")

mod_standard_garch <- ugarchfit(
  spec=spec_rugarch4, data=spyreal[, 1], solver="hybrid") 

infocriteria(mod_gjr)["Akaike",]
infocriteria(mod_standard_garch)["Akaike",]

class(spyreal)
autoplot(spyreal, facets=T)

?Arima
