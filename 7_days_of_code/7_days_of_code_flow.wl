(* ::Package:: *)

(* ::Input:: *)
(*SetDirectory@"C:\\Users\\Nathan\ Chapman\\Desktop"*)


(* ::Input:: *)
(*Block[*)
(*{vecfield=((*{#2^2,-#1^2}*){Cos[#2],Sin[#1]}&),stepsize=0.1,min=-2.\[Pi],max=2.\[Pi],pts,ptseq,vecplot},*)
(*pts=Table[*)
(*NestWhileList[#+stepsize*vecfield@@#&,ip,Max@@Abs@#<=max&,1,60],*)
(*{ip,Tuples[Subdivide[min,max,50],2]}*)
(*];*)
(*ptseq=If[Length@#<Max[Length/@pts],ArrayReshape[#,{Max[Length/@pts],2},Last@#],#]&/@pts//Transpose;*)
(*vecplot=StreamPlot[vecfield[x,y],{x,min,max},{y,min,max},PlotRange->{{min,max},{min,max}}];*)
(*Rasterize@Show[{vecplot,Graphics[{PointSize[0.015],Red,Point@#},PlotRange->{{min,max},{min,max}}]}]&/@ptseq//ListAnimate*)
(*](*//Export["vecflow.gif",#]&*)*)
