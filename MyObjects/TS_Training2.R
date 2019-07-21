
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








