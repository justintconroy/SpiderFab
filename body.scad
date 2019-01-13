module body_u()
{
	//translate([-56,-128,-72])
		import("body_u_fixed.stl");
}
module body_d()
{
	//translate([-56,-128,0])
		import("body_d_fixed.stl");
}

module femur_1()
{
	import("femur_1.stl");
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
		slice([100,width,100])
			children();
		translate([0,-width/2,0])
			halve([0,-1,0])
				children();
	}
}

module taller(height=1)
{
	union()
	{
		translate([0,0,height])
			slice([100,100,height + .5],[0,0,15.5])
				children();
		children();
	}
}

taller(1)
	import("tibia_r.stl");


//use<ruler.scad>;
//rotate([90,0,90])
	//translate([-11,0,25])
		//ruler(40);

