app.controller('ImageSelectController', ['$rootScope', '$scope', '$modalInstance', 'MediaResource', function ($rootScope, $scope, $modalInstance, MediaResource) {
	MediaResource.get().$promise.then(function (data) {
		$scope.medias = data.medias;
	});

	$scope.modalOptions = {};

	$scope.modalOptions.ok = function () {
		if ($scope.selectedImage.id == null) {
			$scope.errors.display_no_image_selected = true;
			return;
		}

		$modalInstance.close($scope.selectedImage);
	};
	$scope.modalOptions.close = function () {
		$modalInstance.dismiss('cancel');
	};

	$scope.selectMedia = function(media) {
		$scope.selectedImage.id = media.id;
		$scope.selectedImage.src = media.image_medium_url;
		$scope.selectedImage.alt = media.title;
		$scope.selectedImage.title = media.title;
	};

	$scope.selectedImage = {
		'id': null,
		'src': null,
		'alt': '',
		'title': ''
	};
	$scope.errors = {
		'no_image_selected': true,
		'display_no_image_selected': false
	};
}]);
