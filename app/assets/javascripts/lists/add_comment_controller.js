/**
 * Comments List Controller
 */
projectsList.controller('addCommentController', ['$scope', '$http', '$attrs', '$mediator', '$upload',
    function ($scope, $http, $attrs, $mediator, $upload) {
        $scope.$watch('attach');

        /**
         * Submit form data
         *
         * @param comment
         * @param task
         */
        $scope.submit = function (comment, task) {
            comment.error = undefined == comment.message || '' === comment.message;

            if (!comment.error) {
                $scope.disabled_submit = true;

                $upload.upload({
                    url: $attrs.action,
                    data: { comment: comment, task: task },
                    file: $scope.attach,
                    fileFormDataName: 'comment[attach]',
                    formDataAppender: function(fields, key, models) {
                        angular.forEach(models, function (model, model_name) {
                            angular.forEach(model, function (value, key) {
                                fields.append(model_name + '[' + key + ']', value);
                            });
                        });
                    }
                }).success(function (data) {
                    if (data['success']) {
                        comment.message = '';
                        comment.attach = '';
                        $mediator.$emit('create_comment', data['comment']);
                    } else {
                        comment.error = true;
                    }

                    $scope.disabled_submit = false;
                });
            }
        }
    }
]);