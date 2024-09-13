// ------- optional access to GPIO pins

GPIOaccess = 1;                  // 1 = cutout to access GPIO pins, 0 = no cutout

rfr        = GPIOaccess * 0.8;   // Reduced Fille Radio, 0=default
GPIOlen    = GPIOaccess * 51;    // GPIO cutout length
GPIOwid    = GPIOaccess * 5.8;   // GPIO cutout width


// include the YAPPgenerator library
include <../YAPP_Box/YAPPgenerator_v3.scad>

// Option variables useful for debugging, uncomment what is needed

//showPCB = true;
//hideLidWalls = true;
//hideBaseWalls = true;
//showMarkersPCB = true;
//showSideBySide = false;
//inspectX = 8;
//inspectZ = 9;
//showOrientation = false;


// import the board 3D model for reference

myPcb = "Radxa_ROCK_2A_V1200_3D.stl";

if (true)
{
//  translate([177.2,-95.3,5.7]) 
//  translate([175.2,-97.3,5.7]) 
    translate([175.2,-96.7,5.7]) 
  {
    rotate([0,0,90]) color("lightgray") import(myPcb);
  }
}

// -------------------------------------------------------

pcbLength     = 85;
pcbWidth      = 56;
pcbThickness  =  1.3;

lidWallHeight  =  5;
baseWallHeight = 19;

//-- padding between pcb and inside wall
paddingFront        =  1.0;
paddingBack         =  1.0;
paddingRight        =  3;
paddingLeft         =  1.6;

//-- Thickness
wallThickness       = 2.4;
basePlaneThickness  = 3.0;
lidPlaneThickness   = 2.0;

//-- ridge where base and lid off box can overlap
//-- Make sure this isn't less than lidWallHeight
ridgeHeight         = 5;
ridgeSlack          = 0.2;

//-- the radius of all outside edges and corners
roundRadius         = 3.0;

//-- How much the PCB needs to be raised from the base
//-- to leave room for solderings and whatnot
standoffHeight      = 5;
standoffDiameter    = 5.3;
standoffPinDiameter = 3.1;
standoffHoleSlack   = 0.4;

//  *** Snap Joins ***
snapJoins   =   
[
    [pcbLength/2 + 4, 5,           yappLeft, yappRight]
   //,[pcbLength-20, 5, yappLeft, yappRight]
]; 

pcbStands = 
[
    [ 3.5,  3.5, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, 0 ],
    [ 3.5, 52.5, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, rfr ],
    [61.5,  3.5, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, 0 ],
    [61.5, 52.5, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, rfr ]
];

cutoutsFront =
[
    [  0.9, 0.5, 15.5, 17.5, 2, yappRectangle, yappCoordPCB, yappOrigin ], 
    [ 19.0, 0.5, 15.5, 17.5, 2, yappRectangle, yappCoordPCB, yappOrigin ], 
    [ 37.2, 0.5, 17.0, 15.0, 2, yappRectangle, yappCoordPCB, yappOrigin ] 
];

cutoutsLeft =
[
    [11.2, 3.1, 12.5, 7.5, 1.0, yappRoundedRect, yappCoordPCB, yappCenter ], 
    [32.0, 4.5, 16.5, 7.8, 2.0, yappRectangle,   yappCoordPCB, yappCenter ], 
    [54.1, 3.2,  2.0, 2.0, 4.2, yappCircle,      yappCoordPCB, yappCenter ] 
];

cutoutsBack =
[
    [ 12.0,  3.0,  2,   2, 2.5, yappCircle,    yappCoordPCB, yappCenter ],
    [ 28.2, -0.8, 13, 3.5, 2.5, yappRectangle, yappCoordPCB, yappCenter ]
];


cutoutsLid = [
    [ 7.0, 7.0, 68.8, 35, 0, yappRectangle, yappCoordPCB, yappOrigin,
    [maskHoneycomb, 0, 1, 30] ],
    [ 7.0, 49.2, GPIOlen, GPIOwid, 0, yappRectangle, yappCoordPCB, yappOrigin ] // comment this line to remove GPIO access
];

cutoutsBase = [
    [12, 12, 60, 32, 0, yappRectangle, yappCoordPCB, yappOrigin, [maskHoneycomb, 0, 1, 0] ],
    [ 7, 7,   1,  1, 5, yappCircle, 1,   yappCoordPCB, yappCenter ],
    [78, 7,   1,  1, 5, yappCircle, 1,   yappCoordPCB, yappCenter ],
    [78,50,   1,  1, 5, yappCircle, 1,   yappCoordPCB, yappCenter ],
    [ 7,50,   1,  1, 5, yappCircle, 1,   yappCoordPCB, yappCenter ]
];

 
//---- This is where the magic happens ----
YAPPgenerate();
