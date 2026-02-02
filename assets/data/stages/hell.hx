var rotInd = 0;
var wb_speed = 0;

function update(elapsed) {
	if (dad.curCharacter == "shaggy_green") {
		rotInd++;
		var rot = rotInd / 60;
		dad.x = Math.cos(rot / 3) * 20;
		dad.y = Math.cos(rot / 5) * 40 - 150;
	}
}
