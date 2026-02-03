import funkin.editors.charter.Charter;
import funkin.game.PlayState;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;
import funkin.backend.FunkinText;

public var curSpeed:Float = 1;
public var botplayTxt:FunkinText;

function postCreate()
{
	botplayTxt = new FunkinText(healthBarBG.x + 375, healthBarBG.y + 30, Std.int(healthBarBG.width - 100), "Botplay", 16);
	botplayTxt.visible = FlxG.save.data.botplay;
	botplayTxt.cameras = [camHUD];
	add(botplayTxt);
}

function update(elapsed:Float)
{
	botplayTxt.alpha = healthBar.alpha;
	if (startingSong || !generatedMusic || !canPause || paused || health <= 0 || !FlxG.save.data.developerMode)
	{
		return;
	}

	if (FlxG.keys.justPressed.ONE)
	{
		endSong();
	}

	if (FlxG.keys.justPressed.TWO)
	{
		curSpeed -= (FlxG.keys.pressed.SHIFT ? 1 : 0.1);
	}

	if (FlxG.keys.justPressed.THREE)
	{
		curSpeed = 1;
	}

	if (FlxG.keys.justPressed.FOUR)
	{
		curSpeed += (FlxG.keys.pressed.SHIFT ? 1 : 0.1);
	}

	if (FlxG.keys.justPressed.SIX)
	{
		FlxG.save.data.botplay = !FlxG.save.data.botplay;
	}

	if (FlxG.keys.justPressed.SEVEN)
	{
		FlxG.switchState(new Charter(PlayState.SONG.meta.name, PlayState.difficulty, null, true));
	}

	updateBotplay(elapsed);
	updateSpeed(FlxG.keys.pressed.FIVE ? 20 : FlxMath.bound(curSpeed, 0.1, 4));
}

function updateBotplay(elapsed:Float)
{
	botplayTxt.visible = FlxG.save.data.botplay;

	if (PlayState.coopMode)
	{
		cpu.cpu = FlxG.save.data.botplay;
		player.cpu = FlxG.save.data.botplay;
	}
	else
	{
		if (PlayState.opponentMode)
		{
			cpu.cpu = FlxG.save.data.botplay;
		}
		else
		{
			player.cpu = FlxG.save.data.botplay;
		}
	}
}

function updateSpeed(speed:Float)
{
	FlxG.timeScale = inst.pitch = vocals.pitch = speed;
}

function onGamePause()
{
	updateSpeed(1);
}

function onSongEnd()
{
	updateSpeed(1);
}

function destroy()
{
	FlxG.timeScale = 1;
	FlxG.sound.muted = false;
}
