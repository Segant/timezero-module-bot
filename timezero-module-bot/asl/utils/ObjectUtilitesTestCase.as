UnitTest.context = "property checks";
		UnitTest.assert(hasProperty(_global, "Key") == true);
		UnitTest.assert(isPropertyChangeable(_global, "Key") == true);
		UnitTest.assert(isPropertyDeleteable(_global, "Key") == true);
		UnitTest.assert(isPropertyEnumerable(_global, "Key") == false);
		UnitTest.assert(hasProperty(_global, "Key") == true);
		
		UnitTest.assert(hasProperty(ObjectUtilites, "notExistingProp") == false);
		UnitTest.assert(isPropertyChangeable(ObjectUtilites, "notExistingProp") == false);
		UnitTest.assert(isPropertyDeleteable(ObjectUtilites, "notExistingProp") == false);
		UnitTest.assert(isPropertyEnumerable(ObjectUtilites, "notExistingProp") == false);
		UnitTest.assert(hasProperty(ObjectUtilites, "notExistingProp") == false);
		
		UnitTest.assert(hasProperty(Key, "CONTROL") == true);
		UnitTest.assert(isPropertyChangeable(Key, "CONTROL") == false);
		UnitTest.assert(isPropertyDeleteable(Key, "CONTROL") == false);
		UnitTest.assert(isPropertyEnumerable(Key, "CONTROL") == false);
		UnitTest.assert(hasProperty(Key, "CONTROL") == true);