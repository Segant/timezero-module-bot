class asl.utils.Delegate extends Object {
	public static function create(object, func) : Function {
        var proxyFunction = function () {
            var _object = arguments.callee.object;
            var _func = arguments.callee.func;
            return (_func.apply(_object, arguments));
        };
        proxyFunction.object = object;
        proxyFunction.func = func;
        return proxyFunction;
    }
}