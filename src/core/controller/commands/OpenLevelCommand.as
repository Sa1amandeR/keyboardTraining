package core.controller.commands
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import core.config.GeneralNotifications;
	import core.model.proxy.KeyboardProxy;
	import core.model.proxy.LevelInfoLoadProxy;
	import core.model.proxy.UsersProxy;
	import core.view.components.LevelViewLogic;
	import core.view.components.PreloaderVL;
	import core.view.mediators.IconsMediator;
	import core.view.mediators.LevelMediator;
	import core.view.mediators.PreloadMediator;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import utils.WH.WareHouse;

	public class OpenLevelCommand extends SimpleCommand
	{
		private var lvl_num:int;
		private var level_info_proxy:LevelInfoLoadProxy;
		override public function execute(notification:INotification):void
		{
			level_info_proxy=facade.retrieveProxy(LevelInfoLoadProxy.NAME) as LevelInfoLoadProxy;
			lvl_num=(notification.getBody() as int)-1;
			level_info_proxy.setCurrentLvl(notification.getBody() as int);
			var loader:BulkLoader=new BulkLoader();
			var url:String=level_info_proxy.getLevel(lvl_num).url;
			var id:String=level_info_proxy.getLevel(lvl_num).id;
			var type:String="movieclip";
			loader.add(url,{id:id,type:type});
			loader.addEventListener(BulkLoader.COMPLETE, swfLvlLoaded);
			loader.addEventListener(BulkProgressEvent.PROGRESS, onProgress);
			loader.start();
			facade.registerMediator(new PreloadMediator(new PreloaderVL()));
		}
		public function onProgress(event:BulkProgressEvent):void
		{
			sendNotification(GeneralNotifications.PRELOADER_PROGRESS, event.percentLoaded);
		}
		public function swfLvlLoaded(event:Event):void 
		{ 
			var it_name:String;
			var asset:Loader;
			var bulk_loader:BulkLoader=event.target as BulkLoader;
			(bulk_loader as BulkLoader).removeEventListener(BulkLoader.PROGRESS, onProgress);
			(bulk_loader as BulkLoader).removeEventListener(BulkLoader.COMPLETE, swfLvlLoaded);
			for(var i:uint=0; i<bulk_loader.items.length; i++)
			{
				it_name=(bulk_loader.items[i] as Object).id as String;				
				asset=(bulk_loader.items[i] as Object).loader as Loader;
				if(WareHouse.getInstance().hasAsset(it_name) == false)
				{
					WareHouse.getInstance().addAsset(it_name,asset);
				}
	 		}
			var text_array:Array=new Array();
			var text_in_xml:String=level_info_proxy.getLevel(lvl_num).text;
			var text_split:Array=text_in_xml.split("");
			var number:String; 
			var index:int=0;
			var errors:int=level_info_proxy.getLevel(lvl_num).errors;
			var num_character:int=level_info_proxy.getLevel(lvl_num).numWords;
			var time:int=level_info_proxy.getLevel(lvl_num).time;
			for(var n:int = 0; n<num_character; n++)
			{
				var rand:int = int(Math.random()*text_split.length);
				number = text_split[rand];
				text_array.push(number); 
			}
			facade.removeMediator(PreloadMediator.NAME);
			facade.removeMediator(IconsMediator.NAME);
			facade.registerMediator(new LevelMediator(new LevelViewLogic(it_name)));
			var currentUserScore:int=(facade.retrieveProxy(UsersProxy.NAME) as UsersProxy).getUserDO.get_us_score;
			sendNotification(GeneralNotifications.SCORE_BAR_RESET,currentUserScore);
			sendNotification(GeneralNotifications.WRONG_WORD,errors);
			sendNotification(GeneralNotifications.TEXT_TO_LVL,{textArr:text_array,numWords:num_character});
			sendNotification(GeneralNotifications.CURRENT_LVL_TIME,time);
			var lvlViewComponent:DisplayObjectContainer=(((facade.retrieveMediator(LevelMediator.NAME) as LevelMediator).getViewComponent() as LevelViewLogic).content as DisplayObjectContainer);
			facade.registerProxy(new KeyboardProxy(lvlViewComponent,text_array,index,errors,time));
			(facade.retrieveProxy(KeyboardProxy.NAME) as KeyboardProxy).timerStart();
		}
	}
}