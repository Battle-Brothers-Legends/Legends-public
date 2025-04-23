this.legend_bandit_rabble <- this.inherit("scripts/entity/tactical/legend_randomized_unit_abstract", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.BanditRabble;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditRabble.XP;
		this.legend_randomized_unit_abstract.create();
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_bandit_rabble_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.legend_randomized_unit_abstract.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditRabble);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 10)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_pox_01");
		}
		else if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			b.MeleeDefense += 5;
		}

		this.setArmorSaturation(0.8);
		this.getSprite("shield_icon").setBrightness(0.9);

		if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Easy)
			::Legends.Traits.grant(this, ::Legends.Trait.Craven);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		this.legend_randomized_unit_abstract.assignRandomEquipment();
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getItems().unequip(this.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
		this.getItems().equip(::Const.World.Common.pickItem([
			[1, "weapons/named/legend_named_blacksmith_hammer"],
			[1, "weapons/named/legend_named_butchers_cleaver"],
			[1, "weapons/named/legend_named_shovel"],
			[1, "weapons/named/legend_named_sickle"],
		], "scripts/items/"));
	}
});
