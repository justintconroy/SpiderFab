include <relativity.scad>;

translated([0,0,117], $class="case")
differed("hole","case")
hulled("case")
{
	box([150,130,infinitesimal], $class="case top")
	align(center)
	hulled("cone", $class="hole")
	{
		translated([0,0,1])
		rod(d=110, h=infinitesimal, $class="hole cone");

		translated([0,0,-60])
		rod(d=34, h=infinitesimal, $class="hole cone")
		align(bottom)
		translated([0,0,1])
		rod(d=34, h=10, $class="hole")
		align(bottom)
		rod(d=32, h=6, $class="hole");
	}

	translated([0,0,-75], $class="case bottom")
	box([110,75,infinitesimal]);
}



/*
color([.2,.2,.2,0.5])
union()
{
	translate([0,0,75])
	union()
	{
		import("gds.stl");

		translated([0,0,-35])
		rod(d=32, h=25, anchor=bottom, $class="gds motor");
	}

	translated([0,0,22], $class="electronics")
	box([70,50,35])
	{
		align(x, $class="electronics port")
		translated([0,-15,-7])
		box(20);

		align(center, $class="motor")
		mirrored(x)
		mirrored(y)
		translated([44,35,-8])
		box([60,10,20]);
	}

	rotate([0,180,0])
	import("body_u_wide.stl");

	translate([0,0,-12])
	import("body_d_wide.stl");
}
/*
*/
