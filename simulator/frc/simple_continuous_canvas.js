// data scale is 1m per unit
// rendering scale is 1cm per pixel
var ContinuousVisualization = function(width, height, context) {
	var height = height;
	var width = width;
	var context = context;

	this.draw = function(objects) {
		for (var i in objects) {
			var p = objects[i];
			if (p.Shape == "robot") this.drawRobot(p);
			else if (p.Shape == "cargo") this.drawCargo(p);
			else if (p.Shape == "obstacle") this.drawObstacle(p);
			else this.drawCircle(p.x, p.y, p.r, p.color);
		};
	};

        this.drawObstacle = function(p) {
	     this.drawCircle(p.x, p.y, p.r, "gray");
        };

	this.drawCircle = function(x, y, radius, color) {
		var cx = x * 100;
		var cy = y * 100;
		var r = radius * 100;

		context.beginPath();
		context.arc(cx, cy, r, 0, Math.PI * 2, false);
		context.closePath();
                context.lineWidth = 2;
		context.strokeStyle = color;
		context.stroke();
		//context.fillStyle = color;
		//context.fill();
	};

	this.drawCargo = function(p) {
		var cx = p.x * 100;
		var cy = p.y * 100;
                this.drawContents(cx, cy, p.color);
	};

	this.drawContents = function(cx, cy, color) {
                var radius = 12;  // 1cm per pixel.  FIXME: assumes width/height

		context.beginPath();
		context.arc(cx, cy, radius, 0, Math.PI * 2, false);
		context.closePath();
		context.fillStyle = color;
		context.fill();
	};

        // cargo hold has two slots; some robots mix them
	this.drawHold = function(cx, cy) {
		context.beginPath();
		context.arc(cx, cy, 14, 0, Math.PI * 2, false);
		context.closePath();
                context.lineWidth = 2;
		context.strokeStyle = "black";
		context.stroke();
	};

	this.drawBumpers = function(cx, cy, w, h, color) {
                var bumper_width = 20  // pixels?
		var dx = w * 100 - bumper_width;
		var dy = h * 100 - bumper_width;
		var x0 = cx - 0.5 * dx;
		var y0 = cy - 0.5 * dy;
                context.lineWidth = bumper_width;
		context.rect(x0, y0, dx, dy);
		context.strokeStyle = color;
		context.stroke();
	};

	this.drawRobot = function(p) {
                var cx = p.x * 100;
                var cy = p.y * 100;

		context.beginPath();
                context.translate(cx, cy);
                context.rotate(p.angle);
                context.translate(-cx, -cy);

                this.drawBumpers(cx, cy, p.w, p.h, p.color);

                // slot 1
                this.drawHold(cx, cy - 14);
                this.drawContents(cx, cy - 14, p.slot1);

                // slot 2
                this.drawHold(cx, cy + 14);
                this.drawContents(cx, cy + 14, p.slot2);

                context.setTransform(1, 0, 0, 1, 0, 0);
	};

	this.resetCanvas = function() {
		context.clearRect(0, 0, width, height);
		context.beginPath();
	};
};

var Simple_Continuous_Module = function(canvas_width, canvas_height) {
	// Create the element
	// ------------------

	// Create the tag:
	var canvas_tag = "<canvas width='" + canvas_width + "' height='" + canvas_height + "' ";
	canvas_tag += "style='border:1px dotted'></canvas>";
	// Append it to body:
	var canvas = $(canvas_tag)[0];
	$("#elements").append(canvas);

	// Create the context and the drawing controller:
	var context = canvas.getContext("2d");
	var canvasDraw = new ContinuousVisualization(canvas_width, canvas_height, context);

	this.render = function(data) {
		canvasDraw.resetCanvas();
		canvasDraw.draw(data);
	};

	this.reset = function() {
		canvasDraw.resetCanvas();
	};

};

export {Simple_Continuous_Module};
