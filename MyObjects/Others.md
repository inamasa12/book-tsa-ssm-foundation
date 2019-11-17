# 統計学基礎  

## 理論から始める確率統計  

### 統計学とは何か  
手持ちのデータの最適な使い方を学ぶ学問  
手持ちのデータを分析して、まだ得られていないデータについて議論する 
データが得られるプロセス（確率分布）を明らかにする  

### 統計学はどのような考え方で問題を解決するか  
前提として「未来は過去と同じである」  
予測は将来のデータを、推測は異なる対象のデータ扱うが、基本の考え方は同じ  
確率分布やその変化のパターンを推定、評価する  

### 記述統計の基礎  
記述統計学は手持ちのデータを集計する方法を学ぶ  
推測統計学は手持ちのデータを分析して、まだ得られていないデータについて議論する方法を学ぶ  
多くのデータを少数の集計値を対象として分析を行う  
数量データとカテゴリカルデータ  
期待値はデータを代表する値  
分散は「データと期待値との距離」の期待値  
不偏分散はサンプルから推定した母集団の分散  
標準誤差は標本平均の標準偏差  

### 確率分布と確率変数の基礎  
確率分布はデータが出てくる確率の一覧  
確率分布に従って発生するデータを確率変数と呼ぶ  
確率分布を推定し、将来のデータを推測する  

### 確率密度関数と正規分布  
確率分布を表現する関数を確率密度関数と呼ぶ（但し、合計は必ず１）  
確率密度を積分すると確率になる  
正規分布は、期待値と分散だけで確率密度関数を特定できる  
データから期待値と分散を推定、確率密度関数を特定し、予測に用いる  
サンプリングした値の平均値（合計）は、データ数が十分な場合、正規分布に従う ⇒ 中心極限定理  

### 推定の基礎  
確率分布を仮定し、パラメタ（母数）を推定する  
推定値が信頼係数[%]を満たす区間を信頼区間と呼ぶ  
標本平均の分散は標準誤差の二乗、不偏分散をサンプル数で割ったものになる（分布は正規分布）  
⇒ 標本平均値の区間推定が可能  
サンプル数が少ない場合はt分布に従う  

### 統計的仮説検定の基礎  
推定した確率分布が間違っていないかを判定  
何かが異なっていることを主張する  
期待値（標本平均）のゼロからの乖離を標準誤差で標準化した指標（t値）はt分布に従う  
t値が十分に大きい場合、期待値はゼロと大きく異なると判断  
t値を超える確率をp値と呼び、指定値（危険率）を下回る場合に、期待値とゼロに有意差があると判断する  
⇒ 滅多に起こらないことが生じている、という解釈  
帰無仮説は「期待値がゼロ」 ⇒ 否定されることが期待される事象を帰無仮説に置く  
検定では仮説が間違っている可能性を確認することができる（正しさは確認できない点に注意）  
t検定は確率分布の期待値の差異を判定する  

### R Tips  
dxxx(q): 確率  
pxxx(q): 累積確率  
qxxx(p): 確率点  
rxxx(n): 乱数  

## データ分析入門  

### カイ二乗検定  
変数間の独立性の検定  
クロス表において、期待度数と実際の度数の差の二乗を期待度数で割ったものを全て合計した数値がカイ二乗値  
カイ二乗分布に従うカイ二乗値が十分に大きい場合に、変数間に関係があると看做す  
⇒ 期待度数との違いが大きい  
Fisherの正確確率検定：  
　カイ二乗検定に比べて厳密な独立性の検定（カイ二乗検定は十分なサンプル数が必要）  
　クロス表において、実際の度数に比べて極端な事象の数を数え上げてp値を正確に測定したもの  

### t検定の考え方  
母集団が正規分布に従っていることを前提  
中心極限定理より、標本平均を母分散で割ったものは正規分布に従うが、不偏分散で割ったものはt分布に従う  
通常のt検定を１群のt検定と呼ぶ  
対応のある２群のt検定は、両者の差について１群のt検定を行う  
２群のt検定は両者の分散が等しいか否かで対応が異なる  
1. 等分散の場合  
　  
　<img src="https://latex.codecogs.com/gif.latex?s^{2}=\frac{s_{X}^{2}&plus;s_{Y}^{2}}{m&plus;n-2}" title="s^{2}=\frac{s_{x}^{2}+s_{y}^{2}}{m+n-2}" />  
　  
　<img src="https://latex.codecogs.com/gif.latex?t&space;=&space;\frac{\bar{X}-\bar{Y}}{s\sqrt{\frac{1}{m}&plus;\frac{1}{n}}}" title="t = \frac{\bar{X}-\bar{Y}}{s\sqrt{\frac{1}{m}+\frac{1}{n}}}" />  
　  
先に等分散性に関するF検定を行っておく必要がある  
　  
　<img src="https://latex.codecogs.com/gif.latex?F&space;=&space;\frac{s_{X}^{2}}{s_{Y}^{2}}" title="F = \frac{s_{X}^{2}}{s_{Y}^{2}}" />  
1. 分散が異なる場合（ウェルチの検定）  
　  
　<img src="https://latex.codecogs.com/gif.latex?t&space;=&space;\frac{\bar{X}-\bar{Y}}{\sqrt{\frac{s_{X}^{2}}{m}&plus;\frac{s_{Y}^{2}}{n}}}" title="t = \frac{\bar{X}-\bar{Y}}{\sqrt{\frac{s_{X}^{2}}{m}+\frac{s_{Y}^{2}}{n}}}" />

### R Tips  
chisq.test(クロス表, correct=F): カイ二乗検定（連続性の補正なし）  
fisher.test(クロス表): Fisherの正確確率検定  
t.test(データ): １群のt検定  
t.test(データＡ, データＢ, paired=T): 対応のある２群のt検定  
var.test(データＡ, データＢ): F検定（分散比の検定）  
t.test(データＡ, データＢ, var.equal=T): ２群のt検定（等分散の場合）  
t.test(データＡ, データＢ, var.equal=F): ２群のt検定（分散が異なる場合）  

## 主成分分析の考え方  

### 主成分分析  
データの変動を説明する軸を引く  
各軸がデータ変動を説明する割合を寄与率と呼ぶ  
軸上の座標を主成分得点と呼ぶ  
元データ行列の固有値が主成分ベクトルに対応する  
元データと固有値のベクトル積が主成分得点になる  

### R Tips  
prcomp(データ, scale=T): 主成分分析  
summary(推定モデル): 寄与率等  
推定モデル$rotation: 主成分  
推定モデル$x: 主成分得点  
　  

# 予測理論  

## 予測の話  
予測は意思決定に用いて、初めて価値を生む  
予測の精度が高いほど、意思決定は容易となる  
予測の使い方が明らかなほど、その価値は高まる  
予測精度を上げられるかどうかが大事  

## 予測理論とPredictability  
予測ができている ⇒ 予測ができていない状態ではない  
予測ができてない ⇒ 確率分布に対する見通しがない  
予測評価指標として、相対エントロピー、予測情報量がある  
全ての予測を対象とした相対エントロピーの平均値と予測情報量の平均値は一致する ⇒ 相互情報量（MI）  
その他、予測を意思決定に使用した場合としない場合に得られた利益の違いを予測評価指標とする方法もある  
1. 相対エントロピー  
予測が持つ情報量を下記で定義（まれな事象ほど価値が高い）  
　  
　<img src="https://latex.codecogs.com/gif.latex?-log\left&space;(&space;p&space;\right&space;)" title="-log\left ( p \right )"/>  
　  
情報量の差の期待値で相対エントロピーを定義 ⇒ 確率分布の違いを表す  
　  
　<img src="https://latex.codecogs.com/gif.latex?\sum&space;p\left&space;(&space;X_{t&plus;1}|o_{t}&space;\right&space;)log\left&space;[&space;\frac{p\left&space;(&space;X_{t&plus;1}|o_{t}&space;\right&space;)}{p\left&space;(&space;X_{t&plus;1}&space;\right&space;)}\right&space;]" title="\sum p\left ( X_{t+1}|o_{t} \right )log\left [ \frac{p\left ( X_{t+1}|o_{t} \right )}{p\left ( X_{t+1} \right )}\right ]" />  
　  
1. 予測情報量  
予測対象となる分布の情報量の期待値を不確実性（知りたい情報）として定義  
　  
　<img src="https://latex.codecogs.com/gif.latex?H\left&space;(&space;X_{t&plus;1}&space;\right&space;)=-\sum&space;P\left&space;(&space;X_{t&plus;1}&space;\right&space;)\times&space;logP\left&space;(&space;X_{t&plus;1}&space;\right&space;)" title="H\left ( X_{t+1} \right )=-\sum P\left ( X_{t+1} \right )\times logP\left ( X_{t+1} \right )" />  
　  
予測を行った時の不確実性の低下幅を予測情報量とする  
　  
　<img src="https://latex.codecogs.com/gif.latex?H\left&space;(&space;X_{t&plus;1}&space;\right&space;)-H\left&space;(&space;X_{t&plus;1}|o_{t}&space;\right&space;)" title="H\left ( X_{t+1} \right )-H\left ( X_{t+1}|o_{t} \right )" />  
　  
等ウェイトの確率分布の不確実性が最も高い  
1. 相互情報量（MI）  
予測した場合と予測しない場合が変わらない時、予測による不確実性の低下がない場合にゼロ  
　  
　<img src="https://latex.codecogs.com/gif.latex?\sum&space;\sum&space;p\left&space;(&space;X_{t&plus;1},o_{t}&space;\right&space;)log\left&space;\lfloor&space;\frac{p\left&space;(&space;X_{t&plus;1}|o_{t}&space;\right&space;)}{p\left&space;(&space;X_{t&plus;1}&space;\right&space;)}&space;\right&space;\rfloor" title="\sum \sum p\left ( X_{t+1},o_{t} \right )log\left \lfloor \frac{p\left ( X_{t+1}|o_{t} \right )}{p\left ( X_{t+1} \right )} \right \rfloor" />  
　  

# 回帰分析系  

## 単回帰分析  
* 信頼区間  
予測した回帰直線の誤差の範囲  
条件付き期待値の標準誤差  
* 予測区間  
予測値の誤差の範囲  
信頼区間に残差（モデルでは説明できない部分）を加えたもの

## モデル選択  
* 検定によるモデル選択  
モデル毎の予測残差の差の大きさを分散分析で検定  
* AICによるモデル選択  
最も良いモデルとの差分を表すAICでモデルを評価  
AICは予測モデルの対数尤度の期待値に-1を乗じたもの（自由度調整あり）  

## R Tips  
predict(モデル, データ, se.fit=T, interval="confidence"): 信頼区間  
predict(モデル, データ, se.fit=T, interval="prediction"): 予測区間  
モデル$se.fit: 条件期待値の標準誤差  
モデル$residual.scale: 残差の標準偏差  
anova(モデル１, モデル２): 分散分析による予測力の差の検定  
AIC(モデル): AICの算出  
dredge(最も複雑なモデル, rank="AIC"): 各モデルをAICでランキング  

# 平滑化スプラインと加法モデル  
## 曲線フィッティング  
曲線によるデータフィッティング  
曲線は基底関数（三次多項式等）の線形結合で表す  
データからの乖離と各区間の接続部分の滑らかさの逆数の合計を最小化するように線形パラメータを決定する  
滑らかさの逆数に乗じる値が平滑化パラメータであり、大きいほど滑らかな曲線となる  
平滑化パラメータはクロスバリデーション等で決定する  
平滑化スプライン: 単変量の曲線フィッティング  
加法モデル: 異なる変量の平滑化スプラインを線形結合したもの  
薄版平滑化スプライン: 複数変量の相互関係を考慮した曲線フィッティング  

## R Tips  
names(summary(モデル)): オブジェクトの名前属性のリストを表示  
install.packages("mgcv"): 平滑化スプラインモジュール  
library(mgcv): 平滑化スプラインモジュール  
gam(被説明変数 ~ s(説明変数), s=平滑化パラメータ): 平滑化スプライン  
gam(被説明変数 ~ s(説明変数A, 説明変数B)): 薄版平滑化スプライン  
gam(被説明変数 ~ s(説明変数A) + s(説明変数B)): 加法モデル  
　  
   
# カオス時系列  


# Rの型  
* basic type  
Vectors、Lists、Language、Expression、Function、Environments、Pairlistの7つがある  
Vectorsが基本  
`typeof()`や`mode()`でタイプを調べることができるが、Vectorsの場合、構成要素のデータ型が返り値になる  
* type  
Vectorsの構成要素のデータ型  
logical、numeric、integer、double、complex、characterの6つがある
numericはintegerとdoubleを合わせたもの  
* オブジェクトのクラス属性  
matrix、array、factor、data.frame等がある  
`class()`で調べることができる  
オブジェクトの構造全てを調べる場合は`str()`  
オブジェクトの属性リストは`attributes()`で取得できる  
