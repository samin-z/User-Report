
function csrf(obj){
    token = $('input[name=_token]').val();
    obj._token = token ;
    return obj;
}
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

function loadspiner(container){
    container.find('.spiner').show();
    container.find('.nospiner').hide();
    container.prop("disabled", true).addClass('disabled');

}

function unloadspiner(container) {
    container.find('.spiner').hide();
    container.find('.nospiner').show();
    container.prop("disabled", false).removeClass('disabled');


}

function ok(msg){

    $('#success-toast').find('.card-body').html(prep_msg(msg));
    $('#success-toast').fadeIn();
}

function er(msg){
    $('#error-toast').find('.card-body').html(prep_msg(msg));
    $('#error-toast').fadeIn();
}
function modal(msg){
    $('#master-modal').find('.modal-body').html(msg);
    $('#master-modal').modal('show');
}
