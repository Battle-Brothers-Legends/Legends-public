this.legend_gravedigging_effect <- this.inherit("scripts/skills/skill", {
	m = {
		GraveStacks = 0
		},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendGravedigging);
		this.m.Icon = "ui/perks/shovel_01.png";
		// this.m.IconMini = "shovel_01_mini.png";
		this.m.Overlay = "shovel_01";
		this.m.Description = "This character gets unnaturally excited about dead bodies and will receive bonuses to Initiative, Resolve and Damage for every 2 corpses on the battlefield. Effect will be capped to 5 stacks for Two Handed Maces, which aren't shovels.";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
	}

	function getTooltip()
	{
		local bonus = this.getCorpses();
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
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+" + bonus + "[/color] Initiative"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%positive%]+" + bonus + "[/color] Damage"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + bonus + "[/color] Resolve"
			}
		];
	}

	function getCorpses()
	{

		if (!this.getContainer().getActor().isPlacedOnMap()) return 0;
		local count = 0;

		local size = this.Tactical.getMapSize();
		for ( local x = 0; x < size.X; x = ++x )
		{
			for( local y = 0; y < size.Y; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);
				if (tile.Properties.get("Corpse"))
					count += 1;
			}
		}

		return this.Math.floor(count / 2);
	}

	function isViableTile( _tile )
	{
		if (!this.MSU.Tile.canResurrectOnTile(_tile))
			return false;

		if (!_tile.IsEmpty)
			return false;

		return true;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getMainhandItem();

		if (item == null || !(item.isWeaponType(this.Const.Items.WeaponType.Mace) && item.isItemType(this.Const.Items.ItemType.TwoHanded)))
		{
			this.m.GraveStacks = 0;
			this.m.IsHidden = true;
			return;
		}
		this.m.GraveStacks = getCorpses();

		if (!(item.getID() == "weapon.legend_shovel" || item.getID() == "weapon.legend_named_shovel") && this.m.GraveStacks > 5)
		{
			this.m.GraveStacks = 5;
		}

		this.m.IsHidden = this.m.GraveStacks == 0;
		_properties.Initiative += this.m.GraveStacks;
		_properties.Bravery += this.m.GraveStacks;
		_properties.DamageRegularMin += this.m.GraveStacks;
		_properties.DamageRegularMax += this.m.GraveStacks;
	}

	function onCombatStarted()
	{
		this.m.GraveStacks = 0;
		this.skill.onCombatStarted();
	}

	function onCombatFinished()
	{
		this.m.GraveStacks = 0;
		this.skill.onCombatFinished();
	}
});
