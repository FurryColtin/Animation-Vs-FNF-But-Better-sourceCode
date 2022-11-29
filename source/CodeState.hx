package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import haxe.Exception;
using StringTools;
import flixel.util.FlxTimer;
import flixel.addons.ui.FlxInputText;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;
import flixel.addons.transition.FlxTransitionableState;

class CodeState extends MusicBeatState
{
  var codeInput:FlxInputText;

  var wrongTxt:FlxText;
  var noTxt:FlxText;
  override function create()
  {

    FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
	FlxG.sound.music.fadeIn(1, 0, 0.8);

    FlxG.mouse.visible = true;

    codeInput = new FlxInputText(500, 350,FlxG.width,"enter code",32,FlxColor.WHITE,FlxColor.TRANSPARENT);
    codeInput.screenCenter();
    codeInput.scrollFactor.set();
    codeInput.background = false;
    codeInput.x += 300;
    codeInput.backgroundColor = FlxColor.TRANSPARENT;
    codeInput.callback = function(text,action){
      if(action=='enter'){
        if(text.toLowerCase() == "leafgreen")
          {
            startDaSong('stolen');
            FlxG.save.data.fatherUnlocked = true;
          }
        else if(text.toLowerCase() == "completion")
          {
            startDaSong('champion');
            FlxG.save.data.handsUnlocked = true;
          }
        else if(text.toLowerCase() == "luck")
        {
            startDaSong('furrydance');
            FlxG.save.data.handsUnlocked = true;
        }
        else if(text.toUpperCase() == "forgotten") 
          {
            CoolUtil.browserLoad("https://www.youtube.com/watch?v=8nPE3rxQP9g");
          }
        else if(text.toLowerCase() == "intro")
            {
                trace("MP4Handler.playMP4intro, lol");
            }
        else if(text.toLowerCase() == 'fading')
          {
            noTxt = new FlxText(0, 0, 0, "who said anything about a monochrome cover", 32);
                noTxt.setFormat("VCR OSD Mono", 36, FlxColor.RED, CENTER, SHADOW,FlxColor.BLACK);
                noTxt.scale.set(3,3);
                noTxt.screenCenter();
                noTxt.y += 100;      
                add(noTxt);
                noTxt.visible =true;
                new FlxTimer().start(0.7, function(tmr:FlxTimer)
                {
                    Sys.exit(0);
                });
          }
        else if(text.toLowerCase() == "red is furry")
            {
                noTxt = new FlxText(0, 0, 0, "agreed, but no song so now we crash.", 32);
                noTxt.setFormat("VCR OSD Mono", 36, FlxColor.RED, CENTER, SHADOW,FlxColor.BLACK);
                noTxt.scale.set(3,3);
                noTxt.screenCenter();
                noTxt.y += 100;      
                add(noTxt);
                noTxt.visible =true;
                new FlxTimer().start(0.7, function(tmr:FlxTimer)
                {
                    Sys.exit(0);
                });
            }
        else if(text.toLowerCase() == 'crash' || text.toLowerCase() == 'coraline pengraph')
            {
                Sys.exit(0);
            }
        else {
          //nuh uh
          FlxG.sound.play(Paths.sound('cancelMenu'));
          FlxG.camera.shake(0.0025, 0.50);
          add(wrongTxt);
          new FlxTimer().start(2, function(tmr:FlxTimer) {
            remove(wrongTxt);
          });
        }
      }
    }
    wrongTxt = new FlxText(0, 0, 0, "You can't enter a symbol with this name", 32);
    wrongTxt.setFormat("VCR OSD Mono", 36, FlxColor.RED, CENTER, SHADOW,FlxColor.BLACK);
    wrongTxt.shadowOffset.set(2,2);
    wrongTxt.screenCenter();
    wrongTxt.y += 100;
    //add(wrongTxt);
    wrongTxt.visible =false;
    wrongTxt.visible =true;

    add(codeInput);
    FlxG.mouse.visible=true;

    super.create();
  }
  var timer:Float = 0;

  override function update(elapsed:Float){
    timer += elapsed;
    FlxG.sound.music.volume = FlxMath.lerp(FlxG.sound.music.volume,.5,.1);
    if (controls.BACK && !codeInput.hasFocus)
    {
        FlxG.sound.play(Paths.sound('cancelMenu'));
        FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

        FlxG.sound.music.fadeIn(4, 0, 0.7);
        FlxG.switchState(new MainMenuState());
        FlxG.mouse.visible=true;
    }

    if(FlxG.keys.justPressed.ESCAPE && codeInput.hasFocus){
        codeInput.hasFocus=false;
    }

    super.update(elapsed);
  }
  function startDaSong(songName:String = "", songName2:String = "") {
    PlayState.SONG = Song.loadFromJson(songName + '-hard', songName);
    PlayState.isStoryMode = true;
    PlayState.storyDifficulty = 2;
    PlayState.storyWeek = 699;
    trace('CUR ' + PlayState.storyWeek);
    LoadingState.loadAndSwitchState(new PlayState());
  }
}
