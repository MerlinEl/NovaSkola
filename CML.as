package {
	
	public class CML {
		
		/* GLOBAL CONSTANTS */
		public static const MAX_TRY:int = 400;
		/* GLOBAL VARIABLES CONTAINER */
		public static var APP_DIR:String;
		public static var WALKER; 
		public static var CONSOLE; 
		public static var MENU; 
		public static var MENUROOT; //root-menu with buttons
		public static var MENUSUB; //sub-menu with buttons
		public static var MENUSUB_XML:XML = new XML("undefined");
		public static var ALLPAGES; 
		public static var LESSONS; 
		/* TEMP DEFAULT FALSE!!! */
		public static var Lesson_Screen_Unlock:Boolean = true;
		public static var Bubble_Edit:Boolean = false;
		/* DYNAMIC */
		public static var Pages_Name:String = "All_Pages.swf";
		public static var zoom_mode:Boolean = false;
		public static var pet_stoped:Boolean = false;
		public static var final_animation:Boolean = false;
		public static var sun_switch:Boolean = false;
		public static var autocorrect_locked:Boolean = false;
		public static var Interface_Mode:String = "menu";
		public static var Old_Interface_Mode:String = "menu";
		public static var old_brush:String = "thick_6";
		public static var video_name:String = "08";
		public static var photo_name:String = "07_01";
		public static var MPV_Name:String = "";
		/* LESSONS */
		public static var bonus:Boolean = false;
		public static var correct_answers:Number = 0;
		public static var incorrect_answers:Number = 0;
		public static var lesson_correct_count:Number = 0;
		public static var incorrect_counter_enabled:Boolean = false;
		public static var edit_lesson:Boolean = false;
		public static var used_numbers:Array = new Array();
		public static var num_range:Array = new Array();

		public static function msg(msg:String, new_line:Boolean = false):void{

			if (CONSOLE) CONSOLE.add(msg, new_line);
		}
	}//class
}//package