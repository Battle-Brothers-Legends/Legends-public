::mods_hookExactClass("skills/traits/teamplayer_trait", function(o)
{
	o.m.IsBonusActive <- false;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "This character makes sure to always announce their intentions to his brothers-in-arms. In fact, they\'ll never shut the hell up. At least it reduces the chance of accidents happening and they feel better when near brothers.";
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued)
		]);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=%skill%]Knock Back[/color], [color=%skill%]Repel[/color] and [color=%skill%]Hook[/color] skills have [color=%positive%]100%[/color] chance to hit when targeting an allied character and will not apply negative effects or damage when used on an ally"
		});

		if (this.m.IsBonusActive) {
			ret.extend([
				{
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=%positive%]+5%[/color] Melee Skill"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=%positive%]+5%[/color] Ranged Skill"
				}
			]);
		}
		else {
			ret.extend([
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Melee Skill and Ranged Skill increased when fighting next to an ally"
				}
			])
		}

		return ret;
	}

	o.onUpdate <- function ( _properties ) {
		if (!this.getContainer().getActor().isPlacedOnMap()) {
			this.m.IsBonusActive = false;
			this.m.Type = ::Const.SkillType.Trait;
			return;
		}

		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local isSupported = false;

		foreach( ally in allies ) {
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap()) {
				continue;
			}

			if (ally.getTile().getDistanceTo(myTile) <= 2) {
				isSupported = true;
				break;
			}
		}

		if (isSupported) {
			this.m.IsBonusActive = true;
			this.m.Type = ::Const.SkillType.StatusEffect;
			_properties.MeleeSkillMult *= 1.05;
			_properties.RangedSkillMult *= 1.05;
		} else {
			this.m.IsBonusActive = false;
			this.m.Type = ::Const.SkillType.Trait;
		}
	}
});
