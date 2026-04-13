this.legend_hunting_big_game <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendHuntingBigGame);
		this.m.Icon = "ui/perks/BigGameHunterPerk.png";
		this.m.IconMini = "mini_big_game_hunter";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Description = "When fighting beasts, this character gains an additional modifier that deals bonus damage based on the target\'s missing health. When not fighting beasts, they gain [color=%positive%]+10%[/color] ranged weapon damage but no additional modifier. Only works with ranged weapons.";
		this.m.IsActive = false;
		this.m.IsStacking = false;
		// this.m.IsRemovedAfterBattle = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return
		}

		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			// If not in battle, then this should be a trait and not a status effect
			this.m.Type = ::Const.SkillType.Trait;
			return;
		}

			//If fighting beasts, bro should gain the decap modifier on their ranged weapon attacks.
		local fightingBeasts = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (this.Const.EntityType.getDefaultFaction(enemy.getType()) == this.Const.FactionType.Beasts || enemy.getType() == this.Const.EntityType.BarbarianUnhold || enemy.getType() == this.Const.EntityType.BarbarianUnholdFrost)
			{
				fightingBeasts = true;
				break;
			}
		}

		if (fightingBeasts)
		{
			_properties.DamageRegularMult += 1.0 - _targetEntity.getHitpoints() / (_targetEntity.getHitpointsMax() * 1.0);
		}
		else //if no beasts present, just give +10% ranged damage
		{
			_properties.RangedDamageMult *= 1.10;
		}
	}

});
