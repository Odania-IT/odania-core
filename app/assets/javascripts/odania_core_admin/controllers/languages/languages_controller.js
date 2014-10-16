app.controller('LanguagesController', ['$rootScope', '$scope', 'LanguageResource', function ($rootScope, $scope, LanguageResource) {
	console.log("controller :: LanguagesController");

	function loadLanguages() {
		LanguageResource.get().$promise.then(function (data) {
			$rootScope.languages = data.languages;
		});
	}

	function deleteLanguage(id) {
		LanguageResource.delete({id: id}).$promise.then(function () {
			loadLanguages();
		});
	}

	$scope.deleteLanguage = deleteLanguage;

	loadLanguages();
}]);
