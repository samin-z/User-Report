
function csrf(obj){
    token = $('input[name=_token]').val();
    obj._token = token ;
    return obj;
}
$(document).on('click' , '.edit-item-btn' , function () {

    $(this).parents('.item-row:first').find('form').toggle();

})


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
function ok(msg){

    $('#loadingMoadl').find('.modal-body').html(prep_msg(msg));
    $('#loadingMoadl').modal('show');
}

function er(msg){
    $('#loadingMoadl').find('.modal-body').html(prep_msg(msg));
    $('#loadingMoadl').modal('show');
}





function delete_(id , table ){

    var ids = new Array();
    if( typeof(id) == 'undefined' || !$.isNumeric(id) )
    {
        $('.ids').each(function(index, element) {
            if(this.checked)
                ids.push($(this).val());
        });
    }
    else
    {
        ids.push(id);
    }

    if(ids.length == 0 )
    {
        alert('هیچ گزینه ای انتخاب نشده');
        return false;
    }
    var c = confirm('آیا از عملیات حذف اطمینان دارید ؟');
    if(!c) return false;

    var n= 0 ;
    for( n ; n < ids.length  ; n++ )
    {
        $('#'+table+'_item_'+ids[n]).find('.deleter').css('opacity' , '0.2');
    }

    $.post(base_url+'BaseController/delete' , {ids:ids , tbl:table} , function(){

        var n= 0 ;
        for( n ; n < ids.length  ; n++ )
        {
            console.log(ids[n]);
            $('#'+table+'_item_'+ids[n]).fadeOut().remove();
        }

    });
}



