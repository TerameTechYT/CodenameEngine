import openfl.Lib;
import flixel.util.FlxDirection;
import flixel.util.FlxAxes;
import flixel.math.FlxMath;
import flixel.math.FlxBasePoint;
import flixel.FlxG;
import flixel.ui.FlxBarFillDirection;
import flixel.ui.FlxBar;
import flixel.ui.FlxSprite;
import funkin.backend.FunkinText;
import funkin.backend.FunkinSprite;
import funkin.game.PlayState;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

var movement:FlxBasePoint = new FlxBasePoint();
var songTxt:FunkinText;
var healthTxt:FunkinText;
var statsTxt:FunkinText;
var timeBarBG:FunkinSprite;
var timeBar:FlxBar;
var angle:Int = 0;
var iconAngle:Int = 15;
var hits:Int = 0;
var sicks:Int = 0;
var goods:Int = 0;
var bads:Int = 0;
var shits:Int = 0;

function updateStats()
{
	if (PlayState.opponentMode)
	{
		healthTxt.text = (100 - Math.floor(health * 5000) / 100) + "%";
	}
	else
	{
		healthTxt.text = (Math.floor(health * 5000) / 100) + "%";
	}

	statsTxt.text = "HITS:" + hits + "\nCOMBO:" + combo + "\nSICKS:" + sicks + "\nGOODS:" + goods + "\nBADS:" + bads + "\nSHITS:" + shits;
}

function destroy()
{
	angle = 0;
	hits = 0;
	sicks = 0;
	goods = 0;
	bads = 0;
	shits = 0;
}

function create()
{
	angle = 0;
	hits = 0;
	sicks = 0;
	goods = 0;
	bads = 0;
	shits = 0;
}

function postCreate()
{
	var cameraStart = strumLines.members[curCameraTarget].characters[0].getCameraPosition();
	cameraStart.y -= 100;
	FlxG.camera.focusOn(cameraStart);

	timeBarBG = new FunkinSprite(0, 0);
	timeBarBG.loadSprite(Paths.image('game/timeBar'));
	timeBarBG.x = (FlxG.width / 2) - (timeBarBG.width / 2);
	timeBarBG.y = 5;
	timeBarBG.visible = FlxG.save.data.extraInformation;
	timeBarBG.cameras = [camHUD];
	timeBarBG.scrollFactor.set();
	add(timeBarBG);

	timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBarFillDirection.LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8));
	timeBar.numDivisions = 1000;
	timeBar.visible = FlxG.save.data.extraInformation;
	timeBar.cameras = [camHUD];
	timeBar.scrollFactor.set();
	timeBar.createFilledBar(0xFF000000, dad.iconColor != null ? dad.iconColor : 0xFFFFFFFF);
	timeBar.setRange(0, 100);
	add(timeBar);

	songTxt = new FunkinText(0, 2, 0, "", 0);
	songTxt.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	songTxt.text = SONG.meta.displayName + " - " + PlayState.difficulty.toUpperCase();
	songTxt.x = (FlxG.width / 2) - (songTxt.width / 2);
	songTxt.visible = FlxG.save.data.extraInformation;
	songTxt.cameras = [camHUD];
	songTxt.borderSize = 1.25;
	songTxt.scrollFactor.set();
	add(songTxt);

	healthTxt = new FunkinText(0, 0, 0, "", 0);
	healthTxt.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	healthTxt.x = healthBarBG.x + 625;
	healthTxt.y = healthBarBG.y - 5;
	healthTxt.visible = FlxG.save.data.extraInformation;
	healthTxt.cameras = [camHUD];
	healthTxt.borderSize = 1.25;
	healthTxt.scrollFactor.set();
	add(healthTxt);

	statsTxt = new FunkinText(5, FlxG.height / 2, 0, "", 0);
	statsTxt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	statsTxt.visible = FlxG.save.data.extraInformation;
	statsTxt.cameras = [camHUD];
	statsTxt.borderSize = 1.25;
	statsTxt.scrollFactor.set();
	add(statsTxt);

	updateStats();
}

function update(elapsed)
{
	timeBar.value = (inst.time / inst.length) * 100;
	timeBar.alpha = healthBar.alpha;
	timeBarBG.alpha = healthBar.alpha;
	songTxt.alpha = healthBar.alpha;
	healthTxt.alpha = healthBar.alpha;
	statsTxt.alpha = healthBar.alpha;

	if (FlxG.save.data.cameraMovement)
	{
		camGame.angle = FlxMath.lerp(camGame.angle, angle, elapsed * camZoomingInterval);
	}

	iconP1.angle = FlxMath.lerp(iconP1.angle, 0, elapsed * 8);
	iconP2.angle = FlxMath.lerp(iconP2.angle, 0, elapsed * 8);
}

function beatHit()
{
	if (curBeat % 2 == 0)
	{
		iconP1.angle = -iconAngle;
		iconP2.angle = iconAngle;
	}
	else
	{
		iconP1.angle = iconAngle;
		iconP2.angle = -iconAngle;
	}
}

function onPlayerMiss(event)
{
	updateStats();
}

function onPlayerHit(event)
{
	if (!event.note.isSustainNote)
	{
		hits++;
		switch (event.rating)
		{
			case "sick":
				sicks++;
			case "good":
				goods++;
			case "bad":
				bads++;
			case "shit":
				shits++;
		}
	}

	updateStats();
}

function onDadHit(event)
{
	var minHealth = PlayState.opponentMode ? maxHealth * 0.875 : maxHealth * 0.125;
	var healthToDrain = (event.note.isSustainNote ? 0.05 : 0.1) / camZoomingInterval;

	if (FlxG.save.data.healthDrain && !FlxG.save.data.botplay && health - healthToDrain > minHealth)
	{
		health = FlxMath.lerp(health, minHealth, healthToDrain);
	}

	updateStats();
}

function onCameraMove(camMoveEvent)
{
	if (!FlxG.save.data.cameraMovement || camMoveEvent.strumLine == null || camMoveEvent.strumLine?.characters[0] == null)
	{
		return;
	}

	switch (camMoveEvent.strumLine.characters[0].animation.name)
	{
		default:
		case "idle":
			movement.set(0, 0);
			angle = 0;
		case "singLEFT":
			movement.set(-FlxG.save.data.cameraMovementAmount, 0);
			angle = FlxG.save.data.cameraAngleMovement;
		case "singDOWN":
			movement.set(0, FlxG.save.data.cameraMovementAmount);
			angle = 0;
		case "singUP":
			movement.set(0, -FlxG.save.data.cameraMovementAmount);
			angle = 0;
		case "singRIGHT":
			movement.set(FlxG.save.data.cameraMovementAmount, 0);
			angle = -FlxG.save.data.cameraAngleMovement;
	};

	camMoveEvent.position.x += movement.x;
	camMoveEvent.position.y += movement.y;
}

function onPostStrumCreation(event)
{
	var kc = event.strum.strumLine.data.keyCount != null ? event.strum.strumLine.data.keyCount : Flags.DEFAULT_STRUM_AMOUNT;

	if (event.player == (PlayState.opponentMode ? 0 : 1) && FlxG.save.data.keybindReminders)
	{
		var controlText = new FunkinText(0, 0, 0, "", 24);
		controlText.text = CoolUtil.keyToString(Reflect.getProperty(FlxG.save.data, (PlayState.opponentMode ? "P2_" : "P1_") + kc + "k" + event.strum.ID))
			.split("")
			.join("\n");
		controlText.cameras = [camHUD];
		controlText.alpha = 0;
		add(controlText);

		var ctx = event.strum.x + (event.strum.width / 2) - (controlText.width / 2);
		var cty = event.strum.y + (event.strum.height / 4);

		controlText.x = ctx;
		controlText.y = cty;

		FlxTween.tween(controlText, {y: cty + event.strum.width, alpha: 1}, 1, {
			ease: FlxEase.circOut,
			startDelay: 0.5 + (event.strum.ID / kc),
			onComplete: (tween1:FlxTween) ->
			{
				FlxTween.tween(controlText, {y: cty, alpha: 0}, 1, {
					ease: FlxEase.circOut,
					startDelay: 2,
					onComplete: (tween2:FlxTween) ->
					{
						controlText.destroy();
					}
				});
			}
		});
	}
}
