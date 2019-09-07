# R Tips  

## Regression 1  

* 環境設定  
`getwd()`: ワーキングディレクトリの表示  
`setwd("〇〇〇")`: ワーキングディレクトリの設定

* データの読み込み  
`read.delim("clipboard")`: クリップボードからの読み込み  
`read.csv("〇〇〇")`: csvファイルからの読み込み  

* データの確認  
`class(〇〇〇)`: データ型の確認  
`head(〇〇〇, n = 行数)`: 実データの表示  
`names(〇〇〇)`: 列名  
`colnames(〇〇)`: 列名  
`length(〇〇〇)`: データの長さ  
`summary(〇〇〇)`: 要約統計量  
`pairs(〇〇〇)`: 各データの組み合わせの散布図  
`levels(〇〇〇)`: カテゴリカルデータのラベルを表示  


* データ操作  
`seq(from = 〇, to = 〇, by = 〇)`: 等差数列  
`rep(〇, 〇)`: リピート  
`tapply(計算対象, ラベル, 関数)`: グルーピング関数  
`optim(初期値, 関数)`: 関数を最小化する値を求める  
`simulate(モデル, シミュレーションの回数)`: モデルに従う乱数セット（学習データの個数）を指定の回数だけ生成  
`subset(元データ, 抽出条件)`: データの抽出  
`sample(データ, size = サンプル数)`: ランダムサンプリング  
`as.factor(データ)`: カテゴリカルデータに変換  
`offset(変数)`: 傾きが「１」の変数  


* 描画  
`plot(〇 ~ 〇)`: 散布図（連続×連続）、箱ひげ図（連続×離散）、棒グラフ（離散×離散）  
`plot(モデル)`: 残差プロット等  
`lines(〇 ~ 〇), lines(X, Y)`: 折れ線グラフ  
`axis(side =  〇, 範囲, 軸ラベル)`: 軸  
`abline(a = 切片, b = 傾き)`: 直線（垂線は`v = `、水平線は`h = `で指定）  
`hist(〇)`: ヒストグラム  
`points(〇, 〇)`: 点  

* 数学関数  
`log()`: 対数  
`exp()`: 指数  
`sum()`: 合計  
`prod()`: 累積  
`cumsum()`: 累和  


* 統計関数  
`mean()`: 平均  
`var()`: 分散  
`max()`: 最大値  
`sd()`: 標準偏差  
`t.test()`:  
　`〇 ~ 〇`を入力すると回帰係数のt検定、一変数を入力するとt検定、二変数を入力すると差の検定  
`pt(〇, df = 自由度)`: t分布のパーセンタイル値（累積密度）  
`pf(〇, 自由度, 自由度)`: F分布のパーセンタイル値（累積密度）  
`dnorm(〇, mean = 平均, std = 標準偏差)`: 正規分布の密度  
`df(〇, 自由度, 自由度)`: F分布の密度  
`dpois(〇, lambda = 〇)`: ポアソン分布の密度  
`dpchisq(〇, df = 〇)`: カイ二乗分布の密度  
`qpois(〇, lambda = 〇) `: 指定したパーセンタイル値に相当する値  
`rnorm(mean = 平均, std = 標準偏差, n = 個数)`: 正規乱数の生成  
⇒ p:累積密度、d:密度（density）、q:パーセンタイル値（quantile）、r:乱数値（random）を返す

* 正規線形回帰  
`lm(〇 ~ 〇, data = データ)`: 回帰分析  
　`〇 ～ .`で全変数を説明変数に入れる  
　`〇 ～ (.)^2`で交差項を説明変数に入れる  
`coef(モデル)`: 回帰係数   
`predict(モデル, newdata = データ, level = 信頼区間)`:  
　指定したデータに既存モデルを適用して予測、データを指定しない場合は学習データを用いて予測  
`update(モデル, ~. +(-) 〇〇)`: モデルの修正  
`library(MuMIn)`: 複数モデル検定  
`dredge(モデル, rank = "AIC")`:  
　指定した評価基準でモデル選択（モデルは`na.action =  "na.fail"`で作られている必要がある）  
`get.models(dredgeの出力オブジェクト,  subset = TRUE)`: モデルの出力  

* 一般化線形回帰  
`glm(〇 ~ 〇, data = データ, family = 〇)`: 一般化線形回帰分析  
　対数尤度の最大化によりパラメータを得る  
　ポアソン回帰: `glm(〇 ~ 〇, data = データ, family = "poisson")`  
　オフセット項つきのポアソン回帰： `glm(〇 ~ 〇 + as.factor(〇) + offset(〇), data = データ, family = "poisson")`  
　ロジスティック回帰： `glm(cbind(A, B), data = データ, family = "binomial", na.action = "na.fail")`  
　ロジスティック回帰（過分散対応）: `glm(cbind(A, B), data = データ, family = "quasbinomial", na.action = "na.fail")`  
 
`deviance(モデル)`: deviance、deviance残差の二乗合計  
`resid(モデル, type = "response")`: 予測残差  
　`y - predict(モデル, type = "response")`  
　`y - exp(predict(モデル))`  
`resid(モデル), resid(モデル, type = "deviance")`: deviance残差  
`predict(モデル, type = 〇)`:  
　"response" ⇒ 予測値  
　"link" ⇒ リンク関数の逆関数で変換する前の予測値  
　"term" ⇒ リンク関数の逆関数で変換する前の予測値（全平均からの乖離）  
`anova(モデル, test = "Chisq")`: 尤度比検定  
`logLik(モデル)`: 対数尤度  
`AIC(モデル)`: AIC  

* 分散分析  
`library(car)`: 回帰関連パッケージ、ANOVA Type2が使用可能  
`anova(モデル), anova(モデル, モデル)`: ANOVA  
`Anova(モデル, type = "II")`: Type1以外のANOVA  


* その他  
`LETTERS`: アルファベット  
`ls()`: ワーキングディレクトリのオブジェクトを表示  
`rm(〇〇〇)`: 削除  





