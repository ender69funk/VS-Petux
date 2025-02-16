package states;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.display.FlxBackdrop; 
import flixel.util.FlxAxes;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import backend.Song;
import flixel.FlxCamera;

enum MainMenuColumn {
	CENTER;
}

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '1.0'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var curColumn:MainMenuColumn = CENTER;
	var allowMouse:Bool = true; //Turn this off to block mouse movement in menus

	var checker:FlxBackdrop;
	var pituxtext:FlxText;
	var menuItems:FlxTypedGroup<FlxSprite>;

	var emitter:FlxEmitter;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var logo:FlxSprite;

	//Centered/Text options
	var optionShit:Array<String> = [
		'petuxara',
		'petyxexe',
		'shluxa',
		'kfc',
		'aixyi',
		'dedpetux',
		'credits',
		'options'
	];

	override function create()
	{
		FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
		Conductor.bpm = 102;
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = persistentDraw = true;

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		var yScroll:Float = 0.5;
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		checker = new FlxBackdrop(Paths.image('checker'), FlxAxes.XY);
		checker.scale.set(1.5, 1.5);
		checker.alpha = 0.2;
		add(checker);
		checker.scrollFactor.set(0, 0.07);
		checker.updateHitbox();



		logo = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.antialiasing = ClientPrefs.data.antialiasing;
		logo.screenCenter(X);
		logo.y = 70;
		logo.scrollFactor.set(0,0);
		add(logo);

		emitter = new FlxEmitter(0,800, 100);
		emitter.width = 1300;
		emitter.loadParticles(Paths.image("pituxparticle"), 100);
		emitter.lifespan.set(6);
		emitter.speed.set(500);
		emitter.launchAngle.set(-90, 90);
		emitter.alpha.set(1, 0.5, 0.25, 0);
		
		emitter.start(false, 0.01);


		var cursor = new FlxSprite().loadGraphic(Paths.image('cursor'));
		FlxG.mouse.load(cursor.pixels);
		FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, 4);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
			{
				var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
				var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
				menuItem.antialiasing = ClientPrefs.data.antialiasing;
				menuItem.frames = Paths.getSparrowAtlas('petuxmenu/menu_' + optionShit[i]);
				menuItem.animation.addByPrefix('idle', optionShit[i] + " idle", 24);
				menuItem.animation.addByPrefix('selected', optionShit[i] + " select", 24);
				menuItem.animation.play('idle');
				menuItems.add(menuItem);
				menuItem.scrollFactor.set(0.3,0.3);
				var scr:Float = (optionShit.length - 4) * 0.135;
				if (optionShit.length < 6)
					scr = 0;
				menuItem.scrollFactor.set(0, scr);
				menuItem.updateHitbox();
				menuItem.screenCenter();
				trace(menuItem.getScreenPosition());

				switch(i) {
					case 0:
						menuItem.setPosition(40, 400);
						FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					case 1:
						menuItem.setPosition(280, 400);
						FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					case 2:
						menuItem.setPosition(40, 40);
						FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					case 3:
						menuItem.setPosition(40, 190);
						FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					case 4:
						menuItem.setPosition(790, 400);
						FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					case 5:
						menuItem.setPosition(530, 400);
						FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					case 6:
						menuItem.setPosition(1100, 430);
						FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					case 7:
						menuItem.setPosition(1100, 540);
						FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
				}
			}

		var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "THIS IS A " + Application.current.meta.get('version'), 12);
		fnfVer.scrollFactor.set();
		fnfVer.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(fnfVer);
		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	var timeNotMoving:Float = 0;
	override function update(elapsed:Float)
	
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		var lerpVal:Float = boundTo(elapsed * 7.5, 0, 1);
		camFollow.setPosition(FlxG.mouse.x / 50, FlxG.mouse.y / 50);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
		if (!selectedSomethin)
		{
			FlxG.camera.x = FlxG.mouse.x / 30 - 20;
			FlxG.camera.y = FlxG.mouse.y / 30;
		}
		else
		{
			FlxTween.tween(FlxG.camera, {x: 0, y: 0}, 0.4, {ease: FlxEase.quadOut});
		}
		checker.x += 0.45;
		if (FlxG.sound.music.volume < 0.8)
			FlxG.sound.music.volume = Math.min(FlxG.sound.music.volume + 0.5 * elapsed, 0.8);

		if (!selectedSomethin)
		{
			var allowMouse:Bool = allowMouse;
			if (allowMouse && ((FlxG.mouse.deltaScreenX != 0 && FlxG.mouse.deltaScreenY != 0) || FlxG.mouse.justPressed)) //FlxG.mouse.deltaScreenX/Y checks is more accurate than FlxG.mouse.justMoved
			{
				allowMouse = false;
				FlxG.mouse.visible = true;
				timeNotMoving = 0;

				var selectedItem:FlxSprite;
				switch(curColumn)
				{
					case CENTER:
						selectedItem = menuItems.members[curSelected];
				}

					var dist:Float = -1;
					var distItem:Int = -1;
					for (i in 0...optionShit.length)
					{
						var memb:FlxSprite = menuItems.members[i];
						if(FlxG.mouse.overlaps(memb))
						{
							var distance:Float = Math.sqrt(Math.pow(memb.getGraphicMidpoint().x - FlxG.mouse.screenX, 2) + Math.pow(memb.getGraphicMidpoint().y - FlxG.mouse.screenY, 2));
							if (dist < 0 || distance < dist)
							{
								dist = distance;
								distItem = i;
								allowMouse = true;
							}
						}
					}

					if(distItem != -1 && selectedItem != menuItems.members[distItem])
					{
						curColumn = CENTER;
						curSelected = distItem;
						changeItem();
					}
				
			}
			else
			{
				timeNotMoving += elapsed;
				if(timeNotMoving > 2) FlxG.mouse.visible = false;
			}

			/*switch(curColumn)
			{
				case CENTER:
					if(controls.UI_LEFT_P && leftOption != null)
					{
						curColumn = LEFT;
						changeItem();
					}
					else if(controls.UI_RIGHT_P && rightOption != null)
					{
						curColumn = RIGHT;
						changeItem();
					}

				case LEFT:
					if(controls.UI_RIGHT_P)
					{
						curColumn = CENTER;
						changeItem();
					}

				case RIGHT:
					if(controls.UI_LEFT_P)
					{
						curColumn = CENTER;
						changeItem();
					}
			}*/

			if (controls.ACCEPT || (FlxG.mouse.justPressed && allowMouse))
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				if (optionShit[curSelected] != 'donate')
				{
					selectedSomethin = true;
					FlxG.mouse.visible = false;

					var item:FlxSprite;
					var option:String;
					switch(curColumn)
					{
						case CENTER:
							option = optionShit[curSelected];
							item = menuItems.members[curSelected];
					}

					for (mItem in menuItems.members)
					{
						if (!(mItem == item))
						{
							FlxTween.tween(mItem, {alpha: 0}, 0.4, {ease: FlxEase.quadOut});
						}
					}

					FlxTween.tween(item, {x: 536, y: 224}, 0.4, {ease: FlxEase.quadOut});
					add(emitter);
					FlxFlicker.flicker(item, 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						switch (option)
						{
							case 'petuxara':
								PlayState.SONG = Song.loadFromJson('petuxara', 'petuxara');
								Difficulty.list = ['Normal'];
								PlayState.storyDifficulty = 0;
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case 'petyxexe':
								PlayState.SONG = Song.loadFromJson('petuxexe', 'petuxexe');
								Difficulty.list = ['Normal'];
								PlayState.storyDifficulty = 0;
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case 'shluxa':
								PlayState.SONG = Song.loadFromJson('shluxa', 'shluxa');
								Difficulty.list = ['Normal'];
								PlayState.storyDifficulty = 0;
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case 'kfc':
								PlayState.SONG = Song.loadFromJson('kfc', 'kfc');
								Difficulty.list = ['Normal'];
								PlayState.storyDifficulty = 0;
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case 'aixyi':
								PlayState.SONG = Song.loadFromJson('aixyi', 'aixyi');
								Difficulty.list = ['Normal'];
								PlayState.storyDifficulty = 0;
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case 'dedpetux':
								PlayState.SONG = Song.loadFromJson('dedpetyx', 'dedpetyx');
								Difficulty.list = ['Normal'];
								PlayState.storyDifficulty = 0;
								LoadingState.loadAndSwitchState(new PlayState(), true);
							case 'credits':
								MusicBeatState.switchState(new CreditsState());
							case 'options':
								MusicBeatState.switchState(new OptionsState());
								OptionsState.onPlayState = false;
								if (PlayState.SONG != null)
								{
									PlayState.SONG.arrowSkin = null;
									PlayState.SONG.splashSkin = null;
									PlayState.stageUI = 'normal';
								}
						}
					});
					
					for (memb in menuItems)
					{
						if(memb == item)
							continue;

						FlxTween.tween(memb, {alpha: 0}, 0.4, {ease: FlxEase.quadOut});
					}
				}
				else CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
			}
			#if desktop
			if (controls.justPressed('debug_1'))
			{
				selectedSomethin = true;
				FlxG.mouse.visible = false;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	override function beatHit()
		{
			logo.scale.set(1.1,1.1);
			FlxTween.tween(logo.scale, {x: 1, y: 1}, 0.5, {ease: FlxEase.quadInOut});
			super.beatHit();
		}
	function changeItem(change:Int = 0)
	{
		if(change != 0) curColumn = CENTER;
		curSelected = FlxMath.wrap(curSelected + change, 0, optionShit.length - 1);
		FlxG.sound.play(Paths.sound('scrollMenu'));

		for (item in menuItems)
		{
			item.animation.play('idle');
			item.centerOffsets();

			FlxTween.tween(item.scale, {x: 1, y: 1}, 0.1, {ease: FlxEase.quadInOut});

			//item.scale.set(1, 1);
		}

		var selectedItem:FlxSprite;
		switch(curColumn)
		{
			case CENTER:
				selectedItem = menuItems.members[curSelected];
		}
		selectedItem.animation.play('selected');
		selectedItem.centerOffsets();
		FlxTween.tween(selectedItem.scale, {x: 1.1, y: 1.1}, 0.1, {ease: FlxEase.quadInOut});
	}
	function boundTo(value:Float, min:Float, max:Float):Float {
		var newValue:Float = value;
		if(newValue < min) newValue = min;
		else if(newValue > max) newValue = max;
		return newValue;
	}

}