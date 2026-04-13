// TODO images
this.legend_magic_circle_of_protection_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Circle = null
	},

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendMagicCircleOfProtectionEffect);
		this.m.Description = "This character is within an ally's Magic Circle of Protection.";
		this.m.Icon = "ui/perks/mage_legend_magic_circle_of_protection_circle.png";
		this.m.IconMini = "perk_37_mini";
		this.m.Overlay = "perk_37";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function setCircle(_circle)
	{
		this.m.Circle = _circle;
	}

	function getToolTip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gain [color=%positive%]+" + this.m.Circle.getDefBonus() + "[/color] Melee and Ranged defense and [color=%positive%]+" + this.m.Circle.getResolveBonus() + "[/color] resolve."
			}
		];
		return ret;
	}

	function onMovementFinished()
	{
		if (!this.isInRange())
		{
			this.m.Circle.removeActorById(this.getContainer().getActor().getID());
			this.removeSelf();
			return;
		}

		this.spawnIcon("perk_37", this.getContainer().getActor().getTile());
	}

	function isInRange()
	{
		if (this.getContainer().getActor().getFlags().get("Devoured") == true)
		{
			return false;
		}

		if (this.m.Circle.tileInCircleRange(this.getContainer().getActor().getTile()))
		{
			return true;
		}

		return false;
	}

	function onUpdate( _properties )
	{
		if (!this.isInRange())
		{
			this.m.Circle.removeActorById(this.getContainer().getActor().getID());
			this.removeSelf();
			return;
		}

		_properties.MeleeDefense += this.m.Circle.getDefBonus();
		_properties.RangedDefense += this.m.Circle.getDefBonus();
		_properties.Bravery += this.m.Circle.getResolveBonus();
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}
});
