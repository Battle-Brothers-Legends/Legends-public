this.legend_skin_ghoul_med <- this.inherit("scripts/entity/tactical/enemies/legend_skin_ghoul", {
	m = {},
	function create()
	{
		this.legend_skin_ghoul.create();
	}

	function onInit()
	{
		this.legend_skin_ghoul.onInit();
		this.legend_skin_ghoul.grow(true);
	}

});

