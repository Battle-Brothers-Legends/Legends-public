this.legend_oms_amphora_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendOmsAmphora);
		this.m.Description = "Drink from the Amphora. You can\'t be sure what this might do...";
		this.m.Icon = "skills/amphora_active.png";
		this.m.IconDisabled = "skills/amphora_active_bw.png";
		this.m.Overlay = "amphora_active.png";
		this.m.SoundOnUse = [
			"sounds/combat/drink_01.wav",
			"sounds/combat/drink_02.wav",
			"sounds/combat/drink_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = true;
		this.m.IsAttack = false;
		this.m.IsUsingHitchance = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 5;
		this.m.MinRange = 0;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local result = [
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
		}];
		if (!this.World.Flags.get("Item Identified"))
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "You aren\'t sure what it does. You\'ve heard of an ancient witch living in a hut in the forest who might know more about this"
			});
			return result;
		}
		else
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Drinking in battle provides a random status effect. May be harmful or helpful. Refills after every battle"
			});
			return result;
		}
	}

	function isUsable()
	{
		local tile = this.getContainer().getActor().getTile();
		return this.skill.isUsable() && !this.getItem().isConsumed() && !tile.hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function getCursorForTile( _tile )
	{
		if (_tile.ID == this.getContainer().getActor().getTile().ID) return this.Const.UI.Cursor.Drink;
		else return this.Const.UI.Cursor.Give;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;
		local target = _targetTile.getEntity();
		if (!this.m.Container.getActor().isAlliedWith(target)) return false;
		return true;
	}

	function onUse( _user, _targetTile )
	{
		local user = _targetTile.getEntity();

		if (_user.getID() == user.getID())
		{
			if (!user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " drinks from Amphora");
			}
		}
		else
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " lets " + this.Const.UI.getColorizedEntityName(user) + " drink from Amphora");
			}
		}

		local effects = ::MSU.Class.WeightedContainer([
			[0.5, ::Legends.Effect.ImmuneToPoison],
			[0.5, ::Legends.Effect.Bleeding],
			[0.5, ::Legends.Effect.LegendBeerBuzzEffect],
			[0.5, ::Legends.Effect.LegendMeadWarmthEffect],
			[0.5, ::Legends.Effect.LegendWineTipsyEffect],

			[0.4, ::Legends.Effect.CatPotion],
			[0.4, ::Legends.Effect.LionheartPotion],
			[0.4, ::Legends.Effect.LegendDazed],

			[0.3, ::Legends.Effect.RecoveryPotion],
			[0.3, ::Legends.Effect.Chilled],
			[0.3, ::Legends.Effect.GoblinPoison],

			[0.2, ::Legends.Effect.SpiderPoison],
			[0.2, ::Legends.Effect.LegendRedbackSpiderPoison],
			[0.2, ::Legends.Effect.IronWill],

			[0.1, ::Legends.Effect.LegendGreenwoodSap]
		]);
		::Legends.Effects.grant(_user, effects.roll());
		this.getItem().setConsumed(true);
	}
});
