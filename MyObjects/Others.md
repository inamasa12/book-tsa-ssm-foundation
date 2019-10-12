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

  
  
