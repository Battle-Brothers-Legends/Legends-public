this.legend_magic_circle_of_protection_skill <- this.inherit("scripts/skills/actives/legend_magic_skill", {
	m = {
		Range = 3,
		ProtectedActors = [],
		TurnsRemaining = 0,
		Tile = null
	},

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicCircleOfProtection);
		this.m.Description = "A magic circle that protects all allies within when cast. Leaving the circle breaks the protection.";
		this.m.KilledString = "Magic Circled";
		this.m.Icon = "skills/mage_legend_magic_circle_of_protection_square.png";
		this.m.IconDisabled = "skills/mage_legend_magic_circle_of_protection_square_bw.png";
		this.m.Overlay = "mage_legend_magic_circle_of_protection_square";
		this.m.SoundOnUse = [
			"sounds/humans/0/human_fatigue_01.wav"
		];
		this.m.SoundVolume = 1.25;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted + 1;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsVisibleTileNeeded = false;

		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 60;

		this.m.ResolveScaling = 10;
	}

	// Return the bonus to melee and ranged defense when
	// inside the circle.
	function getDefBonus()
	{
		return 5 + this.getResolveScaling();
	}

	// Return the bonus to resolve when inside the circle.
	function getResolveBonus()
	{
		local currentResolve = this.getContainer().getActor().getCurrentProperties().getBravery();
		return this.Math.round(currentResolve * 0.05);
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "All allies currently within range [color=%positive%]" + this.m.Range + "[/color] gain [color=%positive%]" + this.getDefBonus() + "[/color] melee/ranged defense and [color=%positive%]" + this.getResolveBonus() + "[/color] resolve for 2 turns or until they leave the circle."
		});
		return ret;
	}
	function tileInCircleRange(_targetTile)
	{
		if (this.m.Tile == null)
		{
			return false;
		}
		return _targetTile.getDistanceTo(this.m.Tile) <= this.m.Range;
	}

	// remove actor from ProtectedActors by id
	function removeActorById(_id)
	{
		local index = this.m.ProtectedActors.find(_id);
		if (index == null)
		{
			return;
		}
		local length = this.m.ProtectedActors.len();
		if (index == length - 1)
		{
			this.m.ProtectedActors.pop();
			return;
		}
		if (index == 0)
		{
			this.m.ProtectedActors = this.m.ProtectedActors.slice(1);
			return;
		}
		local front = this.m.ProtectedActors.slice(0, index);
		local back = this.m.ProtectedActors.slice(index+1);
		this.m.ProtectedActors = front.extend(back);
	}

	// Update the actors currently affected by the circle.
	function updateProtectedActors()
	{
		if (this.m.TurnsRemaining <= 0)
		{
			this.m.ProtectedActors.clear();
		}
	}

	// Start the effect
	function startEffect()
	{
		this.m.TurnsRemaining = 2;
		this.updateProtectedActors();

		local actor = this.getContainer().getActor();
		this.m.Tile = actor.getTile();
		local targets = this.Tactical.Entities.getAllInstances();

		foreach( tar in targets )
		{
			foreach( t in tar )
			{
				if (t.isAlliedWith(actor) && this.tileInCircleRange(t.getTile()) && !t.getSkills().hasEffect(::Legends.Effect.LegendMagicCircleOfProtectionEffect))
				{
					::Legends.Effects.grant(t, ::Legends.Effect.LegendMagicCircleOfProtectionEffect, function(_effect) {
						_effect.setCircle(this);
					}.bindenv(this));
					this.spawnIcon("perk_37", t.getTile());
				}
			}
		}
	}

	// End the effect
	function endEffect()
	{
		foreach(actor in this.m.ProtectedActors)
		{
			if (actor.getSkills().hasEffect(::Legends.Effect.LegendMagicCircleOfProtectionEffect))
			{
				::Legends.Effects.remove(actor, ::Legends.Effect.LegendMagicCircleOfProtectionEffect);
			}
		}
		this.m.TurnsRemaining = 0;
	}

	// on turn start decrement the remaining turns
	function onTurnStart()
	{
		if (this.m.TurnsRemaining > 0)
		{
			if (--this.m.TurnsRemaining <= 0)
			{
				this.endEffect();
			}
		}
	}

	// Can't use if there are turns remaining
	function isUsable()
	{
		return this.legend_magic_skill.isUsable() && (this.m.TurnsRemaining <= 0);
	}

	function onUse(_user, _targetTile)
	{
		this.startEffect();
	}

	function onCombatFinished()
	{
		this.endEffect();
	}

	function onDeath( _fatalityType )
	{
		this.endEffect();
	}

	function onMovementFinished()
	{
		local tile = this.getContainer().getActor().getTile();
		if (this.m.TurnsRemaining <= 0)
			return;

		if (!this.tileInCircleRange(tile))
		{
			this.endEffect();
		}
	}
});
