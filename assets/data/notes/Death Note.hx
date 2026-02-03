var hit:Int = 0;

function create()
{
	hit = 0;
}

function destroy()
{
	hit = 0;
}

function onNoteCreation(event)
{
	if (event.noteType != "Death Note")
		return;

	event.noteSprite = "game/notes/death";
	event.note.avoid = true;
	event.note.latePressWindow = 0.4;
}

function onPlayerMiss(event)
{
	if (event.noteType != "Death Note")
		return;

	event.cancel(true);
	event.animCancelled = true;
	event.note.strumLine.deleteNote(event.note);
}

function onPlayerHit(event)
{
	if (event.noteType != "Death Note")
		return;

	event.countAsCombo = event.showRating = false;
	event.note.splash = "smoke";
	event.note.wasGoodHit = false;
	event.strumGlowCancelled = true;
	FlxG.sound.play(Paths.sound('energy shoot'));

	// Hit Effects
	hit++;
	misses++;
	health -= 1 + (hit * 0.1);
	totalAccuracyAmount -= 2;

	event.preventAnim();
}
