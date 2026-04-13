this.legend_bear_claws_skill <- this.inherit("scripts/skills/skill", {
	m = {
		SoundsA = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		],
		SoundsB = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		]
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendBearClaws);
		this.m.Description = "Tear into flesh across multiple opponents and leave them bleading with very long, sharp claws.";
		this.m.KilledString = "Ripped to shreds";
		this.m.Icon = "skills/active_21.png";
		this.m.IconDisabled = "skills/active_21_bw.png";
		this.m.Overlay = "active_21";
		this.m.SoundOnUse = [
			"sounds/enemies/ghoul_claws_01.wav",
			"sounds/enemies/ghoul_claws_02.wav",
			"sounds/enemies/ghoul_claws_03.wav",
			"sounds/enemies/ghoul_claws_04.wav",
			"sounds/enemies/ghoul_claws_05.wav",
			"sounds/enemies/ghoul_claws_06.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 6;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.ChanceDecapitate = 33;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
	local actor = this.getContainer().getActor();
		local p = actor.getCurrentProperties();
		local mult = p.MeleeDamageMult;
		local bodyHealth = actor.getHitpointsMax();
		local average = (actor.getInitiative() +  bodyHealth) / 4;
		local damageMin = 5;
		local damageMax = 10;
		local avgMin = average - 100;
		local avgMax = average - 90;

		if ((average - 100) > 0)
		{
			damageMin += avgMin;
		}

		if ((average - 90) > 0)
		{
			damageMax += avgMax;
		}

		if (this.getContainer().hasSkill("background.brawler") || this.getContainer().hasSkill("background.legend_commander_berserker") || this.getContainer().hasSkill("background.legend_berserker") )
		{
			damageMin = damageMin * 1.25;
			damageMax = damageMax * 1.25;
		}

		local damage_regular_min = this.Math.floor(damageMin * p.DamageRegularMult * p.DamageTotalMult);
		local damage_regular_max = this.Math.floor(damageMax * p.DamageRegularMult * p.DamageTotalMult);
		local damage_Armor_min = this.Math.floor(damageMin * p.DamageArmorMult * p.DamageTotalMult);
		local damage_Armor_max = this.Math.floor(damageMax * p.DamageArmorMult * p.DamageTotalMult);
		local damage_direct_max = this.Math.floor(damageMax * this.m.DirectDamageMult);

		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendMuscularity))
		{
			local muscularity = this.Math.floor(bodyHealth * 0.1);
			 damage_regular_max += muscularity;
			 damage_Armor_max += muscularity;
			 damage_direct_max += muscularity;
		}

		if (mult != 1.0)
		{
			damage_regular_min = this.Math.floor(damage_regular_min * mult);
			damage_regular_max = this.Math.floor(damage_regular_max * mult);
			damage_Armor_min = this.Math.floor(damage_Armor_min * mult);
			damage_Armor_max = this.Math.floor(damage_Armor_max * mult);
			damage_direct_max = this.Math.floor(damage_direct_max * mult);
		}

		local ret = [
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
			}
		];
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Inflicts damage based on hitpoints and initiative [color=%damage%]" + damage_regular_min + "[/color] - [color=%damage%]" + damage_regular_max + "[/color] damage, up to [color=%damage%]" + damage_direct_max + "[/color] damage can ignore armor"
		});

		if (damage_Armor_max > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=%damage%]" + damage_Armor_min + "[/color] - [color=%damage%]" + damage_Armor_max + "[/color] armor damage"
			});
		}

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=%negative%]-10%[/color] chance to hit"
		});

		return ret;
	}

	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return (mainhand == null || this.getContainer().hasEffect(::Legends.Effect.Disarmed)) && this.skill.isUsable();
	}

	function isHidden()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return mainhand != null && !this.getContainer().hasEffect(::Legends.Effect.Disarmed) || this.skill.isHidden() || this.m.Container.getActor().isStabled();
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectClaws);
		local ret = false;
		local myTile = _user.getTile();
		local target = _targetTile.getEntity();
		local d = myTile.getDistanceTo(_targetTile);
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());
		local result = {
			Tiles = [],
			MyTile = myTile,
			TargetTile = _targetTile,
			Num = 0
		};
		this.Tactical.queryTilesInRange(myTile, d, d, false, [], this.onQueryTilesHit, result);
		local tiles = [];


		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		for( local i = 0; i != result.Tiles.len(); i = ++i )
		{
			if (result.Tiles[i].ID == _targetTile.ID)
			{
				tiles.push(result.Tiles[i]);
				local idx = i - 1;

				if (idx < 0)
				{
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				idx = i - 2;

				if (idx < 0)
				{
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				break;
			}
		}

		foreach( t in tiles )
		{
			if (!t.IsVisibleForEntity)
			{
				continue;
			}

			if (this.Math.abs(t.Level - myTile.Level) > 1 || this.Math.abs(t.Level - _targetTile.Level) > 1)
			{
				continue;
			}

			if (!t.IsEmpty && t.getEntity().isAttackable())
			{
				ret = this.attackEntity(_user, t.getEntity()) || ret;
				if (!target.isAlive() || target.isDying())
				{
					if (target.getFlags().has("tail") || !target.getCurrentProperties().IsImmuneToBleeding)
					{
						this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
					}
					else
					{
						this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
					}
				}
				else if (!target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
				{
					::Legends.Effects.grant(target, ::Legends.Effect.Bleeding, function(_effect) {
						if (_user.getFaction() == this.Const.Faction.Player )
							_effect.setActor(this.getContainer().getActor());
						_effect.setDamage(5);
					}.bindenv(this));
					this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
				else
				{
					this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
			}

			if (!_user.isAlive() || _user.isDying())
			{
				break;
			}
		}

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			local bodyHealth = actor.getHitpointsMax();
			local average = (actor.getInitiative() +  bodyHealth) / 4;
			local damageMin = 5;
			local damageMax = 10;
			local avgMin = average - 100;
			local avgMax = average - 90;

			if ((average - 100) > 0)
			{
				damageMin += avgMin;
			}

			if ((average - 90) > 0)
			{
				damageMax += avgMax;
			}


			if (damageMin > 50)
			{
			local minMod = (damageMin - 50);
			local minFalloff = this.Math.pow(minMod, 0.5);
			damageMin = 50 + minFalloff;
			}

			if (damageMax > 50)
			{
			local maxMod = (damageMax - 50);
			local maxFalloff = this.Math.pow(maxMod, 0.5);
			damageMax = 50 + maxFalloff;
			}




			if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendMuscularity))
			{
				local muscularity = this.Math.floor(bodyHealth * 0.1);
				damageMax += muscularity;
			}

			if (this.getContainer().hasSkill("background.brawler") || this.getContainer().hasSkill("background.legend_commander_berserker" || this.getContainer().hasSkill("background.legend_berserker")) )
			{
				damageMin = damageMin * 1.25;
				damageMax = damageMax * 1.25;
			}
			_properties.DamageRegularMin += this.Math.floor(damageMin);
			_properties.DamageRegularMax += this.Math.floor(damageMax);
			_properties.MeleeSkill += _properties.IsSpecializedInFists ? 10 : -10;


			this.m.DirectDamageMult = _properties.IsSpecializedInFists ? 0.5 : 0.1;
		}
	}

	function onQueryTilesHit( _tile, _result )
	{
		_result.Tiles.push(_tile);
	}

	function onTargetSelected( _targetTile )
	{
		local myTile = this.m.Container.getActor().getTile();
		local d = myTile.getDistanceTo(_targetTile);
		local result = {
			Tiles = [],
			MyTile = myTile,
			TargetTile = _targetTile,
			Num = 0
		};
		this.Tactical.queryTilesInRange(myTile, d, d, false, [], this.onQueryTilesHit, result);
		local tiles = [];

		for( local i = 0; i != result.Tiles.len(); i = ++i )
		{
			if (result.Tiles[i].ID == _targetTile.ID)
			{
				tiles.push(result.Tiles[i]);
				local idx = i - 1;

				if (idx < 0)
				{
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				idx = i - 2;

				if (idx < 0)
				{
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				break;
			}
		}

		foreach( t in tiles )
		{
			if (!t.IsVisibleForEntity)
			{
				continue;
			}

			if (this.Math.abs(t.Level - myTile.Level) > 1 || this.Math.abs(t.Level - _targetTile.Level) > 1)
			{
				continue;
			}

			if (!t.IsEmpty && t.getEntity().isAttackable())
			{
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
			}
		}
	}

});

