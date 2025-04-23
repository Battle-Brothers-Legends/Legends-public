// simple implementation of LCG (linear congruential generator)
::Legends.LCG <- {
	State = null,
	get = function (_state) {
		local generator = clone ::Legends.LCG;
		generator.State = _state;
		return generator;
	}
	getState = function () {
		return this.State;
	}
	nextState = function () {
		this.State = (1664525 * this.State + 1013904223) % 2147483648;
		return this.State;
	}
}
