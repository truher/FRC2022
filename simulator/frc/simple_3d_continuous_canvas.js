import * as THREE from 'https://threejs.org/build/three.module.js';
import { OrbitControls } from 'https://threejs.org/examples/jsm/controls/OrbitControls.js';

// scale of this rendering is 1 meter per scale unit
// i tried to reverse the y coordinate with this:
//   scene.scale.set(1, -1, 1);
// but it seems to confuse the shadow camera, so i reverse the y myself
var Continuous3dVisualization = function() {
    var renderer, scene, camera, controls, group;

    this.init = function() {
        THREE.Object3D.DefaultUp.set(0, 0, 1);
        renderer = new THREE.WebGLRenderer();
        renderer.setSize( 1646, 823 ); // same viewport as 2d to make it look nice
        renderer.setPixelRatio( window.devicePixelRatio * 2 );
        renderer.antialias = true;
        renderer.shadowMap.enabled = true;
        renderer.shadowMap.type = THREE.PCFSoftShadowMap; 
        document.body.appendChild( renderer.domElement );

        scene = new THREE.Scene();
        scene.background = new THREE.Color("white")

        camera = new THREE.PerspectiveCamera( 60, 1646/823, 1, 10000 );
        camera.up.set(0,0,1);
        camera.position.set(16.46/2, -12, 3); // initial
        camera.target = new THREE.Vector3(16.46/2, -8.23/2, 0);
        camera.updateProjectionMatrix();

        controls = new OrbitControls(camera, renderer.domElement);
        // avoid the ground
        controls.maxPolarAngle = Math.PI/2; 
        controls.target = new THREE.Vector3(16.46/2, -8.23/2, 0);
    
        // ambient lighting
        scene.add(new THREE.AmbientLight(0xffffff, 0.2));

        // top-down directional light for shadows
        var light = new THREE.DirectionalLight(0xffffff, 1);
        light.position.set(16.46/2, -8.23/2, 8);
        light.target.position.set(16.46/2, -8.23/2, 0);
        light.castShadow = true;

        light.shadow.camera.left = -16.46/2;
        light.shadow.camera.right = 16.46/2;
        light.shadow.camera.top = 8.32/2;
        light.shadow.camera.bottom = -8.32/2;
        light.shadow.camera.near = 1;
        light.shadow.camera.far = 50;
        light.shadow.camera.up.set(0,1,0); // it's looking down

        light.shadow.bias = -0.001; // for artifacts

        // more dots
        light.shadow.mapSize.width = 1646; // one per cm
        light.shadow.mapSize.height = 823; // default

        scene.add( light );
        scene.add( light.target );
        scene.add( light.shadow.camera );

        const helper = new THREE.CameraHelper( light.shadow.camera );
        scene.add( helper );

        scene.add( new THREE.AxesHelper( 20 ) );

        group = new THREE.Group();
        scene.add(group);

        this.drawField();

    };

    this.drawField = function() {
        var plane = new THREE.Mesh(
            new THREE.PlaneGeometry(16.46, 8.23),
            this.material(0x404040)
        );
        plane.position.set(16.46/2, -8.23/2, 0);
        plane.receiveShadow = true;
        scene.add( plane );

        var blue_wall_material = this.material(0x404040);
        blue_wall_material.opacity = 0.5;
        blue_wall_material.transparent = true;
        var blue_wall = new THREE.Mesh(
            new THREE.PlaneGeometry(1.97, 8.23),
            blue_wall_material
        );
        blue_wall.rotateY(Math.PI/2)
        blue_wall.position.set(0, -8.23/2, 1.97/2);
        blue_wall.receiveShadow = true;
        scene.add( blue_wall );

        var red_wall_material = this.material(0x404040);
        red_wall_material.opacity = 0.5;
        red_wall_material.transparent = true;
        var red_wall = new THREE.Mesh(
            new THREE.PlaneGeometry(1.97, 8.23),
            red_wall_material
        );
        red_wall.rotateY(Math.PI/2)
        red_wall.position.set(16.46, -8.23/2, 1.97/2);
        red_wall.receiveShadow = true;
        scene.add( red_wall );

        var north_wall_material = this.material(0x404040);
        north_wall_material.opacity = 0.5;
        north_wall_material.transparent = true;
        var north_wall = new THREE.Mesh(
            new THREE.PlaneGeometry(16.46, 0.51),
            north_wall_material
        );
        north_wall.rotateX(Math.PI/2)
        north_wall.position.set(16.46/2, 0, 0.51/2);
        north_wall.receiveShadow = true;
        scene.add( north_wall );

        var south_wall_material = this.material(0x404040);
        south_wall_material.opacity = 0.5;
        south_wall_material.transparent = true;
        var south_wall = new THREE.Mesh(
            new THREE.PlaneGeometry(16.46, 0.51),
            south_wall_material
        );
        south_wall.rotateX(Math.PI/2)
        south_wall.position.set(16.46/2, -8.23, 0.51/2);
        south_wall.receiveShadow = true;
        scene.add( south_wall );

    };

    this.material = function(color) {
        var material = new THREE.MeshStandardMaterial( { color: color, flatShading: false, } );
        material.side = THREE.DoubleSide;
        return material;
    };

    this.draw = function(objects) {
        group.clear(); // the group contains all the updatable objects

        for (var i in objects) {
            var p = objects[i];
            if (p.Shape == "robot") this.drawRobot(p);
            else if (p.Shape == "cargo") this.drawCargo(p);
            else if (p.Shape == "obstacle") this.drawObstacle(p);
            else this.drawCircle(p.x, p.y, p.r, p.color);
        };
    };

    this.drawObstacle = function(p) {
        var thing = new THREE.Mesh(
            new THREE.CylinderGeometry(p.r, p.r, p.h, 32, 1, true),
            this.material("gray")
        );
        thing.rotateX(Math.PI/2)
        thing.position.set(p.x, -p.y, p.h/2); // FIXME z dimension
        thing.side = THREE.DoubleSide;
        thing.castShadow = true;     // on the field
        thing.receiveShadow = true;  // on the bottom
        group.add(thing);
    };

    this.robotGeometry = function(p) {
        var depth = 0.13; // bumper == 13cm high
        var radius0 = 0.032; // pool noodle radius = 3.2cm
        var smoothness = 8;
        var shape = new THREE.Shape();
        var eps = 0.00001; // mystery, so corners are round
        let radius = radius0 - eps;
        shape.absarc(eps, eps, eps, -Math.PI / 2, -Math.PI, true);
        shape.absarc(eps, p.h - radius * 2, eps, Math.PI, Math.PI / 2, true);
        shape.absarc(p.w - radius * 2, p.h - radius * 2, eps, Math.PI / 2, 0, true);
        shape.absarc(p.w - radius * 2, eps, eps, 0, -Math.PI / 2, true);
        var geometry = new THREE.ExtrudeBufferGeometry(shape, {
            depth: depth - radius0 * 2,
            bevelEnabled: true,
            bevelSegments: smoothness * 2,
            steps: 1,
            bevelSize: radius,
            bevelThickness: radius0,
            curveSegments: smoothness
        });

        geometry.center();
        return geometry;
    }

    this.drawRobot = function(p) {
        var g = this.robotGeometry(p);
        var robot = new THREE.Mesh(g, this.material(p.color));
        robot.rotateZ(p.angle);
        robot.position.set(p.x, -p.y, 0.125); // 19-(13/2)=12.5
        robot.side = THREE.FrontSide;
        robot.castShadow = true;     // on the field
        robot.receiveShadow = true;  // on the bottom
        group.add(robot);
    };

    this.drawCargo = function(p) {
        var cx = p.x;
        var cy = p.y;
        var cz = p.z + 0.12;
        var cargo = new THREE.Mesh(
            new THREE.SphereGeometry(0.12), // FIXME radius
            this.material(p.color)
        );
        cargo.position.set(cx, -cy, cz);
        cargo.side = THREE.FrontSide;
        cargo.castShadow = true;     // on the field
        cargo.receiveShadow = true;  // on the bottom
        group.add(cargo);
    };

    this.drawCircle = function(x, y, radius, color) {
        var cx = x;
        var cy = y;
        var r = radius;

        var thing = new THREE.Mesh(
            new THREE.SphereGeometry(r),
            this.material(color)
        );
        thing.position.set(cx, -cy, r); // FIXME z dimension
        thing.side = THREE.FrontSide;
        thing.castShadow = true;     // on the field
        thing.receiveShadow = true;  // on the bottom
        group.add(thing);
    };

    this.animate = function() {
        requestAnimationFrame(() => this.animate() );
        controls.update();
        renderer.render(scene, camera);
    };
};

var Simple_3d_Continuous_Module = function() {
    var canvasDraw2 = new Continuous3dVisualization();
    canvasDraw2.init();
    canvasDraw2.animate();

    this.render = function(data) {
        canvasDraw2.draw(data);
    };
};

export { Simple_3d_Continuous_Module }
