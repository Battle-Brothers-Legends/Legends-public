this.legend_vengeance_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 1
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendVengeance);
		this.m.Icon = "ui/perks/vengeance_circle.png";
		this.m.IconMini = "mini_vengeance";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Having just received a blow, this character is determined to fight even harder! The next [color=%positive%]" + this.m.Stacks + "[/color] attacks will inflict [color=%positive%]20%[/color] more damage.";
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 1.2;
	}

	function onAnySkillExecuted(_skill, _targetTile, _targetEntity, _forFree) {
		if (_skill.isAttack()) {
			this.m.Stacks -= 1;
		}
		if (this.m.Stacks <= 0){
			::Legends.Effects.remove(_skill.getContainer().getActor(), ::Legends.Effect.LegendVengeance)
		}
	}
});

