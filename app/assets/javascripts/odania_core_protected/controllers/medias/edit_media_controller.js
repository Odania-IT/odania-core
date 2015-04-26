app.controller('EditMediaController', ['$location', '$scope', '$rootScope', 'MediaResource', '$routeParams', 'eventTypeProvider', '$http', function ($location, $scope, $rootScope, MediaResource, $routeParams, eventTypeProvider, $http) {
	console.log("controller :: EditMediaController");
	var mediaId = null;

	function loadMedia(id) {
		MediaResource.get({id: id}).$promise.then(function (data) {
			$scope.media = data.media;
		});
	}

	function saveMedia() {
		$scope.media.language_id = $rootScope.currentSite.default_language_id;

		// Create upload
		var fd = new FormData(),
			uploadUrl = config.getApiPath('medias'+(mediaId == null ? '' : '/'+mediaId)),
			method = (mediaId == null ? 'post' : 'put');

		if ($scope.upload.file) {
			fd.append('media[image]', $scope.upload.file);
		}

		angular.forEach($scope.media, function(value, key) {
			fd.append('media['+key+']', value);
		});

		$http[method](uploadUrl, fd, {
			transformRequest: angular.identity,
			headers: {'Content-Type': undefined}
		}).success(function () {
			$location.path('/medias');
		}).error(function (data) {
			$scope.errors = data.errors;
		});
	}

	$rootScope.$on(eventTypeProvider.INTERNAL_SITE_CHANGED, function processEvent() {
		$location.path('/medias');
	});

	$rootScope.$on(eventTypeProvider.INTERNAL_MENU_CHANGED, function processEvent() {
		$location.path('/medias');
	});

	/**
	 * File handling
	 */
	$scope.setFile = function (element) {
		$scope.$apply(function() {
			$scope.upload.file = element.files[0];
		});
	};
	// End file handling

	$scope.saveMedia = saveMedia;
	$scope.media = {
		'title': '',
		'is_global': false
	};
	$scope.upload = {
		'file': null
	};

	if ($routeParams.id) {
		mediaId = $routeParams.id;
		loadMedia($routeParams.id);
	}
}]);
