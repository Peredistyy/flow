jQuery(document).ready(function() {

    /**
     * Sing Up form validator
     */
    jQuery('#sign_up_user').bootstrapValidator({
        framework: 'bootstrap',
        fields: {
            'user[email]': {
                validators: {
                    notEmpty: {
                        message: I18n.t('sing_up_form.error.attribute.email.not_empty')
                    },
                    emailAddress: {
                        message: I18n.t('sing_up_form.error.attribute.email.email_address')
                    }
                }
            },
            'user[password]': {
                validators: {
                    notEmpty: {
                        message: I18n.t('sing_up_form.error.attribute.password.not_empty')
                    },
                    stringLength: {
                        min: parseInt(jQuery('#sign_up_user').find("input[name='user[password]']").attr('length_min')),
                        max: parseInt(jQuery('#sign_up_user').find("input[name='user[password]']").attr('length_max')),
                        message: I18n.t('sing_up_form.error.attribute.password.string_length')
                    }
                }
            },
            'user[password_confirmation]': {
                validators: {
                    notEmpty: {
                        message: I18n.t('sing_up_form.error.attribute.password_confirmation.not_empty')
                    },
                    callback: {
                        message: I18n.t('sing_up_form.error.attribute.password_confirmation.not_match'),
                        callback: function (value) {
                            return value == jQuery('#sign_up_user').find("input[name='user[password]']").val();
                        }
                    },
                    stringLength: {
                        min: parseInt(jQuery('#sign_up_user').find("input[name='user[password_confirmation]']").attr('length_min')),
                        max: parseInt(jQuery('#sign_up_user').find("input[name='user[password_confirmation]']").attr('length_max')),
                        message: I18n.t('sing_up_form.error.attribute.password_confirmation.string_length')
                    }
                }
            }
        }
    });

    /**
     * Sing In form validator
     */
    jQuery('#sign_in_user').bootstrapValidator({
        framework: 'bootstrap',
        fields: {
            'user[email]': {
                validators: {
                    notEmpty: {
                        message: I18n.t('sing_up_form.error.attribute.email.not_empty')
                    },
                    emailAddress: {
                        message: I18n.t('sing_up_form.error.attribute.email.email_address')
                    }
                }
            },
            'user[password]': {
                validators: {
                    notEmpty: {
                        message: I18n.t('sing_up_form.error.attribute.password.not_empty')
                    },
                    stringLength: {
                        min: parseInt(jQuery('#sign_in_user').find("input[name='user[password]']").attr('length_min')),
                        max: parseInt(jQuery('#sign_in_user').find("input[name='user[password]']").attr('length_max')),
                        message: I18n.t('sing_up_form.error.attribute.password.string_length')
                    }
                }
            }
        }
    });

});