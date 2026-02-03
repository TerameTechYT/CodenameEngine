function onNoteCreation(event)
{
	if (event.noteType != "No Anim Warning Note")
		return;

	event.noteSprite = "game/notes/warning";
}

function onDadHit(event)
{
	if (event.noteType != "No Anim Warning Note")
		return;

	event.preventAnim();
}
