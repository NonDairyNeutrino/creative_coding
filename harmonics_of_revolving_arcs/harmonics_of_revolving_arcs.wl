(* ::Package:: *)

(*To see "nodes", set the density low.  To travel through a vortex, set the density high.*)
ParallelEvaluate@SetOptions[Graphics, Background -> Black, PlotRangePadding -> 0.5];
Clear[arc, vortex, color, makeFrame, makeAnimationFrames]
(*make a single arc*) arc[t_][r_] := Circle[{0, 0}, r, {t*r, Pi/2 + t*r}]
(*make all the arcs*) vortex[arcNumber_, t_] := arc[t] /@ Range[1, 10, 10/arcNumber]
(*choose the color*)  color[colorFrequency_, t_] := Hue[colorFrequency*t]
(*make a single frame of time*)
makeFrame[arcNumber_, colorFrequency_][t_] := Rasterize[
	Graphics[
		Join[
			{Thickness[0.007], color[colorFrequency, t]},
			vortex[arcNumber, t]
		],
		PlotRange -> 10
	],
	ImageSize->72*6.6
]
(*make all the frames needed to animate*)
(*Suggested phase space is 1 \[LessEqual] arcNumber \[LessEqual] 10, 1 \[LessEqual] arcDensity \[LessEqual] 10, 0 \[LessEqual] colorFrequency \[LessEqual] 1*)
makeAnimationFrames[arcNumber_ : 10, colorFrequency_ : 1/(2 \[Pi]), frameNumber_ : 150] := Block[
	{k},
	SetSharedVariable@k; k = 0;
	Monitor[
		ParallelMap[
			(k++; makeFrame[arcNumber, colorFrequency]@#)&,
			Range[0, (*Factor of 10 to have the slowest arc make a full revolution*)2*Pi, 2*Pi/frameNumber],
			Method -> "CoarsestGrained"
		],
		Labeled[ProgressIndicator[k, {0, frameNumber + 1}], k(*timer to show how long each step is taking*)(*stopwatch[]*), Right]
	]
]

stopwatch[]:= Dynamic@Clock[{0,Infinity,1}]

(*makeAnimationFrames[10, 1/(2 \[Pi]), 10];*)

(*Clear@frames
ListAnimate[frames = makeAnimationFrames[], DefaultDuration \[Rule] 5]*)


(*SetDirectory@NotebookDirectory[]
Export["harmonics.gif", makeAnimationFrames[], DefaultDuration -> 5]*)
