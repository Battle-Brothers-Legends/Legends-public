::mods_hookExactClass("skills/actives/spearwall", function (o) {
	o.getDescription = @()"Prepare to immediately attack any opponent that attempts to close in.";

	o.getTooltip = function () {
		local tooltip = this.getDefaultUtilityTooltip();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Automatically executes an Attack of Opportunity against any enemy trying to enter the wielder's Zone of Control"
		});
		tooltip.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Targets hit are dealt [color=%negative%]50%[/color] of Prong's damage and pushed back into the previous tile"
		});
		if (this.getContainer().hasPerk(::Legends.Perk.LegendSpearwaller)) {
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%positive%]25%[/color] bonus damage on attacks made by Spearwall from [color=#008060]Spearwaller[/color]"
			});
		}
		if (this.getContainer().hasPerk(::Legends.Perk.LegendSpecialistMilitia)) {
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%positive%]15%[/color] bonus damage on attacks made by Spearwall from [color=#008060]Militia Practice[/color]"
			});
		}

		return tooltip;
	}

	o.onUse <- function (_user, _targetTile) {
		::Legends.Effects.grant(this, ::Legends.Effect.Spearwall, function (_skill) {
			if (this.m.Overlay.find("legend") != null) {
				_skill.m.Icon = "skills/" + this.m.Overlay + ".png";
				_skill.m.IconMini = this.m.Overlay + "_mini";
				_skill.m.Overlay = this.m.Overlay;
			}
		}.bindenv(this));

		if (!_user.isHiddenToPlayer()) {
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses Spearwall");
		}
		return true;
	}
});
