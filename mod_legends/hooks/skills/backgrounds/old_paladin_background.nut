::mods_hookExactClass("skills/backgrounds/old_paladin_background", function(o)
{
	o.create = function ()
	{
		this.paladin_background.create();
		this.m.HairColors = this.Const.HairColors.Old;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.AxeTree,
				::Const.Perks.ShieldTree,
				::Const.Perks.MaceTree,
				::Const.Perks.FlailTree,
				::Const.Perks.HammerTree,
				::Const.Perks.CrossbowTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree,
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.LargeTree,
				::Const.Perks.MartyrTree,
				::Const.Perks.FitTree,
				::Const.Perks.SturdyTree,
				::Const.Perks.InspirationalTree,
				::Const.Perks.IntelligentTree
			],
			Enemy = [
				::Const.Perks.UndeadTree
			],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	o.onSetAppearance = function ()
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
