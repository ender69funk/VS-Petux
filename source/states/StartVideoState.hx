package states;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

import backend.StageData;
import objects.VideoSprite;


import states.MainMenuState;

var videoShow:String = 'PETUX';


class StartVideoState extends MusicBeatState
{
    public var cutscene:VideoSprite = null;
    override function create()
	{
		#if VIDEOS_ALLOWED
		var foundFile:Bool = false;
		var fileName:String = Paths.video(videoShow);

		#if sys
		if (FileSystem.exists(fileName))
		#else
		if (OpenFlAssets.exists(fileName))
		#end
		foundFile = true;

		if (foundFile)
		{
			var cutscene:VideoSprite = new VideoSprite(fileName, false, true, false);

			cutscene.finishCallback = function()
			{
				MusicBeatState.switchState(new MainMenuState());
			};

			cutscene.onSkip = function()
			{
                remove(cutscene);
				MusicBeatState.switchState(new MainMenuState());
			};

            add(cutscene);

            cutscene.videoSprite.play();
		}
		#else
		FlxG.log.warn('Platform not supported!');
		MusicBeatState.switchState(new MainMenuState());
		#end
    }
}