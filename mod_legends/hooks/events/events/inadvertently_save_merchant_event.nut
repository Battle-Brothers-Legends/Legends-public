::mods_hookExactClass("events/events/inadvertently_save_merchant_event", function (o) {
	o.isValid <- function () {
		this.onClear();
		this.onUpdateScore();
		return this.m.Town != null;
	}
});
