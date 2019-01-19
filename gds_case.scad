include <relativity.scad>;

//case();
//translated([0,0,80]) case();
translated([0,0,6]) bottom_case();
//colored("yellow","port")
//colored("green","cpu")
//colored("red", "electronics,motor")
//translated([0,0,10]) electronics();
//stencil();


module case()
{
	differed("hole","case", $class="case")
	{
		// Round Case
		rod(d=150, h=75, $class="case")

		// Rectangular Case
//		hulled("case", $class="case")
//		{
//			box([150,130,infinitesimal], $class="case top");
//
//			translated([0,0,-75], $class="case bottom")
//			box([110,75,infinitesimal]);
//		}

		align(top, $class="hole")
		hulled("cone")
		{
			translated([0,0,1],$class="hole cone")
			rod(d=110, h=infinitesimal)
			align(bottom)
			translated([0,0,-61])
			rod(d=34, h=infinitesimal, $class="hole cone")
			align(bottom)
			translated([0,0,1])
			rod(d=34, h=10, $class="hole")
			align(bottom)
			translated([0,0,1])
			rod(d=32, h=8, $class="hole");
		}

	}
}

module bottom_case()
{
	differed("hole", "bottom-case")
	box([96,56,2], $class="bottom-case")
	{
		// Supports to hold next level
		mirrored(x)
		mirrored(y)
		align(x+y+top,$class="support bottom-case")
		differed("hole", "support")
		box([5,5,40],anchor=x+y+bottom, $class="support")
		align(top, $class="screw hole")
		rod(d=2.75, h=20, anchor=center, $fn=50, $class="screw hole");

		// Tabs to connect to existing body.
		mirrored(y)
		differed("hole", "tab")
		hulled("tab", $class="tab bottom-case")
		mirrored(x, $class="tab")
		align(x+y)
		translated([0,-6,0])
		rod(d=6,h=2,$fn=50)
		rod(d=3.5,h=3, $fn=50, $class="screw hole");

		// Hole in middle
		box([70,40,3], $class="hole")
		box([60,50,3])

		// Screw holes to mount perfboard.
		mirrored(x)
		mirrored(y)
		align(x+y, $class="screw hole")
		translated([1.5,-3.5,0])
		rod(d=2.75, h=3, $fn=50);
	}
}


module electronics()
{
	differed("hole", "perfboard", $class="electronics")
	hide("motor")
	box([70,50,1.6], anchor=bottom, $class="electronics perfboard")
	{
		mirrored(x)
		mirrored(y)
		align(x+y, $class="electronics screw hole")
		translated([-3.5,-3.5,0])
		rod(d=2.75,h=1.7,$fn=50);

		align(x+y+z, $class="electronics servo-plug-clearance")
		translated([-35.5,-12.5,0])
		box([31,10,30]);

		align(top, $class="electronics cpu")
		translated([20,-14,0])
		box([22,18.25,12.5])
		align(top, $class="electronics cpu port")
		translated([15,0,0])
		box([8.5,15,5.5]);

		align(center, $class="motor")
		mirrored(x)
		mirrored(y)
		translated([44,35,4])
		box([60,10,20]);
	}
}


module stencil()
{
	color([.2,.2,.2,0.5])
	union()
	{
//		translate([0,0,75])
//		union()
//		{
//			import("gds.stl");
//
//			translated([0,0,-35])
//			rod(d=32, h=25, anchor=bottom, $class="gds motor");
//		}

		rotate([0,180,0])
		import("body_u_wide.stl");

		translate([0,0,-12])
		import("body_d_wide.stl");
	}
}
