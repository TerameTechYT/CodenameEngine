import funkin.game.HealthIcon;
import flixel.ui.FlxBarFillDirection;
import flixel.ui.FlxBar;
import funkin.game.PlayState;
import flixel.math.FlxMath;

var preloadedCharacters:Map<String, Character> = [];
var preloadedIcons:Map<String, FlxSprite> = [];
var iconOffsets:Array<Array<Float>> = [];

function postCreate() {
	for (event in PlayState.SONG.events)
		if (event.name == "Change Character" && !preloadedCharacters.exists(event.params[1])) {
			// Look for character that alreadly exists
			var foundPreExisting:Bool = false;
			for (strum in strumLines)
				for (char in strum.characters)
					if (char.curCharacter == event.params[1]) {
						preloadedCharacters.set(event.params[1], char);
						preloadedIcons.set(char.getIcon(), char == dad ? iconP2 : iconP1);
						foundPreExisting = true;
						break;
					}
			if (foundPreExisting)
				continue;

			// Create New Character
			var oldCharacter = strumLines.members[event.params[0]].characters[0];
			var newCharacter = new Character(oldCharacter.x, oldCharacter.y, event.params[1], oldCharacter.isPlayer);
			newCharacter.active = newCharacter.visible = false;
			newCharacter.drawComplex(FlxG.camera); // Push to GPU
			preloadedCharacters.set(event.params[1], newCharacter);

			// Adjust Camera Offset to Accomedate Stage Offsets
			if (newCharacter.isGF) {
				newCharacter.cameraOffset.x += stage.characterPoses["gf"].camxoffset;
				newCharacter.cameraOffset.y += stage.characterPoses["gf"].camyoffset;
			} else if (newCharacter.playerOffsets) {
				newCharacter.cameraOffset.x += stage.characterPoses["boyfriend"].camxoffset;
				newCharacter.cameraOffset.y += stage.characterPoses["boyfriend"].camyoffset;
			} else {
				newCharacter.cameraOffset.x += stage.characterPoses["dad"].camxoffset;
				newCharacter.cameraOffset.y += stage.characterPoses["dad"].camyoffset;
			}

			// Create New Icon
			if (preloadedIcons.exists(newCharacter.getIcon()))
				continue;
			var newIcon = createIcon(newCharacter);
			newIcon.active = newIcon.visible = false;
			newIcon.drawComplex(FlxG.camera); // Push to GPU
			preloadedIcons.set(newCharacter.getIcon(), newIcon);
		}
}

function onEvent(_) {
	var params:Array = _.event.params;
	if (_.event.name == "Change Character") {
		// Change Character
		var oldCharacter = strumLines.members[params[0]].characters[0];
		var newCharacter = preloadedCharacters.get(params[1]);
		if (oldCharacter.curCharacter == newCharacter.curCharacter)
			return;

		insert(members.indexOf(oldCharacter), newCharacter);
		newCharacter.active = newCharacter.visible = true;
		remove(oldCharacter);

		newCharacter.setPosition(oldCharacter.x, oldCharacter.y);
		newCharacter.playAnim(oldCharacter.animation.name);
		newCharacter.animation?.curAnim?.curFrame = oldCharacter.animation?.curAnim?.curFrame;
		strumLines.members[params[0]].characters[0] = newCharacter;

		return; // fix below later

		// Change Icon
		var oldIcon = oldCharacter.isPlayer ? iconP1 : iconP2;
		var newIcon = preloadedIcons.get(newCharacter.getIcon());

		if (oldIcon == newIcon)
			return;

		doIconBop = false;

		insert(members.indexOf(oldIcon), newIcon);
		newIcon.active = newIcon.visible = true;
		remove(oldIcon);

		doIconBop = true;
		// updateIcons();
	}
}

function createIcon(character:Character):FlxSprite {
	var icon = new FlxSprite();
	icon.ID = iconOffsets.length;

	var path = "icons/" + ((character != null) ? character.getIcon() : "face");
	if (!Assets.exists(Paths.image(path)))
		path = "icons/face";

	if ((character != null && character.xml != null && character.xml.exists("animatedIcon")) ? (character.xml.get("animatedIcon") == "true") : false) {
		icon.frames = Paths.getSparrowAtlas(path);

		if (!character.xml.exists("noLosingIcon")) {
			icon.animation.addByPrefix("losing", "losing", 24, true);
		}
		icon.animation.addByPrefix("idle", "idle", 24, true);
		icon.animation.play("idle");
	} else {
		icon.loadGraphic(Paths.image(path)); // load once to get the width and stuff
		icon.loadGraphic(icon.graphic, true, icon.graphic.width / 2, icon.graphic.height);
		icon.animation.add("non-animated", [0, 1], 0, false);
		icon.animation.play("non-animated");
	}

	icon.flipX = character.isPlayer;
	icon.updateHitbox();
	if (character.xml.exists("iconScale")) {
		icon.scale.set(Std.parseFloat(character.xml.get("iconScale")), Std.parseFloat(character.xml.get("iconScale")));
	}
	icon.cameras = [camHUD];
	icon.scrollFactor.set();
	icon.antialiasing = character.antialiasing;

	iconOffsets.push([
		(character != null && character.xml != null && character.xml.exists("iconoffsetx")) ? Std.parseFloat(character.xml.get("iconoffsetx")) : 0,
		(character != null && character.xml != null && character.xml.exists("iconoffsety")) ? Std.parseFloat(character.xml.get("iconoffsety")) : 0
	]);

	return icon;
}

function updateIcons() {
	// Positions
	iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0)) - 20);
	iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 1, 0))) - (iconP2.width - 20);

	// Offsets
	for (icon in [iconP1, iconP2]) {
		var offset = iconOffsets[icon.ID];
		icon.x += offset[0];
		icon.y = healthBar.y - (icon.height / 2) + (offset[1] * (camHUD.downscroll ? -1 : 1));
		// icon.y = healthBar.y - (icon.height / 2) + offset[1];

		// Animations
		var losing:Bool = switch (icon) {
			case iconP1: (healthBar.percent < 20);
			case iconP2: (healthBar.percent > 80);
			default: false;
		};

		if (icon.animation.name == "non-animated") {
			icon.animation.curAnim.curFrame = losing ? 1 : 0;
		} else {
			if (icon.animation.exists("losing"))
				icon.animation.play(losing ? "losing" : "idle");
		}
	}
}
