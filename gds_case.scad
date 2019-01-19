include <relativity.scad>;

//case();
translated([0,0,117]) case();
translated([0,0,10]) electronics();
stencil();


module case()
{
	hide("case")
	differed("hole","case")
	{
		hulled("case", $class="case")
		{
			box([150,130,infinitesimal], $class="case top")
			{
			}

			translated([0,0,-75], $class="case bottom")
			box([110,75,infinitesimal]);
		}

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
			rod(d=32, h=7, $class="hole");
		}

	}
}

module electronics()
{
	//hide("motor,cpu,mounting-holes")
	differed("mounting-holes", "perfboard", $class="electronics")
	box([70,50,1.6], anchor=bottom, $class="electronics perfboard")
	{
		mirrored(x)
		mirrored(y)
		align(x+y, $class="electronics mounting-holes")
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
		translate([0,0,75])
		union()
		{
			import("gds.stl");

			translated([0,0,-35])
			rod(d=32, h=25, anchor=bottom, $class="gds motor");
		}

		rotate([0,180,0])
		import("body_u_wide.stl");

		translate([0,0,-12])
		import("body_d_wide.stl");
	}
}
