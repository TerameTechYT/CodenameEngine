import flixel.addons.effects.FlxTrail;

var bfTrail:FlxTrail = null;

function onEvent(event) {
	if (event.event.name == "BF Trail") {
		if (bfTrail != null){
			bfTrail.visible = !bfTrail.visible;
			return;
		}

		remove(boyfriend);

		bfTrail = new FlxTrail(boyfriend, null, 7, 7, 0.3, 0.005);
		add(bfTrail);
		add(boyfriend);
	}
}

function destroy() {
	if (bfTrail != null) bfTrail.destroy();
}