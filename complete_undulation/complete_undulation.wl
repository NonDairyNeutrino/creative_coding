(* ::Package:: *)

(*Initial declarations*)
Clear[pts,angs,freqs]
(*Initial points*)pts=RandomReal[{0,1},{10,2}];
(*Motion angles*)angs=RandomReal[{0,2\[Pi]},10];
(*Osciallation frequencies*)freqs=RandomReal[{-1,1},10];
(*Minimum time required for every point to make at least one full oscillation*)period=2\[Pi]/freqs//Max;


(*Functions*)
Clear[movingpoints,pointpairs,makeframe]
(*Coordinates of the oscillating point at time t*)movingpoints[t_]=pts+0.15Sin[freqs t]Transpose[{Cos[#],Sin[#]}&@angs];
(*pairs of points*)pointpairs[t_]=Subsets[movingpoints[t],{2}];
(*make a single frame*)makeframe[t_]:=Graphics[
{
{PointSize[.03],Point@movingpoints[t]},
{Thickness[0.005],Line@pointpairs[t]}
(*{PointSize[0.03],Red,Point@Mean@movingpoints[t]}*)(*,
(*{Thickness[0.005],Circle[Mean@movingpoints[t],EuclideanDistance[Mean@movingpoints[t],Nearest[movingpoints[t],Mean@movingpoints[t],All]\[LeftDoubleBracket]-1\[RightDoubleBracket]]]}*)*)
},
PlotRange->minimalboundingbox,
PlotRangePadding->0.15
]
(*make a frame from pre-generated points*)
makeframe[graph:{vertices_,edges_}]:=Graphics[
{
{PointSize[.03],Point@vertices},
{Thickness[0.005],Line@edges}
(*{PointSize[0.03],Red,Point@Mean@movingpoints[t]}*)(*,
(*{Thickness[0.005],Circle[Mean@movingpoints[t],EuclideanDistance[Mean@movingpoints[t],Nearest[movingpoints[t],Mean@movingpoints[t],All]\[LeftDoubleBracket]-1\[RightDoubleBracket]]]}*)*)
},
PlotRange->minimalboundingbox,
PlotRangePadding->0.15
]


(*Preprocessing*)
Clear[points,pairs,minimalboundingbox]
points=movingpoints/@Range[0,period,period/200];
pairs=Subsets[#,{2}]&/@points;
(*minimalboundingbox works, but I'm just not sure how to comment it...*)
minimalboundingbox=MinMax/@(*{{minx, maxx},{miny, maxy}}*)Transpose[#,{1,3,2}]&@Map[{#1,#5}&@@FunctionRange[{#,0<=t<=10\[Pi]},t,val]&,Transpose@movingpoints[t],{2}];


(*Make the frames*)
Clear@frames
(*Monitoring parallelization preperation*)Clear@k;SetSharedVariable@k;k=0;
Monitor[
frames=ParallelMap[
(k++;Rasterize[makeframe@#,ImageSize->72*7.5])&,
Transpose@{points,pairs},
Method->"CoarsestGrained"
];,
ProgressIndicator[k,{0,Length@Transpose@{points,pairs}}]
]


(*View the animation before exporting*)
ListAnimate[
frames(*\[LeftDoubleBracket];;10\[RightDoubleBracket]*),
DefaultDuration->5
]


SetDirectory@SystemDialogInput["Directory"]


Export["K_10_animation.gif",frames,DefaultDuration->10]
SystemOpen@%


Capitalize@Alphabet[][[;;Length@pts]];
UndirectedEdge@@@Subsets[%,{2}]//Graph
CompleteGraph[Length@pts]
(*Look our mass is actually the complete graph*)IsomorphicGraphQ[%%,%]
