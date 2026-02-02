function onEvent(eventEvent) {
	var params:Array = eventEvent.event.params;
	if (eventEvent.event.name == "Twist Hud") {

			var flxease:String = params[3] + (params[3] == "linear" ? "" : params[4]);
			twisting = true;
			FlxTween.tween(camHUD, {angle: params[1]}, ((Conductor.crochet / 4) / 1000) * params[2], {ease: Reflect.field(FlxEase, flxease), onComplete: function()
			{
				twisting = false;
				camHUD.angle = 0;
			}});
		
	}
}
