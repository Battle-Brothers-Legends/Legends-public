::mods_hookExactClass("items/shields/wooden_shield", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
 			//10,
			11, 
			12,
			13,
			14,
			15,
			16,
			17,
			18,
			19,
			20,
			21,
			22,
			23,
			24,
			25,
			26,
			27,
			28,
			29,
			30,
			31,
			32,
			// 33,
			34,
			35,
			// 36,
			37,
			38,
			39,
			40,
			// 41,
			42,
			43,
			44
			104
		];
		if (this.Const.DLC.UnholdSupporter)
			this.m.Variants.push(33)
		if (this.Const.DLC.WildmenSupporter)
			this.m.Variants.push(36)
		if (this.Const.DLC.DesertSupporter)
			this.m.Variants.push(41)
		this.m.Variant = this.Math.rand(0, 9); //random one is only 1-9 though
	}

	o.onPaintSpecificColor <- function ( _color )
	{
		this.setVariant(_color);
		this.updateAppearance();
	}

	o.onPaintInCompanyColors = function ()
	{
		local bannerID = this.World.Assets.getBannerID() > 100 ? this.World.Assets.getBannerID() : this.World.Assets.getBannerID() + 11
		this.setVariant(bannerID);
		this.updateAppearance();
	}
});
