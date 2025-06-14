::mods_hookExactClass("ambitions/ambitions/hammer_mastery_ambition", function(o)
{
	o.onPrepareVariables = function(_vars) {
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local not_candidates = [];

		// given how much avatars legends sometimes has, player check should be omited

		foreach (bro in brothers) {
			local p = bro.getCurrentProperties();
			if (p.IsSpecializedInHammers) {
				candidates.push(bro);
			} else {
				not_candidates.push(bro);
			}
		}

		if (candidates.len() == 0) {
			candidates = not_candidates;
		}

		if (not_candidates.len() == 0) {
			not_candidates.push(candidates.pop());
		}

		_vars.push([
			"hammerbrother",
			candidates[this.Math.rand(0, candidates.len() - 1)].getName()
		]);
		_vars.push([
			"nothammerbrother",
			not_candidates[this.Math.rand(0, not_candidates.len() - 1)].getName()
		]);
	}
});
