import funkin.backend.FunkinSprite;
import flixel.FlxG;

function onEvent(event) {
	if (event.event.name == "Shaggy Burst") {
		var burst = new FunkinSprite(dad.getMidpoint().x - 1000, dad.getMidpoint().y - 100);
		burst.frames = Paths.getSparrowAtlas("characters/shaggy");
		burst.animation.addByPrefix("burst", "burst", 30);
		burst.antialiasing = true;
		add(burst);

		burst.animation.play("burst", true);
		FlxG.sound.play(Paths.sound(event.event.params[0] ? "powerup" : "burst"), 0.5);

		new FlxTimer().start(0.9, () -> {
			remove(burst);
		});
	}
}
