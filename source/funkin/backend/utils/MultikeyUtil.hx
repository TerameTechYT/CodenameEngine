package funkin.backend.utils;

import funkin.backend.assets.ModsFolder;
import Xml;
import haxe.xml.Access;

final class MultikeyUtil {
	public static var multikeyLoaded:Bool;
	public static var multikeySingAnimations:Array<Array<Int>> = [];
	public static var multikeySplashAnimations:Array<Array<Int>> = [];
	public static var multikeyStrumAnimations:Array<Array<Array<String>>> = [];
	public static var multikeyNoteAnimations:Array<Array<Array<String>>> = [];

	public static function init() {
		if (multikeyLoaded)
			return;

		var filePaths:Array<String> = [];
		for (lib in ModsFolder.getLoadedModsLibs()) {
			var modName = lib.modName;
			var folder = Paths.xml('config/multikey/LIB_$modName');
			Logs.trace(folder);
			if (Assets.exists(folder))
				filePaths.push(folder);
		}

		for (source in filePaths) {
			var xml:Xml = null;

			try {
				xml = Xml.parse(Assets.getText(source));
			}
			catch (e) {
				Logs.trace('Error while parsing controls.xml: ${Std.string(e)}', ERROR);
			}

			if (xml != null) {
				loadMultikeyData(xml);
			}
		}

		multikeyLoaded = true;
	}

	public static function loadMultikeyData(xml:Xml) {
		for (keyData in xml.elementsNamed("keyData")) {
			for (keyGroup in keyData.elementsNamed("keyGroup")) {
				var keyCount = Std.parseInt(keyGroup.get("id")) - 1;

				multikeyStrumAnimations.push([]);
				multikeyNoteAnimations.push([]);
				multikeySplashAnimations.push([]);
				multikeySingAnimations.push([]);

				for (key in keyGroup.elementsNamed("key")) {
					for (strum in key.elementsNamed("strum")) {
						multikeyStrumAnimations[keyCount].push([strum.get("static"), strum.get("confirm"), strum.get("press")]);
					}

					for (note in key.elementsNamed("note")) {
						multikeyNoteAnimations[keyCount].push([note.get("static"), note.get("sustain"), note.get("sustainEnd")]);
					}

					for (splash in key.elementsNamed("splash")) {
						multikeySplashAnimations[keyCount].push(Std.parseInt(splash.get("id")));
					}

					for (direction in key.elementsNamed("direction")) {
						multikeySingAnimations[keyCount].push(Std.parseInt(direction.get("id")));
					}
				}
			}
		}
	}

	public static function getStrumAnimation(keyCount:Int, note:Int, direction:Int):String {
		return multikeyStrumAnimations[keyCount - 1][note][direction];
	}

	public static function getNoteAnimation(keyCount:Int, note:Int, direction:Int):String {
		return multikeyNoteAnimations[keyCount - 1][note][direction];
	}

	public static function getSplashAnimation(keyCount:Int, note:Int):Int {
		return multikeySplashAnimations[keyCount - 1][note] - 1;
	}

	public static function getSingAnimation(keyCount:Int, note:Int):Int {
		return multikeySingAnimations[keyCount - 1][note] - 1;
	}
}
