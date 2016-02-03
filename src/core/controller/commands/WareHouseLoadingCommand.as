package core.controller.commands
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import core.config.GeneralNotifications;
	import core.config.PopupsName;
	import core.model.dateobj.DOActionDOPopup;
	import core.view.components.IconsVL;
	import core.view.components.PreloaderVL;
	import core.view.components.ScoreBarVL;
	import core.view.components.WellcomePopup;
	import core.view.mediators.IconsMediator;
	import core.view.mediators.PopupsMediator;
	import core.view.mediators.PreloadMediator;
	import core.view.mediators.ScoreBarMediator;
	import flash.display.Loader;
	import flash.events.Event;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import utils.WH.WareHouse;

	public class WareHouseLoadingCommand extends SimpleCommand
	{
		override public function execute(notifacation:INotification):void
		{
			var library_xml_list:XMLList=notifacation.getBody() as XMLList;
			var loader:BulkLoader=new BulkLoader();
			var url:String;
			var id:String;
			var type:String;
			for(var i:uint=0; i<library_xml_list.length();i++)
			{
				url=library_xml_list[i].attribute('URL');
				id=library_xml_list[i].attribute('ID');
				type=library_xml_list[i].attribute('TYPE');
				loader.add(url,{id:id, type:type});
			}
			loader.addEventListener(BulkLoader.COMPLETE, wareHouseLoad);
			loader.addEventListener(BulkProgressEvent.PROGRESS, onProgress);
			loader.start();
			facade.registerMediator(new PreloadMediator(new PreloaderVL()));
		}
		public function onProgress(event:BulkProgressEvent):void
		{
			sendNotification(GeneralNotifications.PRELOADER_PROGRESS, event.percentLoaded);
		}
		public function wareHouseLoad(event:Event):void
		{
			var it_name:String;
			var asset:Loader;
			var bulk_loader:BulkLoader=event.target as BulkLoader;	
			(bulk_loader as BulkLoader).removeEventListener(BulkLoader.PROGRESS, onProgress);
			(bulk_loader as BulkLoader).removeEventListener(BulkLoader.COMPLETE, wareHouseLoad);
			for(var i:uint=0; i<bulk_loader.items.length; i++)
			{
				it_name=(bulk_loader.items[i] as Object).id;				
				asset=(bulk_loader.items[i] as Object).loader as Loader;
				WareHouse.getInstance().addAsset(it_name,asset);
			}	
			facade.removeMediator(PreloadMediator.NAME);
			facade.registerMediator(new IconsMediator(new IconsVL()));
			facade.registerMediator(new ScoreBarMediator(new ScoreBarVL()));
			var doButtonList:Array=new Array(new DOActionDOPopup(GeneralNotifications.USER_REGISTRATION_COMMAND, 0, {data:Object}, null));
			facade.registerMediator(new PopupsMediator(PopupsName.MEDIATOR_FOR_WELLCOMEPOPUP,new WellcomePopup(),doButtonList));
		}
	}
}