学習用メモ  

# 第一部　時系列分析の考え方  

## 一章　時系列分析の基礎  
* 用語  
DGP: Data Generation Process、モデル化の対象  

## 二章　時系列データの構造
時系列データ =  
　自己相関（過去系列で説明できる部分） + 周期的変動（季節性等） + トレンド + 外因性 + ホワイトノイズ  
* 用語  
ホワイトノイズ: 期待値ゼロ、分散一定、自己相関ゼロの定常過程、分布の形状は問わない

## 三章　数式による時系列データの表記方法  
* 用語  
弱定常: 期待値と自己相関が一定  
強定常: 任意の時点、時間差に関する同時分布が常に同一  
iid: independent and identically distributed、独立で同一の分布に従う系列  
偏自己相関: k次の偏自己相関とはk-1時点までの影響が取り除かれた自己相関  
　  
<img src="https://latex.codecogs.com/gif.latex?P_{tk}=\frac{Cov\left(&space;y_{t}-\widehat{y}_{t},y_{t-k}-\widehat{y}_{t-k}&space;\right)}{\sqrt{Var\left(&space;y_{t}-\widehat{y}_{t}&space;\right)Var\left(&space;y_{t-k}-\widehat{y}_{t-k}&space;\right)}}" title="P_{tk}=\frac{Cov\left( y_{t}-\widehat{y}_{t},y_{t-k}-\widehat{y}_{t-k} \right)}{\sqrt{Var\left( y_{t}-\widehat{y}_{t} \right)Var\left( y_{t-k}-\widehat{y}_{t-k} \right)}}" /></a>  
（＊） ハット記号は推定量  

# 第二部　Box-Jenkins法とその周辺  

## 一章 Box-Jenkins法というフレームワーク  
Box-Jenkins法は、時系列データを効率的に分析するための以下のフレームワーク  
1. データを定常過程に変換  
1. ARIMAモデルの同定  
1. 適合性の評価  
1. 予測精度の評価  

## 二章　定常過程とデータの変換  
d階差分をとった系列が定常過程となる原系列がd次和分過程  
特にd=1の場合を単位根過程
差分系列にARMAモデルを用いたものがARIMAモデル  
対数差分系列は変化率と看做すことができる  
特定サイクルの階差を季節階差と呼ぶ  

## 三章　ARIMAモデル  
d次和分過程にARモデルとMAモデルの合成モデルを適用したもの  
AR(1) = MA(∞)  
1. ARモデル  
前期までの実現値に応じて期待値が変化するモデル  
自己相関は次数が上がるにつれて、徐々に低下する  
偏自己相関は次数を超えるラグでゼロになる  
誤差項は正規分布に従うホワイトノイズを仮定
係数が負の場合に振幅が大きくなる  
定常条件がある  
1. MAモデル  
前期までのホワイトノイズに応じて期待値が変化するモデル
自己相関は次数を超えるラグでゼロになる    
偏自己相関は次数が上がるにつれて、徐々に低下する  
誤差項は正規分布に従うホワイトノイズを仮定  
係数が負の場合に振幅が大きくなる  
常に定常  
反転可能条件を満たすMAモデルは統計的に望ましい性質を持つ  

## 四章　ARIMAモデルの拡張  
1. SARIMAモデル  
SARIMA(p,d,q)(P,D,Q)[s]: 周期がsの季節階差がARIMA(P,D,Q)に従い、それを除く部分がARIMA(p,d,q)に従うモデル  
1. ARIMAXモデル  
ARIMAに同時点の外生変数による説明項が加わったモデル  

## 五章　モデルの同定と評価の考え方  
1. 単位根検定（KPSS、ADF、PP等）で差分を取る必要性を確認（季節階差の次数はCanova-Hansen検定で判断）  
1. AIC等を基準に総当たりで同定  
1. 定常性、反転可能性の確認  
1. 残差に自己相関がないことを確認（Ljung-Box検定）  
1. 残差の正規であることを確認（Jarque-Bera検定、Shapiro-Wilk検定等）  
1. テストデータを用いてナイーブな予測（平均値、前期値等）と予測精度を比較  

* 用語  
尤度: 与えられたパラメータで、収集したデータが得られる確率  
AIC: -2 × 最大化対数尤度 + パラメータの数  

## 六章　Rによる時系列データの取り扱い  
* R Tips  
  * 時系列分析パッケージ  
  xts: 時系列データ分析  
  forecast: 予測分析  
  urca: 検定  
  ggplot2: 時系列プロット  
  ggfortify: 時系列プロット  
  * 時系列データの作成、抽出  
  ts_s <- ts(rnorm(12, mean=0.03, sd=0.05), start=c(2018, 1), freq=12)  
  window(ts_s, start=c(2018, 4), end=c(2018,6))  
  subset(ts_s, month=3)  
  xts_s <- xts(matrix(rnorm(31, mean=0.005, sd=0.01)),  
  　　　　　order.by=seq(as.Date("2018-01-01"),length=31,by="day")  
  　　　　　)  
  xts_s["2018-01-15::2018-01-20"]
  * 時系列データのプロット  
  plot(ts_s, xlab="yyyymm", ylab="price"): デフォルトのプロット  
  autoplot(xts_s, xlab="yyyymm", ylab="price", facets=T): 予測モデルのプロットに便利  
  * 単位根検定  
  ur.kpss(log(xts_s)): KPSS検定  
  ndiffs(log(xts_s)): 定常過程とするために必要な差分の回数  

## 七章　RによるARIMAモデル  
非定常過程の対応としては以下がある  
ARFIMA（自己回帰実数和分移動平均モデル）: 差分の階数を実数で指定し過剰差分を回避する  
状態空間モデル  

* R Tips  
  * データ整形  
  diff(ts_s, lag=1): 差分系列の作成  
  * 時系列データのプロット  
  ggtsdisplay(ts_s): プロットと併せ、コレログラムも表示  
  ggsubseriesplot(ts_s2): サイクル毎のプロット  
  * コレログラム  
  acf(ts_s): 自己相関  
  pacf(ts_s): 偏自己相関  
  * ARIMAモデルの推定  
  Arima(y=ts_s_train, order=c(1, 1, 1), seasonal=list(order=c(1, 0, 0)), xreg=ts_s2_train)  
  sarimax_m <- auto.arima(y=ts_s_train, xreg=ts_s2_train, ic="aic", max.order=7  
  　　　　　　　　　　　　, stepwise=F, approximation=F, parallel=T, num.cores=4)  
  ⇒ 定常性と反転可能性のチェックは自動で行われる  
  checkresiduals(sarimax_m): 残差の自己相関の検定  
  jarque.bera.test(resid(sarimax_m)): 残差の正規性の検定  
  * 予測の作成  
  forecast(sarimax_m, xreg=ts_s2_test, h=12, level=c(95, 70)): モデル予測  
  meanf(ts_s_train, h=12): 過去平均値  
  rwf(ts_s_train, h=12): 前期値  
  * 予測の評価  
  accuracy(sarimax_f, ts_s_test)  
  
* 用語  
過剰差分: 差分を取りすぎると必要なデータが損なわれる  

# 第三部　時系列分析のその他のトピック  

## 一章 見せかけの回帰とその対策  
単位根過程やAR過程に従うデータに回帰分析を行うと見せかけの相関が生じる  
残差に自己相関があることが背景にあり、この場合、最小二乗推定量の有効性が失われる等、下記の問題が生じる  
1. 係数の分散を過少推定する  
1. 決定係数が過大になる  
1. 係数のt検定ができない  
残差の自己相関の有無はDurbin-Watson検定で行う
残差に自己相関があった場合  
1. 残った自己相関を表現するために、ARIMAX、VAR、状態空間モデル等を用いる  
1. 単位根がなければ、自己相関を考慮できる一般化最小二乗法（GLS）を用いる ⇒ 一つがFGLS  
1. 単位根の場合、データ間に共和分がなければ差分系列に回帰を用いる  
⇒ 共和分のあるデータに対して差分系列の回帰分析を行うと、その関係が消えることがある  

* 用語  
d次和分過程: d階差分をとると定常になる過程  
共和分: 各々がd次和分過程だが、その線形結合がより低い次数の和分過程になるもの  

* R Tips  
  * 時系列分析パッケージ  
  lmtest: 線形モデルの検定  
  prais: GLS  
  * 時系列データの作成、抽出  
  arima.sim(n=20, model=list(order=c(1,0,0), ar=c(0.8))): ARIMA過程の生成  
  * DW検定
  dwtest(sarimax_m)  
  * 単位根検定  
  ur.df(y_rw, type="none"): ADF検定（帰無仮説は「単位根を持つ」）  
  * Prais-Winsten法によるGLS  
  prais_winsten(y_ar ~ x_ar, data=d, iter=1)
  * 共和分検定  
  ca.po(data_mat, demean="none")  
  
## 第二章 VARモデル  
VARモデルでは、残差の自己相関が無いことが想定されているが、異なる変数の残差間の相関は許容されている  
Granger因果性検定は、変数を加えることで予測残差が有意に減少するかどうかを検定する  
Granger因果性検定の瞬時因果性では同時点の関連を検定している  
インパルス応答関数は、通常直行化インパルス応答関数を指す  

* R Tips  
  * 時系列分析パッケージ  
  fpp: 時系列予測  
  vars: VARモデル  
  * VAR関連  
  ccf(x, y): 相互相関（各ラグの相関）  
  VARselect(data_mat, lag.max=10, type="const"): VARのラグ選択  
  var_model <- VAR(y=data_mat, type="const", p=2): VARの推定  
  predict(var_model, n.ahead=4): 推定モデルによる予測  
  causality(var_model, cause="A"): Granger因果性検定  
  irf(var_model, impulse="A", response=c("A", "B"), n.ahead=12): インパルス応答関数  
  fevd(var_model, n.ahead=12): 各変数の分散分解（各変数の変動寄与度を算出）
  
## 第三章 ARCH・GARCHモデルとその周辺  
時間によって分散が変動するデータを表現するモデル  
1. 自己回帰条件付き分散不均一モデル（ARCH）  
<img src="https://latex.codecogs.com/gif.latex?y_{t}=\mu_{t}&plus;u_{t}" title="y_{t}=\mu_{t}+u_{t}" /> 
<img src="https://latex.codecogs.com/gif.latex?u_{t}=\sqrt{h_{t}}\varepsilon_{t}" title="u_{t}=\sqrt{h_{t}}\varepsilon_{t}" />  
<img src="https://latex.codecogs.com/gif.latex?y_{t}=\mu_{t}&plus;u_{t}" title="y_{t}=\mu_{t}+u_{t}" /> 



    
