app.controller('MediasController', ['$rootScope', '$scope', 'MediaResource', 'eventTypeProvider', '$location', function ($rootScope, $scope, MediaResource, eventTypeProvider, $location) {
	console.log("controller :: MediasController");

	function loadMedias() {
		MediaResource.get().$promise.then(function (data) {
			$scope.medias = data.medias;
		});
	}

	function deleteMedia(id) {
		MediaResource.delete({
			id: id
		}).$promise.then(function () {
			loadMedias();
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		loadMedias();
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		loadMedias();
	});

	$scope.deleteMedia = deleteMedia;
	$scope.medias = [];

	loadMedias();
}]);
