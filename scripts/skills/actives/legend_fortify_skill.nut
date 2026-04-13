this.legend_fortify_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFortify);
		this.m.Description = "The shield is raised to a fortified stance until next turn.";
		this.m.Icon = "skills/fortify_square.png";
		this.m.IconDisabled = "skills/fortify_square_bw.png";
		this.m.Overlay = "active_15";
		this.m.SoundOnUse = [
			"sounds/combat/shieldwall_01.wav",
			"sounds/combat/shieldwall_02.wav",
			"sounds/combat/shieldwall_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 30;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local mult = 1.0;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		{
			mult = mult * 1.25;
		}

		local tooltip =  [
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Grants [color=%positive%]+" + this.Math.floor(item.getMeleeDefense() * mult + 5) + "[/color] Melee Defense for one turn"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "Grants [color=%positive%]+" + this.Math.floor(item.getRangedDefense() * mult + 5) + "[/color] Ranged Defense for one turn"
			}
		];

		return tooltip;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		if (this.getContainer().hasEffect(::Legends.Effect.LegendFortify))
		{
			return false;
		}
		if (this.getContainer().hasEffect(::Legends.Effect.LegendSafeguarding))
		{
			return false;
		}
		if (this.getContainer().hasEffect(::Legends.Effect.Shieldwall))
		{
			return false;
		}
		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onAfterUpdate( _properties )
	{

		this.m.FatigueCostMult = 1.0;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 3;
		}
	}

	function onUse( _user, _targetTile )
	{
		::Legends.Effects.grant(this, ::Legends.Effect.LegendFortify);

		if (!_user.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Fortify");
		}

		return true;
	}

	function onRemoved()
	{
		::Legends.Effects.remove(this, ::Legends.Effect.LegendFortify);
	}

});

