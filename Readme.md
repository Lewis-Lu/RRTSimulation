# Sampling-based Motion Planning Simulation 

Lewis.

This is a simulation using MATLAB plus V-rep



## Classic RRT implementation

1. narrow environment path selection

<img src="RRT/classicRRT/resultPic/narrow2.gif" width="360">

2. maze environment path selection

<img src="RRT/classicRRT/resultPic/classicRRT1.gif" width="360" align="center">

3. classic RRT path finding and foundational smooth (with blue star point as for further curvation):

<div style="text-align:center;">
    <img src="RRT/classicRRT/resultPic/rawSmooth.png" width="360">
</div>

4. classic RRT smooth curve generated (Red Curve).

   As black triangle as convex hull to constraint the curve. 

<div style="text-align:center;">
    <img src="RRT/classicRRT/resultPic/classicCurve.jpg" width="450">
</div>


# License

RRT (Rapidly-Exploring Random Trees) using [the MIT license](LICENSE).
