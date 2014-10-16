app.controller('LanguageController', ['$rootScope', '$scope', 'LanguageResource', '$routeParams', 'eventTypeProvider', function ($rootScope, $scope, LanguageResource, $routeParams, eventTypeProvider) {
	console.log("controller :: LanguageController");

	function loadLanguage(id) {
		LanguageResource.get({id: id}).$promise.then(function (data) {
			$scope.language = data;
		});
	}

	loadLanguage($routeParams.id);
}]);
