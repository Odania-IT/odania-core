app.controller('EditContentController', ['$location', '$scope', '$rootScope', 'ContentResource', '$routeParams', 'eventTypeProvider', function ($location, $scope, $rootScope, ContentResource, $routeParams, eventTypeProvider) {
	console.log("controller :: EditContentController");
	var languageId = null;

	function loadContent(id) {
		ContentResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function (data) {
			$scope.content = data.content;
			$scope.data = data.data;
		});
	}

	function saveContent() {
		$scope.content.language_id = $rootScope.currentMenu.language_id;
		if (languageId) {
			ContentResource.update({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: languageId, content: $scope.content}).$promise.then(onSaveSuccess, onSaveError);
		} else {
			ContentResource.save({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, content: $scope.content}).$promise.then(onSaveSuccess, onSaveError);
		}
	}

	function onSaveSuccess() {
		$location.path('/contents');
	}

	function onSaveError(data) {
		console.log("errors", data);
		$scope.errors = data.data.errors;
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/contents');
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		$location.path('/contents');
	});

	$scope.saveContent = saveContent;
	$scope.content = {
		'title': ''
	};

	if ($routeParams.id) {
		languageId = $routeParams.id;
		loadContent($routeParams.id);
	}
}]);
