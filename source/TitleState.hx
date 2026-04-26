package;

import flixel.FlxSprite;
import flixel.addons.ui.FlxUIState;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import openfl.Assets;

class TitleState extends FlxUIState
{
    var kade:KadeDev;
    
    static var initialized:Bool = false;

    public static var ext:String = #if web 'mp3' #else 'ogg'#end ;

    override function create()
    {
        add(new FlxSprite().loadGraphic(Paths.image('kitch')));

        var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
        logo.angle = -10;
        add(logo);

        var burger:FlxSprite = new FlxSprite(70, 275).loadGraphic(Paths.image('3dBurger'), true, 480, 480);
        burger.animation.add('spin', [for (i in 0...45) i], 24, true);
        burger.animation.play('spin');
        add(burger);

        kade = new KadeDev(330, -170);
        kade.setGraphicSize(1200);
        kade.updateHitbox();
        kade.antialiasing = true;
        add(kade);

        FlxG.mouse.visible = #if debug true #else false #end;

        FlxG.sound.playMusic(Paths.music(title));

        super.create();

        if (!initialized)
            init();
    }

    override function update(t:Float)
    {
        kade.animation.play('idle', false);

        if (FlxG.keys.justPressed.ENTER) 
        {
            FlxG.sound.music.stop();

            FlxG.switchState(new PlayState());
        }

        if (FlxG.keys.justPressed.SEVEN)
            FNFConverter.convert(Assets.getText(Paths.txt("SONG_TO_CONVERT.txt")));
        
        super.update(t);
    }

    function init():Void
    {
		var diamond:FlxGraphic = FlxGraphic.fromAssetKey(Paths.image('burger'));
		diamond.persist = true;
		diamond.destroyOnNoUse = false;

		FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 0.5, new FlxPoint(0, 0), {asset: diamond, width: 32, height: 32},
			new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
		FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.3, new FlxPoint(0, 0),
			{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;
    }
}