_"But look, I made you some content  
Daddy made you your favorite, open wide  
Here comes the content  
It's a beautiful day to stay inside"  
\- Bo Burnham_

# Examples

<span style="font-weight:normal"> complete_undulation </span> | <span style="font-weight:normal">  Lissajous curves | <span style="font-weight:normal"> heart_and_shell
:--------------------:|:------------------:|:--------------------:
  [<img src="https://raw.githubusercontent.com/NonDairyNeutrino/creative_coding/trunk/complete_undulation/complete_undulation.gif" width = 400 />](https://github.com/NonDairyNeutrino/creative_coding/blob/trunk/complete_undulation) | [<img src="https://github.com/NonDairyNeutrino/creative_coding/blob/trunk/lissajous/Lissajous_no_lines.gif?raw=true" width = 400 />](https://github.com/NonDairyNeutrino/creative_coding/blob/trunk/lissajous) | [<img src="https://github.com/NonDairyNeutrino/Twitch-Code/blob/trunk/double_pendulum/heart_and_shell.png?raw=true" width = 400 />](https://github.com/NonDairyNeutrino/Twitch-Code/blob/trunk/double_pendulum)
  traced path of the double pendulum | harmonics of revolving arcs | ordered chaos
  [<img src="https://github.com/NonDairyNeutrino/Twitch-Code/blob/trunk/double_pendulum/pen_path_black_bg.png?raw=true" width = 400 />](https://github.com/NonDairyNeutrino/Twitch-Code/blob/trunk/double_pendulum) | [<img src="https://raw.githubusercontent.com/NonDairyNeutrino/creative_coding/trunk/harmonics_of_revolving_arcs/harmonics.gif" width = 400 />](https://github.com/NonDairyNeutrino/creative_coding/blob/trunk/harmonics_of_revolving_arcs) | [<img src="https://github.com/NonDairyNeutrino/creative_coding/blob/trunk/splines/spline_complete_balanced.png?raw=true" width = 400 />](https://github.com/NonDairyNeutrino/creative_coding/tree/trunk/splines)


## *complete_undulation*

This piece represents the 10th complete graph where each vertex is randomly placed and oscillating in a random direction with random frequency.  You could also say it's a collection of pendula swinging in their own planes and we're looking up at them.  But that's not very catchy, so let's name it complete\_undulation.

## *Lissajous curves*

This piece helps show how the Lissajous curves are constructed parametrically from the trigonometric functions with different frequencies.  Or rather, each curve is drawn by attaching a pen via vertical and horizontal rods to gears rotating at different speeds.

## *heart_and_shell* and *traced path*

These are the traced out paths the bottom mass of a double pendulum makes for different initial conditions and system parameters.

## *harmonics of revolving arcs*

With each arc subtending a quarter of circle and revolving at a speed proportional to the distance from the center, we see there are moments of order hidden with the chaos.

## *ordered_chaos*

This one is a little more niche and jargony than the others.  But if you're curious about the underlying math, each shape is the overlay of either Bezier or B-spline curves evaluated over the permuted vertices (because order matters in the evaluation of the curves) of the complete graphs with 3, 4, 5 vertices, respectively.  The top row is BSplines and the bottom is Bezier.  
There's another version in the project folder where each is evaluated on the 3, 4, 5 roots of unity; granted the only difference is with n = 2, the vertices are arranged in a triangle with one in the middle (showing that the graph is planar), versus forming a square.
