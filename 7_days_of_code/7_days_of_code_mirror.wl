(* ::Package:: *)

(*Functions*)
Clear[planePoint]
(*Shoutout Wikipedia*)
(*Gives the point in the infinite plane x\[Equal]0 that is colinear with the given points*)
planePoint[{vpx_,vpy_,vpz_},{ptx_,pty_,ptz_},region_]:=Block[
	{
		linevector={ptx,pty,ptz}-{vpx,vpy,vpz}//Normalize,
		linepoint={vpx,vpy,vpz},
		planepoint={0,0,1},
		normalvector={1,0,0},
		d,
		pp
	},
	d=(planepoint-linepoint).normalvector/linevector.normalvector;
	pp=linepoint+d linevector//Chop;
	If[d>0&&RegionMember[region,pp],pp,"Plane intersection point does not exist"]
]


Clear@onOtherSideQ
(*Tests whether or not the point is on the other side of the plane from the camera*)
onOtherSideQ[vp_,pt_,pp_String]:=pp
onOtherSideQ[vp_,pt_,pp_]:=EuclideanDistance[vp,pt]>EuclideanDistance[vp,pp]
onOtherSideQ[vp_,pt_]:=onOtherSideQ[vp,pt,planePoint[vp,pt,planeRegion]]
onOtherSideQ[vp_]:=onOtherSideQ[vp,#]&


Clear@spherePoint
(*Gives a point on the sphere*)
spherePoint[{\[Theta]_,\[Phi]_}]=CoordinateTransformData["Spherical"->"Cartesian","Mapping"]@{3 Sqrt[3],\[Theta],\[Phi]};


(*QOL Constants for testing*)
Clear[vpdef,testpt,planePlot,planeRegion]
(*Viewpoint Default*)vpdef=spherePoint@{2.25\[Pi]/5,-\[Pi]};
testpt={-1,1,1};
planePlot=ParametricPlot3D[
	{0,y,z},
	{y,-1,1},
	{z,-1,1},
	PlotStyle->Directive[Lighter[Blue,4/5],Opacity[.25]],
	Mesh->None
];
planeRegion=ImplicitRegion[x==0,{{x, -1, 1},{y,-1,1},{z,-1,1}}];


(*Tests*)


Flatten[Table[{x,y,z},{x,{-1,1}},{y,-1,1},{z,-1,1}],2]
Select[%,onOtherSideQ[vpdef]]


(*Maybe due to numerical inprecision, some points do not dissapear when they are not behind the screen*)
With[
	{vp={5Cos[t/4],5Sin[t/4],10Sin[t/3]}(*spherePoint@{\[Theta],\[Phi]}*),pts=Flatten[Table[{x,y,z},{x,{-1,1}},{y,-1,1,0.5},{z,-1,1,0.5}],2]},
	Manipulate[
		Show[
			Graphics3D[
				{
					{PointSize[0.03],Red,Point@Select[pts,onOtherSideQ[vp]]}
				},
				PlotRange->1,
				Axes->False,
				AxesOrigin->{0,0,0},
				Boxed->False
			],
			planePlot,
			SphericalRegion->True,
			ViewVector->vp,
			PlotLabel->\[Phi]
		],
		{t, 0, 8 \[Pi], Animator,DefaultDuration->5}
		(*{{\[Theta],2.25\[Pi]/5},0,\[Pi]},
		{{\[Phi],-2.87456},-\[Pi],\[Pi],Animator}*)
	]
]


spherePoint@{2.25\[Pi]/5,-2.87456}
(*This shouldn't evalute*)planePoint[%,{1,-1,1},planeRegion]
