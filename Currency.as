package {
	
	public class Currency {	
		/**
		 * 
		 */
		public static function getSymbol( code:String ): String {
			try {
				return CurrencyData[code + "symbol"];
			} catch ( err:Error ) {
				return null;
			}
			return null;
		}
		
		/**
		 * 
		 */
		public static function getFlag( code:String ): Class {
			try {
				return CurrencyData[code + "flag"];
			} catch ( err:Error ) {
				return null;
			}
			return null;
		}
	}
}

/**
 * 
 */
class CurrencyData {
	// AUD
	[Embed(source='flags/AU.png')] 
	public static var AUDflag:Class;
	public static var AUDsymbol:String = "$";
	
	// CNY
	[Embed(source='flags/CN.png')] 
	public static var CNYflag:Class;
	public static var CNYsymbol:String = "¥";
	
	// EUR
	[Embed(source='flags/EU.png')] 
	public static var EURflag:Class;
	public static var EURsymbol:String = "€";
	
	// GBP
	[Embed(source='flags/GB.png')] 
	public static var GBPflag:Class;
	public static var GBPsymbol:String = "£";
	
	// USD
	[Embed(source='flags/US.png')] 
	public static var USDflag:Class;
	public static var USDsymbol:String = "$";
}