getwd()

install.packages("dlm")
install.packages("KFAS")

library(dlm)
library(KFAS)
library(ggplot2)
library(ggfortify)

Nile
length(Nile)

KfLocalLevel <- function(y, mu_pre, P_pre, sigma_w, sigma_v){
  #予測
  mu_forecast <- mu_pre
  P_forecast <- P_pre + sigma_w
  y_forecast <- mu_forecast
  F <- P_forecast + sigma_v
  #フィルタリング
  K <- P_forecast / (P_forecast + sigma_v)
  y_resid <- y - y_forecast
  mu_filter <- mu_forecast + K * y_resid
  P_filter <- (1 - K) * P_forecast
  
  result <- data.frame(
    mu_filter = mu_filter,
    P_filter = P_filter,
    y_resid = y_resid,
    F = F,
    K = K
  )
  return(result)
}

N <- length(Nile)

#フィルタ化推定量
mu_filter <- numeric(N)
mu_zero <- 0
mu_filter <- c(mu_zero, mu_filter)

#フィルタ化推定量の誤差分散
P_filter <- numeric(N)
P_zero <- 10000000
P_filter <- c(P_zero, P_filter)

#予測誤差、予測誤差の分散、カルマンゲイン
y_resid <- numeric(N)
F <- numeric(N)
K <- numeric(N)

#パラメタ
#過程誤差の分散、観測誤差の分散
sigma_w <- 1000
sigma_v <- 10000


for(i in 1:N){
  kekka <- KfLocalLevel(
    y = Nile[i], mu_pre = mu_filter[i], P_pre = P_filter[i],
    sigma_w=sigma_w, sigma_v=sigma_v
  )
  #フィルタ化推定量
  mu_filter[i + 1] <- kekka$mu_filter
  #フィルタ化推定量の誤差分散
  P_filter[i + 1] <-  kekka$P_filter
  #予測誤差
  y_resid[i] <- kekka$y_resid
  #予測誤差の分散
  F[i] <- kekka$F
  #カルマンゲイン
  K[i] <- kekka$K
}

autoplot(Nile, xlim=c(1850, 2000), ylim=c(400, 1400), colour="#ff000040")
par(new=T)
autoplot(ts(mu_filter[-1], start=1871), xlim=c(1850, 2000), ylim=c(400, 1400),
         colour="#0000ff40")

data.frame()

ggplot(test_data, aes(date)) +
  geom_line(aes(y = var0, colour = "var0")) +
  geom_line(aes(y = var1, colour = "var1"))


#ggplotの基礎を学んだ方が良い




# ggplot ------------------------------------------------------------------
library(ggplot2)
df <- diamonds
summary(df)
head(df)
?diamonds

#散布図
ggplot(df, aes(x=carat, y=price)) +
  geom_point()

#分類別に色分け
ggplot(df, aes(x=carat, y=price, color=cut)) +
  geom_point()

#箱ひげ図
ggplot(df, aes(x=cut, y=price)) +
  geom_boxplot()

#ヒストグラム
ggplot(df, aes(x=price)) +
  geom_histogram()

ggplot(df, aes(x=price, y=..density..)) +
  geom_histogram() +
  facet_wrap(~cut)

ggplot(df, aes(x=price, y=..density..)) +
  geom_histogram() +
  facet_grid(clarity~cut)

ggplot(df, aes(x=price, y=..density.., fill=cut)) +
  geom_histogram(position="identity", alpha=0.3)

ggplot(df, aes(x=price, y=..density.., fill=cut)) +
  geom_histogram(position="fill", alpha=0.3, color="black")

ggplot(df, aes(x=price, y=..density.., fill=cut)) +
  geom_histogram(position="fill", alpha=0.3, color="black", bindwith=1000)





#グラフの保存
ggsave(filename="test.png", plot=g, width=10, height=8, units="cm", dpi=100)



