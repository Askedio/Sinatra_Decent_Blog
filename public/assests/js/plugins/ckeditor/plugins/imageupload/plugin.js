/**
 * Copyright (c) 2015, Asked.io - William Bowman. All rights reserved.
 * Licensed under the terms of the MIT License (see LICENSE.md).
 *
 * Based on sample plugin inserting current date and time into the CKEditor editing area.
 *
 * Created out of the CKEditor Plugin SDK:
 * http://docs.ckeditor.com/#!/guide/plugin_sdk_intro
 */
var action = '/admin/create/upload';
var field  = 'upload';

CKEDITOR.plugins.add( 'imageupload', {
    icons: 'imageupload',
    init: function( editor ) {
        editor.addCommand( 'imageupload', {
            exec: function( editor ) {
                $('body').append('<div id="upload_container_ck"><iframe name="upload_frame_ck" id="upload_frame_ck" style="display:none"></iframe><form method="post" action="'+action+'" target="upload_frame_ck" id="upload_form_ck" enctype="multipart/form-data"><input type="file" name="'+field+'" id="upload_file_ck" style="display:none"></form></div>');

                $('#upload_file_ck').trigger('click');

                $('#upload_file_ck').change(function (e) {
                  $('#upload_form_ck').submit()
                });

                $('#upload_form_ck').on('submit',function(){
                  $('#upload_frame_ck').on('load', function(){
                    var image=$('#upload_frame_ck').contents().find('body').html();
                    editor.insertHtml( '<img src="' + image + '">' );
                    $('#upload_container_ck').remove();
                  });
                });
            }
        });

        editor.ui.addButton( 'Imageupload', {
            label: 'Image Upload',
            command: 'imageupload',
            toolbar: 'insert'
        });
    }
});