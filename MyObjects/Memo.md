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
　  
<img src="https://latex.codecogs.com/gif.latex?P_{tk}=\frac{Cov\left(&space;y_{t}-\widehat{y}_{t},y_{t-k}-\widehat{y}_{t-k}&space;\right)}{\sqrt{Var\left(&space;y_{t}-\widehat{y}_{t}&space;\right)Var\left(&space;y_{t-k}-\widehat{y}_{t-k}&space;\right)}}">  
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
  checkresiduals(sarimax_m): 残差の自己相関の検定: インプットはArimaオブジェクト  
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
  dwtest(sarimax_m): インプットはlmオブジェクト  
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
　<img src="https://latex.codecogs.com/gif.latex?y_{t}=\mu_{t}&plus;u_{t}">  
　<img src="https://latex.codecogs.com/gif.latex?u_{t}=\sqrt{h_{t}}\varepsilon_{t}">  
　<img src="https://latex.codecogs.com/gif.latex?h_{t}=\omega&plus;\sum_{k=1}^{m}\alpha_{k}u_{t-k}^{2}">  
1. 一般化ARCHモデル（GARCH）  
過去の条件付き分散を説明変数に加えることで、少ない変数でノイズの時系列変動を考慮する  
　<img src="https://latex.codecogs.com/gif.latex?h_{t}=\omega&plus;\sum_{k=1}^{m}\alpha_{k}u_{t-k}^{2}&plus;\sum_{l=1}^{r}\beta_{l}h_{t-l}">  

* R Tips  
  * パッケージ  
  gridExtra: 図表操作拡張  
  fGarch: GARCHモデル  
  rugarch: GRACH拡張  
  * GARCHモデルに従う時系列データの生成  
  garch_model <- garchSpec(model=list(omega=0.001, alpha=0.4, beta=0.5, mu=0.1), cond.dist="norm"): パラメータの設定  
  garchSim(garch_model, n=1000, extended=T): データ生成  
  * 推定（fGarch）  
  garchFit(formula=~garch(1, 1), data=data_ts, include.mean=T, trace=F)  
  * 推定（rugarch）  
  モデルの同定と推定を別に行う  
  garch_spec <- ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1, 1)),  
  　　　　　　　　　　　　mean.model=list(armaOrder=c(0, 0), include.mean=T),  
  　　　　　　　　　　　　distribution.model="norm")  
  garch_model <- ugarchfit(spec=garch_spec, data=data_ts, solver="hybrid")  
  * GJRモデルの推定  
  gjr_spec <- ugarchspec(variance.model=list(model="sGARCH", garchOrder=c(1, 1)),
                            mean.model=list(armaOrder=c(1, 1)),
                            distribution.model="std")
  gjr_model <- ugarchfit(spec=gjr_spec, data=data_ts, solver="hybrid") 
  * その他  
  infocriteria(gjr_model)["Akaike",]: AIC  
  sigma(gjr_model): 推定ボラティリティ（標準偏差）  
  coef(garch_model): 推定した係数  

# 第四部　状態空間モデルとは何か  

## 第一章 状態空間モデルとは何か  
状態の変化を記述する状態方程式と状態から観測値が得られるプロセスを記述する観測方程式で構成される  

## 第二章 状態空間モデルの学び方  
下記データ表現と、パラメータ推定の2つのプロセスから成る  
状態 = 前時点の状態を用いた予測値 + 予測誤差  
観測値 = 状態 + 過程誤差  
* フィルタリング系（カルマンフィルタ等）  
状態の推定とパラメータの推定を別々に行える  
比較的容易  
正規分布に従い、線形なデータにしか適用できない  
* MCMC法（HMC法等）  
状態の推定とパラメータの推定をを同時に行う  
手間と時間を要する  
非正規分布、非線形のデータにも適用可能  

# 第五部　状態空間モデルカルマンフィルタ  

## 第一章 線形ガウス状態空間モデルとカルマンフィルタ  
1. 状態方程式、観測方程式の定式化  
各状態はそれぞれの一期前の値と誤差項の線形結合で表される  
　<img src="https://latex.codecogs.com/gif.latex?x_{t}=T_{t}x_{t-1}&space;&plus;&space;R_{t}\xi_{t},\;&space;\;&space;\;&space;\;&space;\;&space;\xi_{t}\sim&space;N(0,Q_{t})">  
各観測値は同時点の各状態の線形結合と誤差項で表される  
　<img src="https://latex.codecogs.com/gif.latex?y_{t}=Z_{t}x_{t}&space;&plus;&space;\varepsilon_{t},\;&space;\;&space;\;&space;\;&space;\;&space;\varepsilon_{t}\sim&space;N(0,H_{t})">  
1. フィルタリング  
状態の予測と観測値による補正を繰り返す  
1. 平滑化  
状態の予測値をスムージング  
1. パラメータ推定  
過程誤差と観測誤差の大きさを最尤法で推定  

## 第二章 状態方程式、観測方程式による表現技法  
1. ローカルレベルモデル  
ランダムウォークに観測ノイズが加わった系列と言える  
　<img src="https://latex.codecogs.com/gif.latex?\mu_{t}=\mu_{t-1}&plus;w_{t},&space;\;&space;w_{t}\sim&space;N\left(0,&space;\sigma_{w}^{2}&space;\right)">  
　<img src="https://latex.codecogs.com/gif.latex?y_{t}=\mu_{t}&plus;v_{t},&space;\;&space;v_{t}\sim&space;N\left(0,&space;\sigma_{v}^{2}&space;\right)">  
1. ローカル線形トレンドモデル  
δがトレンドを表す  
　<img src="https://latex.codecogs.com/gif.latex?\delta_{t}=\delta_{t-1}&plus;\zeta_{t},\;&space;\zeta_{t}\sim&space;N(0,&space;\sigma_{\zeta}^{2})">  
　<img src="https://latex.codecogs.com/gif.latex?\mu_{t}=\mu_{t-1}&plus;\delta_{t-1}&plus;w_{t},\;&space;w_{t}\sim&space;N(0,&space;\sigma_{w}^{2})">  
　<img src="https://latex.codecogs.com/gif.latex?y_{t}=\mu_{t-1}&plus;v_{t},\;&space;v_{t}\sim&space;N(0,&space;\sigma_{v}^{2})">  
1. 基本構造時系列モデル  
トレンド、周期的変動、ホワイトノイズで構成される  
　<img src="https://latex.codecogs.com/gif.latex?y_{t}=\mu_{t}&plus;\gamma_{t}&plus;v_{t},\;&space;v_{t}\sim&space;N(0,&space;\sigma_{v}^{2})">  
1. 外生変数と時変係数モデル  
外生変数ψの係数βが変動するケース  
　<img src="https://latex.codecogs.com/gif.latex?\beta_{t}=\beta_{t-1}&plus;\tau_{t},\;&space;\tau_{t}\sim&space;N(0,&space;\sigma_{\tau}^{2})">  
　<img src="https://latex.codecogs.com/gif.latex?\mu_{t}=\mu_{t-1}&plus;w_{t},\;&space;w_{t}\sim&space;N(0,&space;\sigma_{w}^{2})">  
　<img src="https://latex.codecogs.com/gif.latex?y_{t}=\mu_{t}&plus;\beta_{t}\psi_{t}&plus;v_{t},\;&space;v_{t}\sim&space;N(0,&space;\sigma_{v}^{2})">  
 
## 第三章 状態推定、カルマンフィルタ  
1. ローカルモデルのカルマンフィルタ  
t-1時点の状態のフィルタ化推定量が、t時点の状態の予測値となる  
　<img src="https://latex.codecogs.com/gif.latex?\mu_{t}=\mu_{t-1|t-1}">  
　<img src="https://latex.codecogs.com/gif.latex?\hat{y_{t}}=\mu_{t}">  
　<img src="https://latex.codecogs.com/gif.latex?y_{resid,t}=y_{t}-\hat{y_{t}}">  
t-1時点の状態のフィルタ化推定量の誤差分散と過程誤差の分散の合計が、t時点の状態の予測誤差の分散  
　<img src="https://latex.codecogs.com/gif.latex?P_{t}=P_{t-1|t-1}&plus;\sigma_{w}^{2}">  
t時点の状態の予測誤差の分散に観測誤差の分散を加えると、t時点の観測値の予測誤差の分散  
　<img src="https://latex.codecogs.com/gif.latex?F_{t}=P_{t}&plus;\sigma_{v}^{2}">  
カルマンゲインは状態の予測誤差の分散を観測値の予測誤差の分散で割ったもの  
　<img src="https://latex.codecogs.com/gif.latex?K_{t}=\frac{P_{t}}{F_{t}}">  
t時点のフィルタ化推定量  
　<img src="https://latex.codecogs.com/gif.latex?\mu_{t|t}=\mu_{t}&plus;K_{t}\cdot&space;y_{resid,t}">  
t時点のフィルタ化推定量の誤差分散  
　<img src="https://latex.codecogs.com/gif.latex?P_{t|t}=(1-K_{t})P_{t}">  

## 第四章 状態推定、散漫カルマンフィルタ  
カルマンフィルタでは、状態の初期値をゼロ、状態の予測誤差の分散の初期値を10,000,000と適当に設定している  
⇒ 状態の予測誤差の分散の初期値が小さいと、推定した状態が補正されず、初期値に引きずられる  
散漫カルマンフィルタでは、状態の初期値は設定せず、状態の予測誤差の初期値を無限大とする  
この時、1時点目のフィルタ化推定量は観測値と同じになり、フィルタ化推定量の誤差分散は観測誤差の分散と同じになる  
過程誤差に比べて観測誤差が大きいと、状態と観測値が一致する  
過程誤差に比べて観測誤差が小さいと、初期値が修正されない  

## 第五章 状態推定、平滑化  
予測誤差が得られるたびに、過去のフィルタ化推定量、及びフィルタ化推定量の誤差分散を修正していく    
⇒ 前時点のフィルタ化推定量 + 前時点のフィルタ化推定量の誤差分散 / 現時点の観測値の予測誤差の分散 × 現時点の予測残差  
フィルタ化推定量の平滑化  
<img src="https://latex.codecogs.com/gif.latex?r_{t-1}=\frac{y_{resid,t}}{F_{t}}&plus;(1-K_{t})r_{t}">  
<img src="https://latex.codecogs.com/gif.latex?\hat{\mu}_{T-1}=\mu_{T-1|T-1}&plus;\frac{P_{T-1|T-1}}{F_{T}}y_{resid,T}">  
フィルタ化推定量の誤差分散の平滑化  
<img src="https://latex.codecogs.com/gif.latex?s_{t-1}=\frac{1}{F_{t}}&plus;(1-K_{t})^{2}s_{t}">  
<img src="https://latex.codecogs.com/gif.latex?\hat{P}_{t}=P_{t|t}-P_{t|t}^{2}s_{t}">  

## 第六章 パラメタ推定、最尤法  
ローカルモデルの場合、過程誤差の分散、観測誤差の分散が推定すべきパラメータ  
観測値の予測残差が正規分布に従うと仮定し、実際の観測値から最尤法で求める  
散漫カルマンフィルタの場合、初期の過程誤差の分散を無限大としているため、初期のデータを除いた散漫対数尤度を用いる  

## 第七章 実装、Rによる状態空間モデル  
カルマンフィルタの実装  
1. 適当なパラメータ、初期値を設定  
1. モデルに従いデータ期間のフィルタ化推定量、予測残差を算出  
1. 予測残差が正規分布に従うことを前提に、最尤法からパラメータを推定  
1. 新しいパラメータで再度データ期間のフィルタ化推定量を算出  
1. フィルタ化推定量をスムージング  
* R Tips  
  * dlm  
  1. モデル設定（ローカルモデル）: dlmModPoly(order=1, dv=過程誤差, dw=観測誤差)  
  1. パラメータ推定: dlmMLE(データ, parm=c(1, 1), モデル)  
  1. フィルタリング: dlmFilter(データ, パラメータを再設定したモデル)  
  1. スムージング: dlmSmooth(フィルタリング結果)  
  * KFAS  
  1. ローカルモデル: SSModel(H=観測誤差, データ~SSMtrend(degree=1, Q=過程誤差))  
  1. ローカル線形トレンドモデル: SSModel(H=観測誤差, データ~SSMtrend(degree=2, Q=c(レベル、トレンドの過程誤差))  
  1. 時変係数モデル: SSModel(H=観測誤差, データ~SSMtrend(degree=1, Q=過程誤差) + SSMregression(~変数, Q=過程誤差))  
  1. 基本構造時系列モデル: SSModel(H=観測誤差, データ~SSMTrend(degree=2, Q=c(レベル、トレンドの過程誤差)) + SSMseasonal(period=7, sea.type="dummy", Q=過程誤差) + ダミー変数)
  1. パラメータ推定: fitSSM(モデル, inits=c(1, 1))  
  1. フィルタリングとスムージング: KFS(パラメータを再設定したモデル)  
  
# 第六部　状態空間モデルとベイズ推論  

## 第一章 一般化状態空間モデルとベイズ推論  
線形、非ガウシアンを扱う  
ベイズ推論と乱数生成法（HMC法）の組み合わせでパラメータを推定

## 第二章 パラメタと状態の推定: ベイズ推論とHMC法  
1. ベイズ推論に基づき、データが与えられた時のパラメータの確率密度関数を特定  
1. HMC法で確率密度関数に基づく、パラメータの乱数を生成  
1. 乱数からパラメータの値を推定  

## 第三章 実装: Stanの使い方  
* R Tips  
  * パッケージ  
  rstan: R上でStanを使用  
  * stanファイル  
  data部分: 定数及びデータの型を宣言  
  parameters部分: パラメータの型を宣言  
  model部分: 初期値、状態方程式、観測方程式の定式化  
  * 推定  
  stan(stanファイル, data=データとサンプル数のリスト, iter=乱数の個数, warmup=切り捨て個数, chains=シミュレーションの回数, chains=試行回数)  
  ⇒ 各パラメータ毎に乱数シミュレーションが行われる  
  











    
