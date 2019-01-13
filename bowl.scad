use <scad-utils/lists.scad>

function f0(x,y) = sin(sqrt(pow(x,2) + pow(y,2)) * 90/PI) + 1;
function f1(x,y) = sqrt(pow(x,2) + pow(y,2) + 3);
function f(x,y) = -(20*f0(x,y)/f1(x,y) + 4);

function p(x,y) = [x,y,f(x,y)];
function p0(x,y) = [x,y,0];
function pw(x,y,w=1) = [x,y,f(x,y) - w];

function rev(b,v) = b ? v : [v[3],v[2],v[1],v[0]];

function face(x,y,step=0.5) = [
	p(x,y+step),
	p(x+step,y+step),
	p(x+step,y),
	p(x+step,y),
	p(x,y),
	p(x,y+step)];

origin = [[0,0,0],[0,0,0],[0,0,0]];
function fan(a,i,step=.5,size=20) = origin;
//	  a == 0 ? [[0,0,0],[i,-size,0],[i+step,-size,0]]
//	: a == 1 ? [[0,0,0],[i+step,size,0],[i,size,0]]
//	: a == 2 ? [[0,0,0],[-size,i+step,0],[-size,i,0]]
//	:          [[0,0,0],[size,i,0],[size,i+step,0]];

function sidex(x,y,step=.5) = [pw(x,y),p(x,y,step),p(x+step,y,step),pw(x+step,y)];
function sidey(x,y,step=.5) = [pw(x,y),p(x,y,step),p(x,y+step,step),pw(x,y+step)];

function points(step=.5,size=20) = flatten(concat(
	// top surface
	[for(x=[-size:step:size-step],y=[-size:step:size-step]) face(x,y,step)],

	// bottom surface as a triangle fan
	[for(a=[0:3],i=[-size:step:size-step]) fan(a,i,step,size)],

	//sides
	[for(x=[-size:step:size-step],y=[-size,size])
		rev(y < 0, sidex(x,y,step))],
	[for(y=[-size:step:size-step],x=[-size,size])
		rev(x < 0, sidey(x,y,step))]
	));

module plot_bowl(step=.5,size=20)
{
	tcount = 2*pow(2*size/step,2) + 8*size/step;
	scount = 8*size/step;

	tfaces = [for(a=[0:3:3*(tcount-1)]) [a,a+1,a+2]];
	sfaces = [for(a=[3*tcount:4:3*tcount + 4*scount]) [a,a+1,a+2,a+3]];
	faces = concat(tfaces,sfaces);

	polyhedron(points(step,size),faces,convexity=8);
}

color("yellow")
	plot_bowl();
