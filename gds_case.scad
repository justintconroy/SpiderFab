include <relativity.scad>;
use <ruler.scad>;

//translate([0,1,70]) rotate([-90,-90,0]) ruler(40);
//translated([0,0,71])
gds_holder();
//translated([0,0,52])
//top_case();
//colored("red", "support")
//show("support")
//translated([0,0,6]) bottom_case();
//colored("yellow","port")
//colored("green","cpu")
//colored("red", "electronics,motor")
//show("motor,cpu,servo-plug-clearance")
//translated([0,0,17.5]) electronics();
//stencil();

//gds_motor();

module gds_holder()
{
	align(bottom)
	differed("hole", "gds-bottom")
	rod(d=38, h=3, anchor=bottom, $class="gds-bottom")
	{
		rod(d=3, h=3.5, anchor=center, $fn=50, $class="hole");

		// Motor mount screw clearance.
		translated([8,0,0])
		rod(d=6,h=1.5, anchor=top-x, $fn=50, $class="hole");
		translated([-8,0,0])
		rod(d=6,h=1.5, anchor=top+x, $fn=50, $class="hole");

		// GDS Mount screw holes.
		align(top);
		translated([0,9.5,0])
		rod(d=3.75,h=3.5, anchor=center-y, $fn=50, $class="hole");
		align(top);
		translated([0,-9.5,0])
		rod(d=3.75,h=3.5, anchor=center+y, $fn=50, $class="hole");

		align(top)
		differed("cone-hole", "cone")
		{
			hulled("cone", $class="cone")
			{
				rod(d=38, h=infinitesimal, $class="cone");
				align(top)
				translate([0,0,50])
				rod(d=114, h=infinitesimal, $class="cone");
			}

			hulled("cone-hole", $class="cone-hole")
			{
				rod(d=34, h=infinitesimal, $class="hole cone-hole");
				align(top)
				translate([0,0,50])
				rod(d=110, h=infinitesimal, $class="hole cone-hole");
			}
		}
	}
}

module top_case()
{
	differed("hole", "top-case")
	box([95.5,56,3], $class="top-case case")
	{
		// Support screw holes.
		mirrored(x)
		mirrored(y)
		align(x+y+top, $class="screw hole")
		translate([-5.5,-5.5,0])
		rod(d=4,h=3, anchor=top-x-y, $fn=50, $class="screw hole");

		// Motor Holder
		align(top)
		rod(d=38, h=14, $fn=50)
		align(top)
		{
			// Hole for rotor.
			rod(d=8, h=3, anchor=top, $class="hole");

			// Hollow out.
			translated([0,0,-3])
			rod(d=34, h=18, anchor=top, $class="hole");

			// Motor mount screw hole.
			translated([9.5,0,0])
			rod(d=3,h=3, anchor=top-x, $class="hole");
			translated([-9.5,0,0])
			rod(d=3,h=3, anchor=top+x, $class="hole");

			// GDS Mount screw holes.
			translated([0,9.5,0])
			rod(d=3.5,h=3, anchor=top-y, $class="hole");
			translated([0,-9.5,0])
			rod(d=3.5,h=3, anchor=top+y, $class="hole");
		}
	}
}

module bottom_case()
{
	differed("hole", "bottom-case,tab", $class="bottom-case")
	box([95.5,56,3], $class="bottom-case")
	{
		// Supports to hold next level
		mirrored(x, $class="support")
		mirrored(y)
		align(x+y+top,$class="support")
		rounded_support(10,h=13)
		align(x+y+top,$class="support")
		differed("hole", "support")
		rounded_support(7,h=30)
		align(top)
		rod(3.5, h=13, anchor=top, $fn=50, $class="screw hole");

		// Tabs to connect to existing body.
		mirrored(y)
		//differed("hole", "tab")
		hulled("tab", $class="tab bottom-case")
		mirrored(x, $class="tab")
		align(x+y)
		translated([0,-6,0])
		rod(d=6,h=3,$fn=50)
		rod(d=4,h=3, $fn=50, $class="screw hole");

		// Hole in middle
		box([70,45,3], $class="hole")

		// Circuit board mount.
		mirrored(x)
		mirrored(y)
		align(x+y+bottom, $class="support")
		translated([1,4,0])
		differed("hole", "support")
		rounded_support(7,h=13)
		align(top)
		rod(3.5, h=13, anchor=top, $fn=50, $class="screw hole");
	}
}

module rounded_support(size=6, h=10)
{
	rod(d=size, h=h, anchor=x+y+bottom, $fn=50, $class="support")
	children();
	box([size,size/2,h], anchor=x+y+bottom, $class="support");
	box([size/2,size,h], anchor=x+y+bottom, $class="support");
}


module electronics()
{
	differed("hole", "perfboard", $class="electronics")
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

module gds_motor()
{
	differed("slice,screw", "motor")
	rod(d=32, h=17.25, anchor=bottom, $fn=50, $class="gds motor")
	{
		// Top side/rotor
		align(top)
		rod(d=6.15, h=2.25, anchor=bottom)
		align(top)
		rod(d=2, h=10.15, anchor=bottom);

		// Top side/screws
		align(top)
		{
			// Motor mount screw hole.
			translated([10,0,0])
			rod(d=2,h=3, anchor=top-x, $class="screw hole");

			// Motor mount screw hole.
			translated([-10,0,0])
			rod(d=2,h=3, anchor=top+x, $class="screw hole");
		}

		// Bottom side/leads
		align(bottom)
		box([32,7.75,2], $class="gds motor")
		align(bottom)
		rod(d=7.5, h=3.5)
		{
			align(x)
			translated([4.5,0,0])
			rod(d=5,h=3.5);

			align(-x)
			translated([-4.5,0,0])
			rod(d=5,h=3.5);
		}

		align(bottom)
		box([3,32,2], $class="gds motor");


		differed("hole", "slice", $class="slice")
		{
			box(50, $class="slice");
			rod(d=32 ,h=200, $fn=50, $class="hole");
		}
	}
}

module stencil()
{
	color([.2,.2,.2,0.5])
	union()
	{
		translate([0,0,75])
		union()
		{
			import("gds.stl");
			translated([0,0,-29])
			gds_motor();
		}

//		rotate([0,180,0])
//		import("body_u_wide.stl");
//
//		translate([0,0,-12])
//		import("body_d_wide.stl");
	}
}
