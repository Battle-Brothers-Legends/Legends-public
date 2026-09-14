::mods_hookExactClass("ui/screens/tooltip/modules/tooltip", function (o) {
	o.m.OnQueryUIProfessionTooltipDataListener <- null;

	o.setOnQueryUIProfessionTooltipDataListener <- function (_listener) {
		this.m.OnQueryUIProfessionTooltipDataListener = _listener;
	}

	local clearEventListener = o.clearEventListener;
	o.clearEventListener = function() {
		clearEventListener();
		this.m.OnQueryUIProfessionTooltipDataListener = null;
	}

	o.onQueryUIProfessionTooltipData <- function (_data) {
		if (this.m.OnQueryUIProfessionTooltipDataListener != null) {
			return this.m.OnQueryUIProfessionTooltipDataListener(_data[0], _data[1]);
		}

		return null;
	}
});
