module body_u()
{
	translate([-56,-128,-72])
		import("files/body_u.stl");
}
module body_d()
{
	translate([-56,-128,0])
		import("files/body_d.stl");
}

// Cut a thing in half. Use +1,-1,0 to determine which half.
module halve(axis=[0,0,0])
{
	intersection(){
		union(){
			children();
		}
		translate([1000*axis.x,1000*axis.y,1000*axis.z])
			cube([2000,2000,2000], center=true);

	}
}

module slice(size=[0,0,0],location=[0,0,0])
{
	intersection(){
		union(){
			children();
		}
		translate(location)
			cube(size,center=true);
	}
}

module stretch(width=5)
{
	union()
	{
		translate([0,width/2,0])
			halve([0,1,0])
				children();
		slice([100,width+1,100])
			body_u();
		translate([0,-width/2,0])
			halve([0,-1,0])
				body_u();
	}
}

stretch(5)
  body_u();
