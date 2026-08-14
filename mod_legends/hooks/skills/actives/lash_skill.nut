::mods_hookExactClass("skills/actives/lash_skill", function (o) {
	o.getTooltip = function () {
		return this.getDefaultTooltip();
	}
});
