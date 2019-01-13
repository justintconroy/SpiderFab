use <scad-utils/lists.scad>

function f(x,y,a=5,b=5) = pow(x,2)/pow(a,2) + pow(y,2)/pow(b,2);

function p(x,y,a=5,b=5) = [x,y,f(x,y,a,b)];
function p0(x,y) = [x,y,0];
function pw(x,y,a=5,b=5,w=1) = [x,y,f(x,y,a,b) - w];
function rev(b,v) = b ? v : [v[3],v[2],v[1],v[0]];


function face(x,y,a=5,b=5,step=0.5) = [
	p(x,y+step,a,b),
	p(x+step,y+step,a,b),
	p(x+step,y,a,b),
	p(x+step,y,a,b),
	p(x,y,a,b),
	p(x,y+step,a,b)];

function fan(a,i,step=.5,size=20) =
	  a == 0 ? [[0,0,0],[i,-size,0],[i+step,-size,0]]
	: a == 1 ? [[0,0,0],[i+step,size,0],[i,size,0]]
	: a == 2 ? [[0,0,0],[-size,i+step,0],[-size,i,0]]
	:          [[0,0,0],[size,i,0],[size,i+step,0]];

function sidex(x,y,a=5,b=5,step=.5)
	= [p0(x,y),p(x,y,a,b,step),p(x+step,y,a,b,step),p0(x+step,y)];
function sidey(x,y,a=5,b=5,step=.5)
	= [p0(x,y),p(x,y,a,b,step),p(x,y+step,a,b,step),p0(x,y+step)];

function points(a=5,b=5,step=.5,size=20) = flatten(concat(
	// top surface
	[for(x=[-size:step:size-step],y=[-size:step:size-step]) face(x,y,a,b,step)],

	// bottom surface as a triangle fan
	[for(a=[0:3],i=[-size:step:size-step]) fan(a,i,step,size)],

	//sides
	[for(x=[-size:step:size-step],y=[-size,size])
		rev(y < 0, sidex(x,y,a,b,step))],
	[for(y=[-size:step:size-step],x=[-size,size])
		rev(x < 0, sidey(x,y,a,b,step))]
	));

module plot_parabaloid(a=5,b=5,step=.5,size=20)
{
	tcount = 2*pow(2*size/step,2) + 8*size/step;
	scount = 8*size/step;

	tfaces = [for(a=[0:3:3*(tcount-1)]) [a,a+1,a+2]];
	sfaces = [for(a=[3*tcount:4:3*tcount + 4*scount]) [a,a+1,a+2,a+3]];
	faces = concat(tfaces,sfaces);

	polyhedron(points(a,b,step,size),faces,convexity=8);
}

plot_parabaloid(10,10);
