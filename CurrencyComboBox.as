package
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.controls.Button;
	import mx.controls.ComboBox;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.core.UIComponent;
	
	public class CurrencyComboBox extends ComboBox
	{
		protected var currencyItemRenderer:UIComponent;
		
		/**
		 * Stores a reference to the 'Button' which overlays the ComboBox.  Allows
		 * us to pass events to it so skins are properly triggered. 
		 */
		protected var buttonRef:Button = null;
		
		public function CurrencyComboBox()
		{
			super();
			
			itemRenderer = new ClassFactory( CurrencyItemRenderer );
		}
		
		override protected function createChildren(): void {
			super.createChildren();
			
			if ( !currencyItemRenderer ) {
				if ( itemRenderer != null ) {
					//remove the default textInput
					textInput.visible = false;
					
					//create a new itemRenderer to use in place of the text input
					currencyItemRenderer = itemRenderer.newInstance();
					
					// ADD THIS BINDING:
					// Bind the data of the textInputReplacement to the selected item
					BindingUtils.bindProperty(currencyItemRenderer, "data", this, "selectedItem", true);
					
					// Listen to the mouse events on our renderer so we can feed them to
					// the ComboBox overlay button.  This will make sure the button skins
					// are activated.  See ComboBox::commitProperties() code.
					currencyItemRenderer.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
					currencyItemRenderer.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
					currencyItemRenderer.addEventListener(MouseEvent.ROLL_OVER, onMouseEvent);
					currencyItemRenderer.addEventListener(MouseEvent.ROLL_OUT, onMouseEvent);
					currencyItemRenderer.addEventListener(KeyboardEvent.KEY_DOWN, onMouseEvent);
					
					addChild(currencyItemRenderer);
					
					// Save a reference to the mx_internal button for the combo box.
					//  We will need this so we can call its dispatchEvent() method.
					for (var i:int = 0; i < this.numChildren; i++) {
						var temp:Object = this.getChildAt(i);
						if (temp is Button) {
							buttonRef = temp as Button;
							break;
						} 
					}
				}
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if ( currencyItemRenderer ) {
				currencyItemRenderer.width = unscaledWidth;
				currencyItemRenderer.height = unscaledHeight;
				
				currencyItemRenderer.x = 5;
			}
		}
		
		/**
		 * React to certain mouse/keyboard events on our selected item renderer and
		 * pass the events to the ComboBox 'button' so that the skins are properly
		 * applied.
		 *  
		 * @param event A mouse or keyboard event to send to the ComboBox button.
		 * 
		 */
		protected function onMouseEvent(event:Event) : void {
			if (buttonRef != null) {
				buttonRef.dispatchEvent(event);
			}
		}
	}
}