学習用メモ  

# 第一部　時系列分析の考え方  

## 第一章　時系列分析の基礎  
* 用語  
DGP: Data Generation Process、モデル化の対象  

## 第二章　時系列データの構造
時系列データ = 自己相関（過去系列で説明できる部分） + 周期的変動（季節性等） + トレンド + 外因性 + ホワイトノイズ  
* 用語  
ホワイトノイズ: 期待値ゼロ、分散一定、自己相関ゼロの定常過程、分布の形状は問わない

## 第三章　数式による時系列データの表記方法  
* 用語  
iid: independent and identically distributed、独立で同一の分布に従う系列  
偏自己相関: k次の偏自己相関とはk-1時点までの影響が取り除かれた自己相関  
　  
<img src="https://latex.codecogs.com/gif.latex?P_{tk}=\frac{Cov\left(&space;y_{t}-\widehat{y}_{t},y_{t-k}-\widehat{y}_{t-k}&space;\right)}{\sqrt{Var\left(&space;y_{t}-\widehat{y}_{t}&space;\right)Var\left(&space;y_{t-k}-\widehat{y}_{t-k}&space;\right)}}" title="P_{tk}=\frac{Cov\left( y_{t}-\widehat{y}_{t},y_{t-k}-\widehat{y}_{t-k} \right)}{\sqrt{Var\left( y_{t}-\widehat{y}_{t} \right)Var\left( y_{t-k}-\widehat{y}_{t-k} \right)}}" /></a>  
（＊） ハット記号は推定量  
