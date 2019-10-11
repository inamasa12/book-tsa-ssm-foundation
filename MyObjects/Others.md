# 予測理論  

## 予測の話  
予測は意思決定に用いて、初めて価値を生む  
予測の精度が高いほど、意思決定は容易となる  
予測の使い方が明らかなほど、その価値は高まる  
予測精度を上げられるかどうかが大事  

## 予測理論とPredictability  
予測ができている ⇒ 予測ができていない状態ではない  
予測ができてない ⇒ 確率分布に対する見通しがない  
予測能力の評価  
1. 相対エントロピー  
情報量を下記で定義（まれな事象ほど価値が高い）  
　  
　<img src="https://latex.codecogs.com/gif.latex?-log\left&space;(&space;p&space;\right&space;)" title="-log\left ( p \right )"/>  
情報量の差の期待値で相対エントロピーを定義 ⇒ 確率分布の違いを表す  
　<img src="https://latex.codecogs.com/gif.latex?\sum&space;p\left&space;(&space;X_{t&plus;1}|o_{t}&space;\right&space;)log\left&space;[&space;\frac{p\left&space;(&space;X_{t&plus;1}|o_{t}&space;\right&space;)}{p\left&space;(&space;X_{t&plus;1}&space;\right&space;)}\right&space;]" title="\sum p\left ( X_{t+1}|o_{t} \right )log\left [ \frac{p\left ( X_{t+1}|o_{t} \right )}{p\left ( X_{t+1} \right )}\right ]" />  
1. 予測情報量  
対象となる分布の情報量の期待値を不確実性（知りたい情報）として定義  
予測を行った時の不確実性の低下幅を予測情報量とする  


  
  
