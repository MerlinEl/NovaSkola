
package {
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	/**
	 * Replacement for trace.
	 * @author René Bača 2016
	 * @example
	 * ftrace( "Person name: % and age: %."           , "René", "43"   ); //outputs: Person name: René and age: 43."
	 * ftrace( "Person name: %(name) and age: %(age).", Object(person) ); //outputs: Person name: René and age: 43."
	 * ftrace( "Person data: %(all)"                  , Object(person) ); //outputs: All person data
	 * @param	raw String
	 * @param	... rest Aray
	 */
	public function ftrace(raw:String, ... rest):String {
		
		//Return empty string if raw is null, we don't want errors here
		if (raw == null) {
			return PP.ERROR;
		}
		//If parameters are undefined, trace raw input
		if (!rest || rest.length == 0) {
			
			trace(raw);
			return raw;
		}
		//Parsing is depend on input type
		var format_type:String = PP.getFromatType(raw);
		var cnt:int = PP.MAX_TRY;
		switch (format_type) {
		
		case PP.FORMAT_TYPE_ARRAY:
			
			var next:int = raw.indexOf(PP.FORMAT_TYPE_ARRAY);
			while (next != -1 && cnt > 0) {
				//trace("raw progress:" + raw)
				raw = raw.replace(PP.FORMAT_TYPE_ARRAY, rest.shift());
				next = raw.indexOf(PP.FORMAT_TYPE_ARRAY);
				cnt--;
			}
			break;
		case PP.FORMAT_TYPE_OBJECT:
			
			if (typeof(rest[0]) != "object") {
				
				trace("Input [" + rest[0] + "] is not object.")
				raw = "";
				break;
			}
			var key:String = PP.getNextKey(raw, PP.FORMAT_TYPE_OBJECT);
			//Get all data
			if (key == "all") {
				
				raw = raw.replace(PP.FORMAT_TYPE_OBJECT + key + ")", PP.getAllData(rest[0]));
				break;
			}
			//Get only requested data
			while (raw.indexOf(PP.FORMAT_TYPE_OBJECT) != -1 && cnt > 0) {
				
				//trace("raw progress:" + raw)
				raw = raw.replace(PP.FORMAT_TYPE_OBJECT + key + ")", Object(rest[0])[key]);
				key = PP.getNextKey(raw, PP.FORMAT_TYPE_OBJECT);
				cnt--;
			}
			break;
		}
		trace(raw);
		return raw;
	}
}

/** @private	Internal class with constants and functions.*/
class PP {
	
	static public const MAX_TRY:int = 1000;
	static public const ERROR:String = "format Error: ";
	static public const FORMAT_TYPE_ARRAY:String = "%";
	static public const FORMAT_TYPE_OBJECT:String = "%(";
	
	static public function getFromatType(str:String):String {
		
		return (str.indexOf(PP.FORMAT_TYPE_OBJECT) != -1) ? PP.FORMAT_TYPE_OBJECT : PP.FORMAT_TYPE_ARRAY;
	}
	
	/**
	 * Find next key in raw string %(key)
	 * @param	str
	 * @param	pattern
	 * @return	String(key name)
	 */
	static public function getNextKey(str:String, pattern:String):String {
		
		var key_start:int = str.indexOf(pattern) + pattern.length;
		if (key_start == -1) return "";
		var key_end:int = str.indexOf(")", key_start);
		return str.substring(key_start, key_end);
	}
	
	/**
	 * Colect all Object data as String
	 * @param	obj
	 * @return
	 */
	static public function getAllData(obj:Object):String {
		
		var str_data:String = "";
		for (var o in obj) str_data += "\nkey:" + o + " value:" + obj[o];
		return str_data;
	}
}

//Object, Aray, String, Number, atd..

/*
   function patternOccurrences(str:String, pattern:String):int {

   return str.match(new RegExp(pattern, "g")).length;
   }
   private function padString(str:String, paddingNum:int, paddingChar:String = " "):String {

   if (paddingChar == null) return str;

   return new Array(paddingNum).join(paddingChar).substr(0, paddingNum - str.length).concat(str);
   }
 */