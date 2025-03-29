::mods_hookExactClass("entity/tactical/warwolf", function(o) 
{
	o.setVariant <- function ( _v )
	{
		this.m.Items.getAppearance().Body = "bust_wolf_0" + _v + "_body";
		this.getSprite("body").setBrush("bust_wolf_0" + _v + "_body");
		this.getSprite("head").setBrush("bust_wolf_0" + _v + "_head");
		this.setDirty(true);
	}
});