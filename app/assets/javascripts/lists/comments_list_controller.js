/**
 * Comments List Controller
 */
projectsList.controller('commentsListController', ['$scope', '$http', '$attrs', '$modal', '$mediator',
    function ($scope, $http, $attrs, $modal, $mediator) {
        $scope.comments = [];

        /**
         * Destroy comment by id
         *
         * @param id
        */
        $scope.destroy = function (id) {
            var modalInstance = $modal.open({
                templateUrl: 'destroy_confirm',
                controller: function($scope, $modalInstance) {
                    $scope.yes = function() {
                        $modalInstance.close();
                    };

                    $scope.no = function() {
                        $modalInstance.dismiss('cancel');
                    };
                }
            });

            modalInstance.result.then(function() {
                for (var key in $scope.comments) {
                    if (id === $scope.comments[key].id) {
                        $scope.comments.splice(key, 1);
                    }
                }

                $http.delete($attrs.commentsUrl + '/' + id);
            });
        };

        $mediator.$on('create_comment', function (event, data) {
            if (undefined == $scope.comments) {
                $scope.comments = [];
            }
            if (data.task.id == $scope.task.id) {
                $scope.comments.push(data.comment);
            }
        });
    }
]);