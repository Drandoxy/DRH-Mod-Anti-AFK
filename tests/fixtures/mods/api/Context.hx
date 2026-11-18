package mods.api;

class Context {
	public var core:Dynamic;
	public var state:Dynamic;

	public function new() {
		core = {facade: {mainStateMachine: {currentStateName: "RunState"}, menuNavigationController: {getTopUILayer: function() return ""}},
			overlay: new openfl.display.Sprite()};
		state = {floor: {}, inTown: false};
	}
}
