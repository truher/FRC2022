/*
JavaScript side of the SimpleCanvas visualization module.

Takes the output generated by the Python SimpleCanvas element and draws it
in the browser window via HTML5 canvas.
*/

import * as THREE from 'https://threejs.org/build/three.module.js';
import { OrbitControls } from 'https://threejs.org/examples/jsm/controls/OrbitControls.js';

// scale of this rendering is 1 meter per scale unit
var Continuous3dVisualization = function() {
    var mesh, renderer, scene, camera, controls;
    var cube;
    var group;

    this.init = function() {
        renderer = new THREE.WebGLRenderer();
        renderer.setSize( 1646, 823 ); // same as 2d but just to make it look nice
        renderer.setPixelRatio( window.devicePixelRatio );
        document.body.appendChild( renderer.domElement );

        scene = new THREE.Scene();
        scene.background = new THREE.Color("white")
        scene.scale.set(1, -1, 1); // emulate "video" coord system which has reversed y axis
        camera = new THREE.PerspectiveCamera( 60, 1646/823, 1, 10000 );
        camera.position.set( 0, 0, 200 );
        camera.up.set(0,0,1);
        camera.lookAt(500,500,0);
        controls = new OrbitControls( camera, renderer.domElement );
        // avoid the ground
        controls.maxPolarAngle = Math.PI/2; 
    
        // lighting
        scene.add(new THREE.AmbientLight( 0xffffff, 0.5 ));
        var light = new THREE.DirectionalLight( 0xffffff, 1 );
        light.position.set( 0, 0, 1 );
        scene.add( light );

        scene.add( new THREE.AxesHelper( 20 ) );

        group = new THREE.Group();
        scene.add(group);

        var plane = new THREE.Mesh(
            new THREE.PlaneGeometry(16.46, 8.23),
            new THREE.MeshStandardMaterial( { color: "grey", flatShading: true, } )
        );
        plane.lookAt(0,0,1); // look up
        plane.position.set(16.46/2, 8.23/2, 0);
        scene.add( plane );
    };

    this.draw = function(objects) {
        group.clear(); // the group contains all the updatable objects

        console.log(objects);
        for (var i in objects) {
            var p = objects[i];
            if (p.Shape == "robot") this.drawRobot(p);
            else if (p.Shape == "cargo") this.drawCargo(p);
            else this.drawCircle(p.x, p.y, p.r, p.color);
        };
    };

    this.drawRobot = function(p) {
        var cx = p.x;
        var cy = p.y;
        //var dx = p.w - bumper_width; // FIXME bumpers
        //var dy = p.h - bumper_width;
        var dx = p.w;
        var dy = p.h;
        var x0 = cx - 0.5 * dx;
        var y0 = cy - 0.5 * dy;
        var robot = new THREE.Mesh(
            new THREE.BoxGeometry(dx, dy, dy), // FIXME z dimension
            new THREE.MeshStandardMaterial( { color: p.color, flatShading: true} )
        );
        robot.rotateZ(p.angle);
        robot.position.set(cx, cy, dy/2);
        group.add(robot);
    };

    this.drawCargo = function(p) {
        var cx = p.x;
        var cy = p.y;
        var cz = p.z + 0.12;
        var cargo = new THREE.Mesh(
            new THREE.SphereGeometry(0.12), // FIXME radius
            new THREE.MeshStandardMaterial( { color: p.color, flatShading: true} )
        );
        cargo.position.set(cx, cy, cz);
        group.add(cargo);
    };

    this.drawCircle = function(x, y, radius, color) {
        var cx = x;
        var cy = y;
        var r = radius;

        var thing = new THREE.Mesh(
            new THREE.SphereGeometry(r),
            new THREE.MeshStandardMaterial( { color: color, flatShading: true, } )
        );
        thing.position.set(cx,cy,r); // FIXME z dimension
        group.add(thing);
    };

    this.animate = function() {
        requestAnimationFrame(() => this.animate() );
        renderer.render(scene, camera);
    };
};

var Simple_3d_Continuous_Module = function() {
    var canvasDraw2 = new Continuous3dVisualization();
    canvasDraw2.init();
    canvasDraw2.animate();

    this.render = function(data) {
        console.log("hi");
        canvasDraw2.draw(data);
    };
};

export { Simple_3d_Continuous_Module }
