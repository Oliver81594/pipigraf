//requires the latest openscad, such as 2019.12.21 or newer

//f1(x)=2x - 1
//f2(x)=2x^2 - 4x - 1
//f3(x)=sin(x)
//f4(x)=4sin(x) + sin(x)cos(x) - 3cos^2(x)

f1 = function (x) 2 * x - 1;
f2 = function (x) 2 * x * x - 4 * x - 1;
f3 = function (x) sin(x / PI * 180.0);
f4 = function (x) 4*sin(x / PI * 180.0) + sin(x / PI * 180.0) * cos(x / PI * 180.0) - 3 * cos(x / PI * 180.0) * cos(x / PI * 180.0);

module one_pixel(x1, y1, x2, y2, ymin, ymax)
{
        scaleq = 360 / (ymax - ymin);
        w = 2 / scaleq;
        dir = 90-atan2(y2 - y1, x2 - x1);
        
        p1x = scaleq * (x1 + w * sin(dir + 90));
        p1y = scaleq * (y1 + w * cos(dir + 90));
        p2x = scaleq * (x1 + w * sin(dir - 90));
        p2y = scaleq * (y1 + w * cos(dir - 90));
        p3x = scaleq * (x2 + w * sin(dir + 90));
        p3y = scaleq * (y2 + w * cos(dir + 90));
        p4x = scaleq * (x2 + w * sin(dir - 90));
        p4y = scaleq * (y2 + w * cos(dir - 90));
        
        if ((y1 > ymin) && (y1 < ymax) &&
            (y2 > ymin) && (y2 < ymax))
          translate([0, 0, 1.9])
            polyhedron(points = [ [p1x, p1y, 0], 
                               [p3x, p3y, 0],
                               [p4x, p4y, 0],
                               [p2x, p2y, 0],
                               [p1x, p1y, 3], 
                               [p3x, p3y, 3],
                               [p4x, p4y, 3],
                               [p2x, p2y, 3] ],
                       faces = [ [0, 1, 5, 4],                             [3, 2, 1, 0],
                                 [7, 6, 2, 3],        
                                 [2, 6, 5, 1],                             [6, 7, 4, 5],        
                                 [7, 3, 0, 4] ],
                      convexity = 100);    
}

module graf(fn, xmin, xmax)
{
    scaleq = 360 / (xmax - xmin);
    
    color([1,0,0]){
        for(x = [xmin : (1.0 / scaleq) : xmax])
        {
            y1 = fn(x);
            y2 = fn(x + 1.1 / scaleq); 
            one_pixel(x, y1, x + 1.1 / scaleq, y2, xmin, xmax);
        }
    }
    
    translate([scaleq * xmin,scaleq * xmin,0])
      cube([scaleq * (xmax - xmin), scaleq * (xmax - xmin), 2]);
    translate([scaleq * xmin, -1, 0])
      cube([scaleq * (xmax - xmin), 2, 4]);
    translate([-1, scaleq * xmin, 0])
      cube([2, scaleq * (xmax - xmin), 4]);
}

//graf(f1, -180, 180);
//graf(f2, -4, 4);
//graf(f3, -PI, PI);
graf(f4, -2 * PI, 2 * PI);