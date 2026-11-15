::mods_hookExactClass("skills/actives/break_free_skill", function (o) {
	o.m.IsReinforcedNet <- false;
	//Not used by the new net drop, flags are applied in actives.throw_net

	o.getTooltip = function () {
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
		if (::Legends.Perks.has(actor, ::Legends.Perk.LegendFreedomOfMovement)) {
			tooltip.push({
				id = 5,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Freedom of Movement makes this significantly easier",
			});
		}

		if (actor.getSkills().hasPerk(::Legends.Perk.LegendEscapeArtist)) {
			tooltip.push({
				id = 5,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Escape Artist makes this significantly easier",
			});
		}

		if (isBigGhoul) {
			tooltip.push({
				id = 5,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "The size of this character makes this significantly easier",
			});
		}

		return tooltip;
	}

	o.getChance = function () {
		local actor = this.getContainer().getActor();
		local skill = this.m.SkillBonus == null ? actor.getCurrentProperties().getMeleeSkill() : this.m.SkillBonus;
		local toHit = ::Math.min(100, skill - 10 + this.m.ChanceBonus + (actor.getSkills().hasEffect(::Legends.Effect.GoblinShamanPotion) ? 100 : 0));
		local isBigGhoul = "getSize" in actor && actor.getSize() >= 2;
		if (::Legends.Array.any([::Legends.Perk.LegendFreedomOfMovement, ::Legends.Perk.LegendEscapeArtist], @(_def) ::Legends.Perks.has(actor, _def)) || isBigGhoul) {
			toHit = ::Math.max(99, toHit);
		}
		return toHit;
	}

	o.onUse = function (_user, _targetTile) {
		local toHit = this.getChance();
		local rolled = ::Math.rand(1, 100);
		::Tactical.EventLog.log_newline();

		if (rolled <= toHit) {
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + (::Legends.Perks.has(_user, ::Legends.Perk.LegendFreedomOfMovement) ? " effortlessly" : "") + " breaks free (Chance: " + toHit + ", Rolled: " + rolled + ")");

			if (this.m.SoundOnHit.len() != 0) {
				::Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, _targetTile.Pos);
			}

			_user.getSprite("status_rooted").Visible = false;
			_user.getSprite("status_rooted_back").Visible = false;

			if (this.m.Decal != "") {
				local ourTile = this.getContainer().getActor().getTile();
				local candidates = [];

				if (ourTile.Properties.has("IsItemSpawned") || ourTile.IsCorpseSpawned) {
					for (local i = 0; i < ::Const.Direction.COUNT; i = ++i) {
						if (!ourTile.hasNextTile(i)) {
						} else {
							local tile = ourTile.getNextTile(i);

							if (tile.IsEmpty && !tile.Properties.has("IsItemSpawned") && !tile.IsCorpseSpawned && tile.Level <= ourTile.Level + 1) {
								candidates.push(tile);
							}
						}
					}
				} else {
					candidates.push(ourTile);
				}

				if (candidates.len() != 0) {
					local tileToSpawnAt = candidates[::Math.rand(0, candidates.len() - 1)];
					tileToSpawnAt.spawnDetail(this.m.Decal);
					tileToSpawnAt.Properties.add("IsItemSpawned");
				}
			}

			_user.setDirty(true);
			::Legends.Effects.remove(this, ::Legends.Effect.Net);
			::Legends.Effects.remove(this, ::Legends.Effect.Rooted);
			::Legends.Effects.remove(this, ::Legends.Effect.Web);
			::Legends.Effects.remove(this, ::Legends.Effect.KrakenEnsnare);
			::Legends.Effects.remove(this, ::Legends.Effect.SerpentEnsnare);
			this.removeSelf();
			return true;
		} else {
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + " fails to break free (Chance: " + toHit + ", Rolled: " + rolled + ")");

			if (this.m.SoundOnMiss.len() != 0) {
				::Sound.play(this.m.SoundOnMiss[::Math.rand(0, this.m.SoundOnMiss.len() - 1)], ::Const.Sound.Volume.Skill, _targetTile.Pos);
			}

			this.m.ChanceBonus += 10;
			return false;
		}

		this.m.SkillBonus = null;
	}

	o.onUseByAlly <- function (_ally, _targetTile) {
		this.setSkillBonus(_ally.getCurrentProperties().getMeleeSkill());

		this.onUse(this.getContainer().getActor(), _targetTile);
	}

	o.onCombatFinished <- function () {
		local actor = this.getContainer().getActor();
		if (actor.getSprite("status_rooted").getBrush() != null && actor.getSprite("status_rooted").getBrush().Name == "bust_web2") {
			actor.getSprite("status_rooted").Visible = false;
		}
		if (actor.getSprite("status_rooted_back").getBrush() != null && actor.getSprite("status_rooted_back").getBrush().Name == "bust_web2_back") {
			actor.getSprite("status_rooted_back").Visible = false;
		}
		this.skill.onCombatFinished();
	}
});
