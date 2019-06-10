# Sampling-based algorithm

Author: Hong Lu

E-mail: luh.lewis@gmail.com

[TOC]

## What is Motion Planning Problem?

*Acknowledgement: This part is completely from MIT16.410 Lecture 15.*

Consider a dynamic control system defined as follows:

$$dx/dt = f(x,u), \space x(0) = x_{init}$$ (1)

where $x$ is the state, $u$ is the control.

Given an obstacle set $X_{obs} \subset  \it{R}^{d}$, and set a goal set $X_{goal} \subset  \it{R}^{d}$, the objective of  motion planning problem is to find a control signal $u$ such that the solution of  (1) satisfied $x(t) \notin X_{obs}$ for all  $t \in \it{R}_{+}$, and $X(t) \in X_{goal}$ for all $t > T$, for some finite $T \geq 0$. Return failure if no $u$ exists.

THIS IS BASIC PROBLEM IN ROBOTICS BUT **VERY** HARD TO PROVE

## Motion Planning in practice

* Algebraic planner : explicit representation of environment.

  complete, but impractical;

* Discretization & graph search (A\*, D\*, etc.)

  sensitive to graph size and do not scale well to high dimensions;

* Potential fields / navigation function 

  hard to compute.

## Sampling-Based algorithms

very successful in practice, based on (batch or incremental) sampling method.

* Incremental sampling methods are particularly attractive:
  * easy to real-time, on-line implementation
  * applicable to very general dynamic system
  * do not require the explicit enumeration of constraints
  * adaptively *multi-resolution* methods

## Rapidly-exploring Random Trees (RRT)

**pros**

* The RRT algorithm is probabilistically complete.

* The probability goes to 1 exponentially fast, if the environment satisfied certain 'good visibility' conditions.
* great at finding feasible trajectory.

**cons**

* No characterization of **quality** or **cost** of the trajectory returned by algorithm.
* No systematic method for impose **temporal / logical constraints**.
* terrible at finding good trajectory.
* RRT algorithm "traps" itself by disallowing new better path to merge.

and....why?

## Rapidly-exploring Random Graph (RRG)

**pseudocode**

$\bold{V} \leftarrow \{q_{start} \} \space \bold{E} \leftarrow \{\}$

**for** i = 1, 2 , ... , N = $IterationTime$

​	$q_{rand} \leftarrow SamplingFreeSpace​$

​	$q_{nearest} \leftarrow FindNearest(G, q_{rand})$

​	$q_{new }\leftarrow  Steer(q_{nearest}, q_{new})​$

​	**if** $E(q_{nearest}, q_{new}) ​$ is in $FreeSpace​$ **then**

​		$\bold{X}_{near} \leftarrow Near(G, q_{new}, MeasurementDist)$

​	**endif**

**endfor**

**Notion : $RRT^{*}$ is a tree version of $RRG$.**

## Appendix

### what does environment-modelling mean? 

*from Wikipedia*

> **Environmental modelling** is the creation and use of [mathematical models](https://en.wikipedia.org/wiki/Mathematical_model) of the environment. Environmental modelling may be used purely for research purposes and improved understanding of environmental systems, or for providing an interdisciplinary analysis that can inform decision making and [policy](https://en.wikipedia.org/wiki/Environmental_policy).[[1\]](https://en.wikipedia.org/wiki/Environmental_modelling#cite_note-1)

From my perspective, the whole point is mathematical models while sampling-based algorithm is not needed but it indeed needs map information.

### what is online/offline algorithm and which RRT belongs to?

online algorithm is one that can process its input piece-by-piece in a serial fashion, in the order that the input is fed to the [algorithm](https://en.wikipedia.org/wiki/Algorithm), without having the entire input available from the start.

offline algorithm is given the whole problem data from the beginning and is required to output an answer which solves the problem at hand.

**classic(simple) RRT algorithm is not online.**

### what is Asymptotic optimality? 渐进最优

**Definition : **An algorithm ALG is asymptotic optimality if,  for any motion planning problem $P = (x_{free}, x_{init}, x_{goal})$ and cost function $c$ that admit a robust optimal solution with a finite value $c^{*}$，that

$\textrm{P} (\{ lim_{i  \rightarrow \infin} Y_{i}^{ALG}\} = c^{*})​$ 

**explanation : **This equation means that the probability of algorithm ALG can merge to the optimal value $c^*​$ after $\infin​$ - times planning.

## Reference





