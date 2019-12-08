学習用メモ  

# 第一部　時系列分析の考え方  

## 一章　時系列分析の基礎  
* 用語  
DGP: Data Generation Process、モデル化の対象  

## 二章　時系列データの構造
時系列データ = 自己相関（過去系列で説明できる部分） + 周期的変動（季節性等） + トレンド + 外因性 + ホワイトノイズ  
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
ARモデルは前期までの値に応じて期待値が変化するモデルで、誤差項は正規分布に従うホワイトノイズを仮定している  




* 用語  

