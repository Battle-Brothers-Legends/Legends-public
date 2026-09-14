::mods_hookExactClass("skills/actives/break_free_skill", function(o)
{
	o.m.DropNet <- false;
	o.m.IsReinforcedNet <- false;
	o.m.IsByNetSpecialist <- false;
	//Not used by the new net drop, flags are applied in actives.throw_net

	o.getTooltip = function ()
	{
		local tooltip = [
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
				icon = "ui/icons/melee_skill.png",
				text = "Has a [color=%positive%]" + this.getChance() + "%[/color] chance to succeed, based on Melee Skill. Each failed attempt will increase the chance to succeed for subsequent attempts."
			}
		];

		local actor = this.getContainer().getActor();
		local isBigGhoul = "getSize" in actor && actor.getSize() >= 2;
		if (actor.getCurrentProperties().IsSpecializedInNets)
		{
			tooltip.push({
				id = 5,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Net Mastery makes this significantly easier",
			});
		}

		if (actor.getSkills().hasPerk(::Legends.Perk.LegendEscapeArtist))
		{
			tooltip.push({
				id = 5,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Escape Artist makes this significantly easier",
			});
		}

		if (isBigGhoul)
		{
			tooltip.push({
				id = 5,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "The size of this character makes this significantly easier",
			});
		}

		return tooltip;
	}

	o.getChance = function ()
	{
		local actor = this.getContainer().getActor();
		local skill = this.m.SkillBonus == null ? actor.getCurrentProperties().getMeleeSkill() : this.m.SkillBonus;
		local toHit = this.Math.min(100, skill - 10 + this.m.ChanceBonus + (actor.getSkills().hasEffect(::Legends.Effect.GoblinShamanPotion) ? 100 : 0));
		local isBigGhoul = "getSize" in actor && actor.getSize() >= 2;
		if (actor.getCurrentProperties().IsSpecializedInNets || this.m.IsByNetSpecialist || actor.getSkills().hasPerk(::Legends.Perk.LegendEscapeArtist) || isBigGhoul)
		{
			toHit = this.Math.max(99, toHit);
		}
		return toHit;
	}

	o.onUse = function ( _user, _targetTile )
	{
		local toHit = this.getChance();
		local rolled = this.Math.rand(1, 100);
		this.Tactical.EventLog.log_newline();

		if (rolled <= toHit)
		{
			if (_user.getCurrentProperties().IsSpecializedInNets)
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + " effortlessly breaks free (Chance: " + toHit + ", Rolled: " + rolled + ")");
			}
			else
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + " breaks free (Chance: " + toHit + ", Rolled: " + rolled + ")");
			}

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _targetTile.Pos);
			}

			_user.getSprite("status_rooted").Visible = false;
			_user.getSprite("status_rooted_back").Visible = false;

			if (this.m.Decal != "")
			{
				local ourTile = this.getContainer().getActor().getTile();
				local candidates = [];

				if (ourTile.Properties.has("IsItemSpawned") || ourTile.IsCorpseSpawned)
				{
					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!ourTile.hasNextTile(i))
						{
						}
						else
						{
							local tile = ourTile.getNextTile(i);

							if (tile.IsEmpty && !tile.Properties.has("IsItemSpawned") && !tile.IsCorpseSpawned && tile.Level <= ourTile.Level + 1)
							{
								candidates.push(tile);
							}
						}
					}
				}
				else
				{
					candidates.push(ourTile);
				}

				if (candidates.len() != 0)
				{
					local tileToSpawnAt = candidates[this.Math.rand(0, candidates.len() - 1)];
					tileToSpawnAt.spawnDetail(this.m.Decal);
					tileToSpawnAt.Properties.add("IsItemSpawned");
				}
			}

			//DropNet Check
			if (_user.getFlags().get("DropNet")) { //Check if break free attempt comes from a net
				local net;
				if (_user.getFlags().get("IsReinforcedNet") && _user.getFlags().get("IsByNetCasting")){
					net = this.new("scripts/items/tools/reinforced_throwing_net");

					// 50% chance the reinforced net is still reusable in battle with netcasting
					if (::Math.rand(1,2) != 1){
						net.m.Ammo = 0;
						net.updateAmmo();
					}
				}
				else if (_user.getFlags().get("IsReinforcedNet")) { //Reinforced Net without NetCasting
					net = this.new("scripts/items/tools/reinforced_throwing_net");
					net.m.Ammo = 0;
					net.updateAmmo();
			    }
				else if (_user.getFlags().get("IsByNetCasting")) { //Normal Net w/ NetCasting
					net = this.new("scripts/items/tools/throwing_net");

					// 25% chance the net is still reusable in battle with netcasting
					if (::Math.rand(1,4) != 1){
						net.m.Ammo = 0;
						net.updateAmmo();
					}
				}
				else { //Normal Net without NetCasting
					net = this.new("scripts/items/tools/throwing_net");
					net.m.Ammo = 0;
					net.updateAmmo();
				}

				if (net != null){
					if (net.drop(this.getContainer().getActor().getTile())) {// drops the net on the tile
						::logDebug("Dropped net on this tile");
						::Tactical.Entities.addNetTiles(_targetTile);
					}
				}

				_user.getFlags().remove("DropNet");
   				_user.getFlags().remove("IsReinforcedNet");
    			_user.getFlags().remove("IsByNetCasting");
			}

			_user.setDirty(true);
			::Legends.Effects.remove(this, ::Legends.Effect.Net);
			::Legends.Effects.remove(this, ::Legends.Effect.Rooted);
			::Legends.Effects.remove(this, ::Legends.Effect.Web);
			::Legends.Effects.remove(this, ::Legends.Effect.KrakenEnsnare);
			::Legends.Effects.remove(this, ::Legends.Effect.SerpentEnsnare);
			this.removeSelf();
			return true;
		}
		else
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + " fails to break free (Chance: " + toHit + ", Rolled: " + rolled + ")");

			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, _targetTile.Pos);
			}

			this.m.ChanceBonus += 10;
			return false;
		}

		this.m.SkillBonus = null;
	}

	o.onUseByAlly <- function ( _ally, _targetTile )
	{
		this.setSkillBonus(_ally.getCurrentProperties().getMeleeSkill());
		if (_ally.getCurrentProperties().IsSpecializedInNets)
		{
			this.m.IsByNetSpecialist = true;
		}

		this.onUse(this.getContainer().getActor(), _targetTile);
	}

	o.onCombatFinished <- function ()
	{
		local actor = this.getContainer().getActor();
		if (actor.getSprite("status_rooted").getBrush() != null && actor.getSprite("status_rooted").getBrush().Name == "bust_web2")
			actor.getSprite("status_rooted").Visible = false;
		if (actor.getSprite("status_rooted_back").getBrush() != null && actor.getSprite("status_rooted_back").getBrush().Name == "bust_web2_back")
			actor.getSprite("status_rooted_back").Visible = false;
		this.skill.onCombatFinished();
	}
});
