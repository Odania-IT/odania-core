app.controller('EditLanguageController', ['$location', '$scope', 'LanguageResource', '$routeParams', 'eventTypeProvider', function ($location, $scope, LanguageResource, $routeParams, eventTypeProvider) {
	console.log("controller :: EditLanguageController");
	var languageId = null;

	function loadLanguage(id) {
		LanguageResource.get({id: id}).$promise.then(function (data) {
			$scope.language = data;
		});
	}

	function saveLanguage() {
		if (languageId) {
			LanguageResource.update({id: languageId, language: $scope.language}).$promise.then(onSaveSuccess, onSaveError);
		} else {
			LanguageResource.save({language: $scope.language}).$promise.then(onSaveSuccess, onSaveError);
		}
	}

	function onSaveSuccess() {
		$location.path('/languages');
	}

	function onSaveError(data) {
		console.log("errors", data);
		$scope.errors = data.data.errors;
	}

	$scope.saveLanguage = saveLanguage;
	$scope.language = {
		'name': ''
	};

	if ($routeParams.id) {
		languageId = $routeParams.id;
		loadLanguage($routeParams.id);
	}
}]);
