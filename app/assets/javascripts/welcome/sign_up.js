var signUpFormModule = angular.module('signUpForm', []);

/**
 * Sign Up Controller
 */
signUpFormModule
    .controller('signUpController', ['$scope', '$http', '$attrs', function ($scope, $http, $attrs) {

        /**
         * Validate all fields on sign up form
         *
         * @return boolean
         */
        $scope.formValid = function () {
            return $scope.emailValid && $scope.passwordValid && $scope.passwordConfirmationValid;
        };

        /**
         * Submit sign up form data
         *
         * @param user
         */
        $scope.submit = function (user) {
            $scope.disabled_submit = true;
            $scope.server_errors = {};

            $http({
                method  : $attrs.method,
                url     : $attrs.action,
                data    : { user: user }
            }).success(function(data) {
                if (data['success']) {
                    location.reload();
                } else {
                    $scope.server_errors = data['errors'];
                }

                $scope.disabled_submit = false;
            });
        };
    }])
    /**
     * Email field validator
     */
    .directive('validEmail', function () {
        return {
            require: 'ngModel',
            link: function (scope, elm, attrs, ctrl) {
                ctrl.$parsers.unshift(function (viewValue) {
                    var not_empty = viewValue !== '';
                    ctrl.$setValidity('not_empty', not_empty);

                    var email_address = !not_empty || /^[a-z]+[a-z0-9._]+@[a-z]+\.[a-z.]{2,5}$/.test(viewValue);
                    ctrl.$setValidity('email_address', email_address);

                    scope.emailValid = not_empty && email_address;

                    return scope.emailValid ? viewValue : false;
                });
            }
        }
    })
    /**
     * Password field validator
     */
    .directive('validPassword', function () {
        return {
            require: 'ngModel',
            link: function (scope, elm, attrs, ctrl) {
                ctrl.$parsers.unshift(function (viewValue) {
                    var not_empty = viewValue !== '';
                    ctrl.$setValidity('not_empty', not_empty);

                    var string_length = !not_empty || viewValue.length >= attrs.min && viewValue.length <= attrs.max;
                    ctrl.$setValidity('string_length', string_length);

                    scope.passwordValid = not_empty && string_length;

                    return scope.passwordValid ? viewValue : false;
                });
            }
        }
    })
    /**
     * Password confirmation field validator
     */
    .directive('validPasswordConfirmation', function () {
        return {
            require: 'ngModel',
            link: function (scope, elm, attrs, ctrl) {
                ctrl.$parsers.unshift(function (viewValue) {
                    var not_empty = viewValue !== '';
                    ctrl.$setValidity('not_empty', not_empty);

                    var string_length = !not_empty || viewValue.length >= attrs.min && viewValue.length <= attrs.max;
                    ctrl.$setValidity('string_length', string_length);

                    var not_match = !not_empty || viewValue === scope.sign_up_user['user[password]'].$viewValue;
                    ctrl.$setValidity('not_match', not_match);

                    scope.passwordConfirmationValid = not_empty && string_length && not_match;

                    return scope.passwordConfirmationValid ? viewValue : false;
                });
            }
        }
    });

/**
 * SignUpForm app initialize
 */
angular.element(document).ready(function() {
    angular.bootstrap(document.getElementById('signUpForm'), ['signUpForm']);
});