import flixel.addons.effects.FlxTrail;

var shaggyPosition = 0;

function update(elapsed) {
	shaggyPosition += (elapsed * 1.5);

	dad.x = -600 + ((Math.cos(shaggyPosition) * 2) * 240);
	dad.y = -2250 + (Math.sin(2 * shaggyPosition) * 240);

	var yPos = (Math.sin(2 * shaggyPosition) * 40);

	boyfriend.y = -2000 - yPos;
	boyfriend.x = 700 + yPos;
	gf.y = -2000 + yPos;
	gf.x = yPos;

	gf_rock.x = gf.x + (gf_rock.width / 8);
	gf_rock.y = gf.y + (gf_rock.height / 2.75);

	bf_rock.x = boyfriend.x - (bf_rock.width / 16);
	bf_rock.y = boyfriend.y + (bf_rock.height / 3.75);
}
