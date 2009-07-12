import walle.ObjectiveManager;

interface walle.Objective {
	public function onAdd(manager : ObjectiveManager) : Void;
	public function onResult(objective : Objective, result : Object) : Void;
	public function onTimer() : Void;
	public function onRemove() : Void;
};