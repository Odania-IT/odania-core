app.factory('localStorageService', ['$rootScope', function ($rootScope) {
	function getObject(name) {
		angular.fromJson(localStorage[name]);
	}

	function saveObject(name, value) {
		localStorage[name] = angular.toJson(value);
	}

	return {
		'get': getObject,
		'set': saveObject
	};
}]);
