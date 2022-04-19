# 问题一
df = pd.read_csv('./data/附件1 弱覆盖栅格数据(筛选).csv')
# 去噪
X = df[df['traffic']>3][['x','y']]
# dbscan 聚类
from numpy import unique
from numpy import where
from sklearn.datasets import make_classification
from sklearn.cluster import DBSCAN
from sklearn.metrics import calinski_harabasz_score,silhouette_score,davies_bouldin_score
from matplotlib import pyplot
import numpy as np
import matplotlib.pyplot as plt
plt.rcParams['font.sans-serif'] = ['STSong']

Scores = []  # 存放轮廓系数
x_range = range(5,100)
for i in x_range:
    model = DBSCAN(eps=20, min_samples=i)
    # 模型拟合与聚类预测
    y_pred = model.fit_predict(X)
    # davies_bouldin_score越小越好
    score = davies_bouldin_score(X, y_pred)
    Scores.append(score)
plt.xlabel('min_samples值',fontsize=20)
plt.ylabel('DBI值',fontsize=20)
plt.plot(x_range, Scores, 'o-')

import time
from sklearn.cluster import DBSCAN
import numpy as np
from numpy import unique
from sklearn.metrics import calinski_harabasz_score,silhouette_score,davies_bouldin_score
import matplotlib.pyplot as plt
import numpy as np
start = time.time()
model = DBSCAN(eps=20, min_samples=89)
# 模型拟合与聚类预测
y_pred = model.fit_predict(X)
end = time.time()
print('运行时间:{}s'.format(end-start))
score = davies_bouldin_score(X, y_pred)
print(score)
# 检索唯一群集
clusters = unique(y_pred)
# 为每个群集的样本创建散点图
for i,cluster in enumerate(clusters):
    # print(cluster)
    # 获取此群集的示例的行索引
    row_ix = np.where(y_pred == cluster)
    # print(row_ix[0])
    x = X.iloc[row_ix[0]]['x']
    y = X.iloc[row_ix[0]]['y']
    # 创建这些样本的散布
    plt.scatter(x,y, 1)
plt.show()