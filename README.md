# 【2022 年第十二届 MathorCup杯数学建模】D 题 移动通信网络站址规划和区域聚类问题 

# 1 题目

知乎博客介绍[https://zhuanlan.zhihu.com/p/500686930](https://zhuanlan.zhihu.com/p/500686930)

# 2 论文方案和图

针对问题一： 将该问题建立最优化数学模型，以最大化业务量覆盖率和最小化成本的比值为目标函数，包含三个约束条件，分别是新建基站与现有基站之间的距离大于最小门限、业务量覆盖率大于90%、基站坐标在一个长和宽都为2500的矩形范围中。再采用基本的粒子群优化算法、带有权重的粒子群优化算法和带有扰动惯性权重的粒子群优化算法进行对比分析。由实验得，带有扰动惯性权重 的粒子群算法效果最佳，业务量覆盖率达94.6%，此时建设宏基455个，微基站1902个，所需成本6452。

针对问题二： 在第一问求解得到的基站坐标位置上，将基站覆盖的范围和扇区方向考虑到建模中。提出一种基于迭代的方位角估计算法，首先初始化每个基站三个方位角，保证扇区之间的夹角为大于或等于45度时，以步长为10度进行迭代。以最大业务量覆盖率为目标，通过多次迭代，输出业务覆盖率最大的扇区方位角组合。如果存在相同业务量覆盖率的结果，以覆盖点较多的作为最终的输出结果，最终最大业务量覆盖率达到88.7%。

针对问题三： 根据题目要求，需将弱覆盖点按照坐标距离进行聚类，因此采用基于一组邻域来描述样本集的紧密程度的DBSCAN聚类方法。设置计算两个样本点之间的距离阈值为20，利用该算法可以描述邻域的样本分布紧密程度的特点，实现了簇的传递性。为了克服DBSCAN算法时间开销大的缺点，采用了一种基于网格单元的改进DBSCAN算法，优化了最耗时的区域查询过程，通过将数据空间划分为网格单元，减少了大量不必要的查询操作，大大减少了点对点距离的计算，模型最终时间复杂度由$O(n^2)$减小为$O ( n + mk^2 )$ 。



![](https://img-blog.csdnimg.cn/9d63abb815294129b8db88d049d72bec.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQmV0dGVyIEJlbmNo,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

![](https://img-blog.csdnimg.cn/0cd6f1716e1d4dec99385826368b6831.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQmV0dGVyIEJlbmNo,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

![](https://img-blog.csdnimg.cn/c0f099c634ae42df959ab2081a11ae5d.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBAQmV0dGVyIEJlbmNo,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

