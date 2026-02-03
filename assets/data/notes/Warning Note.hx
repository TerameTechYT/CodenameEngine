var missed:Int = 0;

function create()
{
	missed = 0;
}

function destroy()
{
	missed = 0;
}

function onNoteCreation(event)
{
	if (event.noteType != "Warning Note")
		return;

	event.noteSprite = "game/notes/warning";
}

function onPlayerMiss(event)
{
	if (event.noteType != "Warning Note")
		return;

	event.cancel(true);
	event.animCancelled = true;

	// Miss Effects
	missed++;
	misses++;
	health -= 1 + (missed * 0.1);
	totalAccuracyAmount -= 2;
}

function onPlayerHit(event)
{
	if (event.noteType != "Warning Note")
		return;
}
