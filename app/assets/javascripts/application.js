// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
$(function () {
    $('.add_item_bt').click(function () {
        $('.frm_add_item').show();
        $(this).hide();
        $('.cancel_add_item_bt').show();
    });
    $('.cancel_add_item_bt').click(function () {
        $('.frm_add_item').hide();
        $('.add_item_bt').show();
        $(this).hide();
    });
    $('#ecryption-method').mouseover(function () {
        $('#encryption-method-description').show();
    });

//    $('.bt-plan').click(function () {
//        var current_plan = $('#plan').val();
//        var plan = $(this).data('value');
//        if (plan == "free")
//            $('.billing-profile-fields').hide();
//        else
//            $('.billing-profile-fields').show();
//        $('#plan-' + current_plan).removeClass('btn-primary');
//        $('#plan').val(plan);
//        $(this).addClass('btn-primary');
//    });
    $('#create_new_recipient_bt').click(function () {
        $('#frm_create_recipient').show();
        $('#choose-recipient-combox').hide();
        $('#using_exist_address').val(false);
        $(this).hide();
        $('#cancel_create_new_recipient_bt').show();
    });
    $('#cancel_create_new_recipient_bt').click(function () {
        $('#frm_create_recipient').hide();
        $('#using_exist_address').val(true);
        $('#create_new_recipient_bt').show();
        $('#choose-recipient-combox').show();
        $(this).hide();
    });

});
