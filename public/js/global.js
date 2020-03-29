$(document).on('click' , '.copy-to-clip' , function(){
    console.log($(this).parents('.copy-wrapper:first').find('.paset-to-clip').html());
    copyToClipboard($(this).parents('.copy-wrapper:first').find('.paset-to-clip')[0]);
})

/////////////here
function csrf(obj){
    token = $('input[name=_token]').val();
    obj._token = token ;
    return obj;
}
///////////hre
function prep_msg(msg) {

    if( $.isArray(msg) || $.isPlainObject(msg))
    {   console.log('it is !');
        var str = '';
        $.each( msg , function (k,v)
        {
            str += '<br />' + v ;
        })

        msg = str ;
    }

    return msg ;

}

/////////////here
function loadspiner(container){
    container.find('.spiner').show();
    container.find('.nospiner').hide();
    container.prop("disabled", true).addClass('disabled');

}

/////////////here
function unloadspiner(container) {
    container.find('.spiner').hide();
    container.find('.nospiner').show();
    container.prop("disabled", false).removeClass('disabled');


}

/////////////here
function ok(msg){

    $('#success-toast').find('.card-body').html(prep_msg(msg));
    $('#success-toast').fadeIn();
}

/////////////here
function er(msg){
    $('#error-toast').find('.card-body').html(prep_msg(msg));
    $('#error-toast').fadeIn();
}
function modal(msg){
    $('#master-modal').find('.modal-body').html(msg);
    $('#master-modal').modal('show');
}


$(document).on('click' , '.destroy-item-btn' , function () {

    var btn = $(this);
    var ids = new Array();

    var c = confirm(' are you sure?');
    if(!c) return false;


    if(btn.hasClass('destroy-item-all'))
    {
        $('.ids').each(function(){
            if(this.checked)
            {
                ids.push($(this).val());
                $(this).parents('.item-row:first').find('.destroy-item-btn').css('opacity' , '0.2');
            }

        })
    }
    else
        ids.push($(this).data('id'));

    if(ids.length < 1 )
    {
        er('No option was selected!');
        return false;
    }


    btn.css('opacity' , '0.2');



    $.post( btn.data('route') , csrf({ids:ids }) , function(data){

        data = $.parseJSON(data);
        if(data.stat == 'ok')
            if(btn.hasClass('destroy-item-all'))
            {
                btn.css('opacity' , '1');
                $('.ids').each(function(){
                    if(this.checked)
                    {
                        $(this).parents('.item-row:first').remove();
                    }
                })
            }
            else
                btn.parents('.item-row:first').remove();
        else
            alert(data.msg);

    });


})

/**************** numbers ****************/

$(document).on('keyup' , '.numeric' , function(){

    var num = $(this).val();

    $(this).val( number_format(num) );

});


function number_format(num){


    var nStr = num + '';
    nStr = nStr.replace( /\,/g, "");
    var x = nStr.split( '.' );
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while ( rgx.test(x1) ) {
        x1 = x1.replace( rgx, '$1' + ',' + '$2' );
    }

    return x1 + x2 ;


}

function number(n){
    return Number($.trim(n.replace(/\,/g,'')));
}

function copyToClipboard(elem) {
    // create hidden text element, if it doesn't already exist
    var targetId = "_hiddenCopyText_";
    var isInput = elem.tagName === "INPUT" || elem.tagName === "TEXTAREA";
    var origSelectionStart, origSelectionEnd;
    if (isInput) {
        // can just use the original source element for the selection and copy
        target = elem;
        origSelectionStart = elem.selectionStart;
        origSelectionEnd = elem.selectionEnd;
    } else {
        // must use a temporary form element for the selection and copy
        target = document.getElementById(targetId);
        if (!target) {
            var target = document.createElement("textarea");
            target.style.position = "absolute";
            target.style.left = "-9999px";
            target.style.top = "0";
            target.id = targetId;
            document.body.appendChild(target);
        }
        target.textContent = elem.textContent;
    }
    // select the content
    var currentFocus = document.activeElement;
    target.focus();
    target.setSelectionRange(0, target.value.length);

    // copy the selection
    var succeed;
    try {
        succeed = document.execCommand("copy");
    } catch (e) {
        succeed = false;
    }
    // restore original focus
    if (currentFocus && typeof currentFocus.focus === "function") {
        currentFocus.focus();
    }

    if (isInput) {
        // restore prior selection
        elem.setSelectionRange(origSelectionStart, origSelectionEnd);
    } else {
        // clear temporary content
        target.textContent = "";
    }
    return succeed;
}