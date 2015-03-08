app.controller('EditMediaController', ['$location', '$scope', '$rootScope', 'ContentResource', '$routeParams', 'eventTypeProvider', function ($location, $scope, $rootScope, MediaResource, $routeParams, eventTypeProvider) {
	console.log("controller :: EditMediaController");
	var languageId = null;

	function loadMedia(id) {
		MediaResource.get({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: id}).$promise.then(function (data) {
			$scope.media = data.media;
			$scope.data = data.data;
		});
	}

	function saveContent() {
		$scope.media.language_id = $rootScope.currentMenu.language_id;
		if (languageId) {
			MediaResource.update({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, id: languageId, media: $scope.media}).$promise.then(onSaveSuccess, onSaveError);
		} else {
			MediaResource.save({siteId: $rootScope.currentSite.id, menuId: $rootScope.currentMenu.id, media: $scope.media}).$promise.then(onSaveSuccess, onSaveError);
		}
	}

	function onSaveSuccess() {
		$location.path('/medias');
	}

	function onSaveError(data) {
		console.log("errors", data);
		$scope.errors = data.data.errors;
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/medias');
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		$location.path('/medias');
	});

	$scope.saveContent = saveContent;
	$scope.media = {
		'title': ''
	};

	if ($routeParams.id) {
		languageId = $routeParams.id;
		loadMedia($routeParams.id);
	}
}]);
