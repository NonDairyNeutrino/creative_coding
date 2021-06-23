(* ::Package:: *)

SetDirectory@NotebookDirectory[]


Clear[spline]
spline[curve : (BSplineCurve | BezierCurve), form : ("circle" | "complete"), n_ /; 3 <= n <= 5] := curve@Permutations@Which[
	form == "circle", CirclePoints@n,
	form == "complete", GraphData[{"Complete", n}, "VertexCoordinates"]
]
makeFrame[curve : (BSplineCurve | BezierCurve), form : ("circle" | "complete"), n_ /; 3 <= n <= 5] := Graphics[{White, spline[curve, form, n]}, Background -> Black]


Table[
	makeFrame[curve, form, k],
	{form, {"circle", "complete"}},
	{curve, {BSplineCurve, BezierCurve}},
	{k, 3, 5}
]  // Map[Rasterize[GraphicsGrid@#, ImageSize -> 72*{26.66, 15}, RasterSize -> {1920, 1080}, Background -> Black]&] // GraphicsColumn
(*SystemOpen@Export["spline_circle_balanced.png", %]*)


Manipulate[
	Labeled[
		Graphics[
			{BSplineCurve/@Permutations@{pt1,pt2,pt3,pt4}},
			PlotRange-> {{-1,1},{-0.5,1}},
			PlotRangePadding->0.125,
			Axes->True
		],
		pt4,
		Right
	],
	{{pt1,#1},Locator},
	{{pt2,#2},Locator},
	{{pt3,#3},Locator},
	{{pt4,#4},Locator}
]&@@GraphData["TetrahedralGraph","VertexCoordinates"]
