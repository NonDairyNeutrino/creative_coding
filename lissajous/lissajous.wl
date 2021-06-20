(* ::Package:: *)

(*Make a single lissajous plot*)
Clear@lissplot
lissplot[f1_,f2_,T_]:=ParametricPlot[
{Cos[f1 t],Sin[f2 t]},
{t,0,T},
PlotRange->1.125,
Axes->False,
Background->Black,
Epilog->{PointSize[.05],Red,Point@{Cos[f1 T],Sin[f2 T]}},
GridLines->{{Cos[\[Omega]1 T]},{Sin[\[Omega]2 T]}},
GridLinesStyle->{{Dashed,White},{Dashed,White}}
]
(*Decide which set of frequencies to use*)
Clear@whichlissplot
whichlissplot[f1_,f2_,T_]:=Which[
f1==0&&f2==0,Graphics[Background->Black],
f2==0,lissplot[f1,f1,T],
f1==0,lissplot[f2,f2,T],
True,lissplot[f1,f2,T]
]
(*Format the table of plots into a graphics grid*)
Clear@makegrid
makegrid[plotarray_]:=Rasterize@GraphicsGrid[
plotarray,
Background->Black,
Spacings->0,
ImagePadding->0,
ImageSize->72*10
]


(* ::Input:: *)
(*(*Test of a single rasterized grid*)*)
(*makegrid@Table[*)
(*whichlissplot[\[Omega]1,\[Omega]2,\[Pi]/4],*)
(*{\[Omega]2,Range[0,5]},*)
(*{\[Omega]1,Range[0,5]}*)
(*]*)


Clear@plts
plts=ParallelMap[
makegrid,
ParallelTable[
whichlissplot[\[Omega]1,\[Omega]2,T],
{T,0.1,2\[Pi],2\[Pi]/150},
{\[Omega]2,Range[0,5]},
{\[Omega]1,Range[0,5]},
Method->"CoarsestGrained"
]
];


(* ::Input:: *)
(*ListAnimate[plts,DefaultDuration->5]*)


(* ::Input:: *)
(*SetDirectory@SystemDialogInput["Directory[]"]*)


(* ::Input:: *)
(*Export["Lissajous_5x5_connected.gif",plts,DefaultDuration->5,ImageSize->72*10,AspectRatio->1]*)
