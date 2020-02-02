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


str(iris)

install.packages("formattable")
library(formattable)

formattable(iris[c(1:3, 51:53, 101:103),])

#basic
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point() +
  geom_smooth() +
  theme_bw()

#散布図
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, colour=Species, size=Petal.Width, shape=Species)) +
  geom_point()
  

#ヒストグラム
ggplot(iris, aes(x=Petal.Length, y=..density.., fill=Species)) +
  geom_histogram(position="dodge", bins=15) +
  geom_density(alpha=0.5) +
  geom_vline(xintercept=0, linetype=1, size=1) +
  geom_hline(yintercept=1, linetype=2, size=1)


#時系列
library(tidyverse)
df_line <- data.frame(Temperature=rgamma(365, 1,1)) %>%
  dplyr::mutate(Lower=Temperature-3, 
                Upper=Temperature+3,
                Date=as.POSIXct(seq(as.Date("2016-01-01"), as.Date("2016-12-30"), by="days")))
str(df_line)

ggplot(df_line, aes(x=Date, y=Temperature)) +
  geom_line() +
  geom_ribbon(aes(ymin=Lower, ymax=Upper), alpha=0.2) +
  scale_x_datetime(10)

#棒グラフ
ggplot(iris, aes(x=Species, y=Petal.Length)) +
  stat_summary(fun.y="mean", geom="bar") +
  stat_summary(fun.data=mean_cl_normal, geom="errorbar", alpha=0.6, size=1, width=0.1) +
  scale_y_continuous(expand=c(0, 0), limits=c(0, 8))

install.packages("Hmisc")
library(Hmisc)

#バイオリンプロット
ggplot(iris, aes(x=Species, y=Petal.Width)) +
  geom_violin() +
  coord_flip()

#箱ひげ図
ggplot(iris, aes(x=Species, y=Petal.Width)) +
  geom_boxplot() +
  facet_wrap(~Species, scales="free", ncol=3)

#色
iris_id <- iris %>% dplyr::mutate(id=as.factor(rep(1:6, each=25)))
str(iris_id)

ggplot(iris_id, aes(x=id, y=Sepal.Length, colour=id, fill=id)) +
  geom_boxplot(alpha=0.3) +
  theme_light() +
  scale_colour_brewer(palette="BrBG") +
  scale_fill_brewer(palette="BrBG")
  

ggplot(iris, aes(x=Species, y=Sepal.Length, fill=Species)) +
  geom_boxplot(alpha=0.7) +
  theme_classic() +
  scale_fill_manual(values=Colours2)


Colours=c("#FFD700", "#9F79EE", "#7CCD7C")
Colours2=c("white", "gray80", "black")

install.packages("ggThemeAssist")
install.packages("colourpicker")

#グラフ操作
gg2 <- ggplot(iris, aes(x=Petal.Length, fill=Species)) +
  geom_histogram(alpha=0.5, position="dodge")

gg2 + theme(plot.subtitle = element_text(vjust = 1), 
    plot.caption = element_text(vjust = 1)) +labs(title = "iris") + theme(plot.title = element_text(size = 16, 
    hjust = 0.5, vjust = 0.25))

install.packages("plotly")
library(plotly)
gg_ly <- ggplot(iris_id, aes(x=id, y=Sepal.Length, colour=id, fill=id)) +
  geom_boxplot() +
  theme_light() + 
  facet_wrap(~Species, scales="free")

ggplotly(gg_ly)


#複数グラフ描画
library(ggplot2)
install.packages("Rmisc")
library(Rmisc)

gg_multi1 <- ggplot(iris, aes(x=Petal.Length, fill=Species)) +
  geom_histogram()

gg_multi2 <- ggplot(iris, aes(x=Species, y=Petal.Length, fill=Species)) +
  geom_boxplot()

gg_multi3 <- ggplot(iris, aes(x=Petal.Length, y=Petal.Width)) +
  geom_point()

gg_multi4 <- ggplot(iris, aes(x=Species, y=Petal.Width, fill=Species)) +
  geom_violin()

multiplot(gg_multi1, gg_multi2, gg_multi3, gg_multi4, cols=2)
