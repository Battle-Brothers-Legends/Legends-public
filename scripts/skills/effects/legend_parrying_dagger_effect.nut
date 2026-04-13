this.legend_parrying_dagger_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 5
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendParryingDagger);
		this.m.Description = "Parrying Daggers work best against a single opponent, giving [color=%positive%]+20[/color] Melee Defense when adjacent to only a single enemy. This effect diminishes when facing more than one enemy at a time.";
		this.m.Icon = "ui/perks/parrying_circle.png";
		this.m.IconMini = "mini_parrying_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		// Note: because this effect is added via item.addSkill in legend_parrying_dagger, changing m.Order won't change how this effect will appear above all the other perk on the character screen
		// This appears to be the game's default behaviour for item-added effects. See legend_parrying_dagger for how the parrying effect is added differently such that it appears with the other effects/perks.
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
		this.m.IsStacking = false;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]" + this.m.Bonus + "[/color] Melee Defense"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsParrying = true;

		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local numAdjacentEnemies = ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len();

		this.m.Bonus = numAdjacentEnemies == 1 ? 20 : 5;

		_properties.MeleeDefense += this.m.Bonus;
	}

});
