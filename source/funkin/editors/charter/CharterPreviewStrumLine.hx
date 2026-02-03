package funkin.editors.charter;

import funkin.game.Note;

class CharterPreviewStrumLine extends FlxTypedGroup<FlxSprite>
{
	public var keyCount:Int = 4;

	public function new(x:Float, y:Float, scale:Float, spacing:Float, keyCount:Int, scrollSpeed:Float){
		super();

		this.keyCount = keyCount;
		updatePos(x, y, scale, spacing, keyCount, scrollSpeed);
	}

	private var note:FlxSprite;
	public function generateStrums(x:Float, y:Float, scale:Float, spacing:Float, keyCount:Int, scrollSpeed:Float){
		this.keyCount = keyCount;

		for (member in members){
			member.destroy();
		}
		clear();
			
		for (i in 0...keyCount){
			var strum = new FlxSprite();
			strum.frames = Paths.getFrames("game/notes/default");
			strum.setGraphicSize(Std.int((strum.width * 0.7) * scale));
			strum.updateHitbox();

			switch (keyCount)
			{
				case 1:
					strum.animation.addByPrefix('static', 'square static');
					strum.animation.addByPrefix('confirm', 'square confirm', 24, false);
					strum.animation.addByPrefix('pressed', 'square press', 24, false);
				case 2:
					switch (i)
					{
						case 0:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left press', 24, false);
						case 1:
							strum.animation.addByPrefix('static', 'right static');
							strum.animation.addByPrefix('confirm', 'right confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'right press', 24, false);
					}
				case 3:
					switch (i)
					{
						case 0:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left press', 24, false);
						case 1:
							strum.animation.addByPrefix('static', 'square static');
							strum.animation.addByPrefix('confirm', 'square confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'square press', 24, false);
						case 2:
							strum.animation.addByPrefix('static', 'up static');
							strum.animation.addByPrefix('confirm', 'up confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'up press', 24, false);
					}
				case 4:
					switch (i)
					{
						case 0:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left press', 24, false);
						case 1:
							strum.animation.addByPrefix('static', 'down static');
							strum.animation.addByPrefix('confirm', 'down confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'down press', 24, false);
						case 2:
							strum.animation.addByPrefix('static', 'up static');
							strum.animation.addByPrefix('confirm', 'up confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'up press', 24, false);
						case 3:
							strum.animation.addByPrefix('static', 'right static');
							strum.animation.addByPrefix('confirm', 'right confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'right press', 24, false);
					}
				case 5:
					switch (i)
					{
						case 0:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left press', 24, false);
						case 1:
							strum.animation.addByPrefix('static', 'down static');
							strum.animation.addByPrefix('confirm', 'down confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'down press', 24, false);
						case 2:
							strum.animation.addByPrefix('static', 'square static');
							strum.animation.addByPrefix('confirm', 'square confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'square press', 24, false);
						case 3:
							strum.animation.addByPrefix('static', 'up static');
							strum.animation.addByPrefix('confirm', 'up confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'up press', 24, false);
						case 4:
							strum.animation.addByPrefix('static', 'right static');
							strum.animation.addByPrefix('confirm', 'right confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'right press', 24, false);
					}
				case 6:
					switch (i)
					{
						case 0:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left press', 24, false);
						case 1:
							strum.animation.addByPrefix('static', 'up static');
							strum.animation.addByPrefix('confirm', 'up confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'up press', 24, false);
						case 2:
							strum.animation.addByPrefix('static', 'right static');
							strum.animation.addByPrefix('confirm', 'right confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'right press', 24, false);
						case 3:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left2 press', 24, false);
						case 4:
							strum.animation.addByPrefix('static', 'down static');
							strum.animation.addByPrefix('confirm', 'down confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'down press', 24, false);
						case 5:
							strum.animation.addByPrefix('static', 'right static');
							strum.animation.addByPrefix('confirm', 'right2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'right2 press', 24, false);
					}
				case 7:
					switch (i)
					{
						case 0:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left press', 24, false);
						case 1:
							strum.animation.addByPrefix('static', 'up static');
							strum.animation.addByPrefix('confirm', 'up confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'up press', 24, false);
						case 2:
							strum.animation.addByPrefix('static', 'right static');
							strum.animation.addByPrefix('confirm', 'right confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'right press', 24, false);
						case 3:
							strum.animation.addByPrefix('static', 'square static');
							strum.animation.addByPrefix('confirm', 'square confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'square press', 24, false);
						case 4:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left2 press', 24, false);
						case 5:
							strum.animation.addByPrefix('static', 'down static');
							strum.animation.addByPrefix('confirm', 'down confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'down press', 24, false);
						case 6:
							strum.animation.addByPrefix('static', 'right static');
							strum.animation.addByPrefix('confirm', 'right2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'right2 press', 24, false);
					}
				case 8:
					switch (i)
					{
						case 0:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left press', 24, false);
						case 1:
							strum.animation.addByPrefix('static', 'down static');
							strum.animation.addByPrefix('confirm', 'down confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'down press', 24, false);
						case 2:
							strum.animation.addByPrefix('static', 'up static');
							strum.animation.addByPrefix('confirm', 'up confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'up press', 24, false);
						case 3:
							strum.animation.addByPrefix('static', 'right static');
							strum.animation.addByPrefix('confirm', 'right confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'right press', 24, false);
						case 4:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left2 press', 24, false);
						case 5:
							strum.animation.addByPrefix('static', 'down static');
							strum.animation.addByPrefix('confirm', 'down2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'down2 press', 24, false);
						case 6:
							strum.animation.addByPrefix('static', 'up static');
							strum.animation.addByPrefix('confirm', 'up2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'up2 press', 24, false);
						case 7:
							strum.animation.addByPrefix('static', 'right static');
							strum.animation.addByPrefix('confirm', 'right2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'right2 press', 24, false);
					}
				case 9:
					switch (i)
					{
						case 0:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left press', 24, false);
						case 1:
							strum.animation.addByPrefix('static', 'down static');
							strum.animation.addByPrefix('confirm', 'down confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'down press', 24, false);
						case 2:
							strum.animation.addByPrefix('static', 'up static');
							strum.animation.addByPrefix('confirm', 'up confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'up press', 24, false);
						case 3:
							strum.animation.addByPrefix('static', 'right static');
							strum.animation.addByPrefix('confirm', 'right confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'right press', 24, false);
						case 4:
							strum.animation.addByPrefix('static', 'square static');
							strum.animation.addByPrefix('confirm', 'square confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'square press', 24, false);
						case 5:
							strum.animation.addByPrefix('static', 'left static');
							strum.animation.addByPrefix('confirm', 'left2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'left2 press', 24, false);
						case 6:
							strum.animation.addByPrefix('static', 'down static');
							strum.animation.addByPrefix('confirm', 'down2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'down2 press', 24, false);
						case 7:
							strum.animation.addByPrefix('static', 'up static');
							strum.animation.addByPrefix('confirm', 'up2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'up2 press', 24, false);
						case 8:
							strum.animation.addByPrefix('static', 'right static');
							strum.animation.addByPrefix('confirm', 'right2 confirm', 24, false);
							strum.animation.addByPrefix('pressed', 'right2 press', 24, false);
					}
			}

			strum.animation.play('static');
			strum.alpha = 0.4;
			add(strum);
		}

		note = new FlxSprite();
		note.frames = Paths.getFrames("game/notes/default");
		note.setGraphicSize(Std.int((note.width * 0.7) * scale));
		note.updateHitbox();
		note.animation.addByPrefix('left', 'left0');
		note.animation.play('left');
		note.alpha = 0.4;
		add(note);
	}

	var noteTime:Float = FlxG.height;
	var scroll:Float = 1.0;

	public function updatePos(x:Float, y:Float, scale:Float, spacing:Float, keyCount:Int, scrollSpeed:Float){
		this.keyCount = keyCount;

		if (members.length-1 != keyCount) //strumline + note
			generateStrums(x, y, scale, spacing, keyCount, scrollSpeed);

		for (i in 0...keyCount){
			var strum = members[i];

			strum.x = CoolUtil.fpsLerp(strum.x, x + (Note.swagWidth * scale * spacing * i), 0.2);
			strum.y = CoolUtil.fpsLerp(strum.y, y + (Note.swagWidth*0.5) - (Note.swagWidth * scale * 0.5), 0.2);
			strum.scale.x = strum.scale.y = CoolUtil.fpsLerp(strum.scale.x, 0.7 * scale, 0.2);
			strum.updateHitbox();
		}


		scroll = CoolUtil.fpsLerp(scroll, scrollSpeed, 0.2);
		noteTime -= FlxG.elapsed * scroll * 1000 * 0.45;
		if (noteTime <= 0.0)
			noteTime = FlxG.height;

		note.x = members[0].x;
		note.y = members[0].y + noteTime;
		note.scale.x = note.scale.y = members[0].scale.x;
		note.updateHitbox();
		note.alpha = CoolUtil.fpsLerp(note.alpha, scrollSpeed == 0.0 ? 0.0 : 0.4, 0.2);
	}
}