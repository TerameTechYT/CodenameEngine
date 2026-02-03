function onNoteCreation(event)
{
	if (event.noteType != "No Anim Death Note")
		return;

	event.noteSprite = "game/notes/death";
}

function onDadHit(event)
{
	if (event.noteType != "No Anim Death Note")
		return;

	event.preventAnim();
}
