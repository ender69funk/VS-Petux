package states;

import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import backend.Song;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

enum MainMenuColumn {
	CENTER;
}

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '1.0'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var curColumn:MainMenuColumn = CENTER;
	var allowMouse:Bool = true; //Turn this off to block mouse movement in menus

	var menuItems:FlxTypedGroup<FlxSprite>;

	var logo:FlxSprite;

	var cine1:FlxSprite;
	var cine2:FlxSprite;

	var pressedEnter:Bool = false;
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
	var scoreBG:FlxSprite;
	var credits:FlxText;

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = 0.25;
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		

		var backdrop4ik:FlxBackdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FFFFFF, 0x0));
		backdrop4ik.velocity.set(40, 40);
		add(backdrop4ik);

	//	scoreBG = new FlxSprite(credits.x - 6, credits.y - 6).makeGraphic(1, 1, 0xFF000000);
	//	scoreBG.alpha = 0.6;
	//	add(scoreBG);

		credits = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		credits.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		add(credits);
		
		var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.antialiasing = ClientPrefs.data.antialiasing;
		logo.screenCenter(X);
		logo.y = 70;
		add(logo);

		var cursor = new FlxSprite().loadGraphic(Paths.image('cursor'));
		FlxG.mouse.load(cursor.pixels);

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
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.updateHitbox();
			menuItem.screenCenter(X);

			switch(i) {
				case 0:
					menuItem.setPosition(40, 400);
					FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					credits.text = 'КОМПОЗЕР - gla9ol\n
					АРТИСТ - ЕРИХ\n
					КОДЕР - ЕРИХ\n
					ЧАРТЕР - ЕРИХ\n
					\n\n
					ПЕТУХАРА';
				case 1:
					menuItem.setPosition(280, 400);
					FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					credits.text = 'КОМПОЗЕР - NITRIX\n
					АРТИСТ - ЕРИХ\n
					КОДЕР - ЕРИХ\n
					ЧАРТЕР - ЕРИХ\n
					\n\n
					ПЕТУХЕХЕ';
				case 2:
					menuItem.setPosition(40, 40);
					FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					credits.text = 'КОМПОЗЕР - gla9ol (ft. rostick)\n
					АРТИСТ - ГЛЕБ\n
					КОДЕР - ЕРИХ\n
					ЧАРТЕР - ЕРИХ\n
					\n\n
					ШЛЮХА';
				case 3:
					menuItem.setPosition(40, 190);
					FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					credits.text = 'КОМПОЗЕР - gla9ol (ft. rostick)\n
					АРТИСТ - ГЛЕБ\n
					КОДЕР - ЕРИХ\n
					ЧАРТЕР - ЕРИХ\n
					\n\n
					КФС';
				case 4:
					menuItem.setPosition(790, 400);
					FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					credits.text = 'КОМПОЗЕР - gla9ol\n
					АРТИСТ - ЕРИХ\n
					КОДЕР - ЕРИХ\n
					ЧАРТЕР - ЕРИХ\n
					\n\n
					ПЕТУХАРА';
				case 5:
					menuItem.setPosition(530, 400);
					FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					credits.text = 'КОМПОЗЕР - hikari\n
					АРТИСТ - ЕРИХ И ГЛЕБ\n
					КОДЕР - ЕРИХ\n
					ЧАРТЕР - ЕРИХ\n
					\n\n
					ПЕТУХАРА';
				case 6:
					menuItem.setPosition(1100, 430);
					FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					credits.text = '';
				case 7:
					menuItem.setPosition(1100, 540);		
					FlxTween.tween(menuItem, {y: menuItem.y + FlxG.random.int(-10, 10)}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
					credits.text = '';
				}
		}

		var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "THIS IS A " + Application.current.meta.get('version'), 12);
		fnfVer.scrollFactor.set();
		fnfVer.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(fnfVer);
/*
		var cine1:FlxSprite = new FlxSprite(0, -360).makeGraphic(FlxG.width, 360, 0xff000000);
		cine1.antialiasing = ClientPrefs.data.antialiasing;
		cine1.screenCenter(X);
		add(cine1);

		var cine2:FlxSprite = new FlxSprite(0, 1080).makeGraphic(FlxG.width, 360, 0xff000000);
		cine2.antialiasing = ClientPrefs.data.antialiasing;
		cine2.screenCenter(X);
		add(cine2);*/

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	var timeNotMoving:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
			FlxG.sound.music.volume = Math.min(FlxG.sound.music.volume + 0.5 * elapsed, 0.8);

		FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX - (FlxG.width / 2)) * 0.07, (1/30) * 240 * elapsed);
		FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY - 6 -(FlxG.height / 2)) * 0.07, (1/30) * 240 * elapsed);

		

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

			if (controls.ACCEPT || (FlxG.mouse.justPressed && allowMouse))
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				pressedEnter = true;
				
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

					FlxTween.cancelTweensOf(FlxG.camera);
					FlxTween.tween(FlxG.camera, {zoom: 3}, 1.5, {ease: FlxEase.expoInOut});

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
		}

		var selectedItem:FlxSprite;
		switch(curColumn)
		{
			case CENTER:
				selectedItem = menuItems.members[curSelected];
		}
		selectedItem.animation.play('selected');
		selectedItem.centerOffsets();
			setBrightness(selectedItem, 1);
			FlxTween.tween(selectedItem.scale, {x: 1.1, y: 1.1}, 0.1, {ease: FlxEase.quadInOut});
	}
	
	function setBrightness(object:FlxSprite, brightness:Float):Void {
		object.setColorTransform(brightness, brightness, brightness, 1.0);
	}
}