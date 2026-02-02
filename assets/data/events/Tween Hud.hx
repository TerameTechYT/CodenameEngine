function onEvent(eventEvent) {
	var params:Array = eventEvent.event.params;
	if (eventEvent.event.name == "Tween Hud") {
		if (params[0] == false)
			camHUD.alpha = params[1]
		else {
			var flxease:String = params[3] + (params[3] == "linear" ? "" : params[4]);

			for (spr in [healthBarBG, healthBar, iconP1, iconP2, scoreTxt, missesTxt, accuracyTxt])
				FlxTween.tween(spr, {alpha: params[1]}, ((Conductor.crochet / 4) / 1000) * params[2], {ease: Reflect.field(FlxEase, flxease)});
		}
	}
}
