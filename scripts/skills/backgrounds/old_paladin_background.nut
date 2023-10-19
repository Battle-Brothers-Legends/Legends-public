this.old_paladin_background <- this.inherit("scripts/skills/backgrounds/paladin_background", {
	m = {},
	function create()
	{
		this.paladin_background.create();
		this.m.HairColors = this.Const.HairColors.Old;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.GreatSwordTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree,	
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.IntelligentTree
			],
			Enemy = [
				this.Const.Perks.ZombieTree,
				this.Const.Perks.SkeletonTree
			],
			Class = [],
			Magic = []
		}
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		local body = actor.getSprite("body");
		tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		tattoo_body.Visible = true;
		tattoo_head.setBrush("scar_02_head");
		tattoo_head.Visible = true;
	}

});

