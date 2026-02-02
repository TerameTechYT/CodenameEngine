function onEvent(eventEvent) {
	var params:Array = eventEvent.event.params;
	if (eventEvent.event.name == "Change Stage Zoom") {
		defaultCamZoom = params[4];
	}
}
