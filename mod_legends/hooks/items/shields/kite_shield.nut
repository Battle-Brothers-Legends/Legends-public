::mods_hookExactClass("items/shields/kite_shield", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [
			0,
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			// 10,
			// 11,
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
			33,
			// 34,
			35,
			36,
			// 37,
			38,
			39,
			40,
			41,
			// 42,
			43,
			44,
			45,
			101,
			102,
			103,
			104,
			105,
			106
		];
		if (this.Const.DLC.UnholdSupporter)
			this.m.Variants.push(34);
		if (this.Const.DLC.WildmenSupporter)
			this.m.Variants.push(37);
		if (this.Const.DLC.DesertSupporter)
			this.m.Variants.push(42);
		this.addVariants();
		this.m.Variant = this.Math.rand(0, 9); //random one is only 0-9 though
		this.updateVariant();
	}

	o.addVariants <- function ()
	{
		local bannerID = 0;
		foreach (banner in ::Const.PlayerBanners)
		{
			bannerID = banner.slice("banner_".len()).tointeger();
			bannerID = bannerID >= 50 ? bannerID : bannerID + 11;
			if (this.m.Variants.find(bannerID) == null)
			{
				this.m.Variants.push(bannerID);
			}
		}
		this.m.Variants.sort();
	}

	o.onPaintSpecificColor <- function ( _color )
	{
		this.setVariant(_color);
		this.updateAppearance();
	}

	o.onPaintInCompanyColors = function ()
	{
		local bannerID = this.World.Assets.getBannerID() >= 50 ? this.World.Assets.getBannerID() : this.World.Assets.getBannerID() + 11;
		this.setVariant(bannerID);
		this.updateAppearance();
	}
});
