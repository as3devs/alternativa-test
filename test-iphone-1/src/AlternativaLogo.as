package  
{
	import flash.display.Bitmap;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Cristiano Caldas
	 */
	public class AlternativaLogo extends Bitmap
	{
		[Embed(source='../asset/alternativa3d_big.png')]
		private var _asset			:Class;
		
		public function AlternativaLogo() 
		{
			super(Bitmap(new _asset()).bitmapData, "auto", true);
			
			this.cacheAsBitmap 			= true;
			//this.cacheAsBitmapMatrix 	= new Matrix();
		}
		
	}

}