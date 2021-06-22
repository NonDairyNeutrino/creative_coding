(* ::Package:: *)

Array[
	Graphics[
		BSplineCurve /@ Permutations@CirclePoints@#
	] &,
	3,
	3
] // GraphicsRow


SetDirectory@NotebookDirectory[]


Table[
	{White, f@#}& /@ Permutations@CirclePoints@k // Graphics,
	{f, {BSplineCurve, BezierCurve}},
	{k, 3, 5}
] // GraphicsGrid // Rasterize[#, ImageSize -> 72*{26.66, 15}, RasterSize -> {1920, 1080}, Background -> Black]&
SystemOpen@Export["bspline_bezier_circle.png", %]


Manipulate[
Labeled[
Graphics[
{BSplineCurve/@Permutations@{pt1,pt2,pt3,pt4}},
PlotRange->1,
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
