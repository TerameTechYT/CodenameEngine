import flixel.addons.effects.FlxTrail;

var dadTrail:FlxTrail = null;

function onEvent(event) {
	if (event.event.name == "Dad Trail") {
		if (dadTrail != null){
			dadTrail.visible = !dadTrail.visible;
			return;
		}

		remove(dad);

		dadTrail = new FlxTrail(dad, null, 7, 7, 0.3, 0.005);
		add(dadTrail);
		add(dad);
	}
}

function destroy() {
	if (dadTrail != null) dadTrail.destroy();
}