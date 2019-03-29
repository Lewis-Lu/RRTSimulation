RRT (Rapidly-Exploring Random Trees)
=====


Sampling-based algorithms

Rapidly Exploring Random Tree (RRT)

Authors
=======
- **Hong Lu (Lewis)**

Algorithm
=========
- Mandarin
  节点向量 Vertice <-- q_start 

  边向量Edge <-- {}

  FOR time from 1 to k

  1.以p概率（0 < p < 1）将 q_goal作为q_rand，以1 - p概率在地图维度上随机生成q_rand（q_rand 是在map中随机生成的点）;

  2.在Vertice 向量中找到距离q_rand最近的一点q_near ;

  3.朝q_rand方向以距离delta_q生成q_new节点 ;

  IF q_new属于free space

  ​	IF q_new和q_near的边属于free space

  ​		Vertice <-- q_new

  ​		Edge <-- E{q_new, q_near}

  ​		IF q_new == q_goal

  ​			生成path

  ​			RETURN

  ​		END

  ​	END

  END

  END

  RETURN

Requirements
============
- Matlab R2013a or later.

License
============
RRT (Rapidly-Exploring Random Trees) using [the MIT license](LICENSE).
