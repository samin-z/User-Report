function form_data(wrapper){
    data = {};
    //name of the wrapper div is send to this function and using "form-control" the function loop through
    //all elements with this class and add their values and data-id as key and value to an array
    // the finall array is return to the function
    $(wrapper).find('.form-control').each(function(){
        data[$(this).data('id')] = $(this).val();
    });
    token = $('input[name=_token]').val();
    data._token = token;
    return data;
}


$(document).on('click' , '.submit-form' , function(){
    form = form_data('.user-form');
    var btn = $(this);

    // loadspiner function is in "global.js" file which disables the button
    loadspiner( btn);
    $.post( btn.data('route') , form , function(data){
        // unloadspiner function is in "global.js" file which set the button
        unloadspiner(btn);
        data = $.parseJSON(data);
        if(data.stat == 'ok')
        {
            ok('Successful! move to Next Stage!');
            document.location = data.url ;
        }
        else
            er(data.msg);
    });
});


$(document).on('click' , '.submit-report' , function(){
    form = form_data('.report-form');
    form.task_stack=[];

    $('.tasks-wrapper').find('.form-control').each(function(){
        form.task_stack.push($(this).val());
    });

    var btn = $(this);
    loadspiner( btn);
    $.post( btn.data('route') , csrf(form) , function(data){
        unloadspiner(btn);
        data = $.parseJSON(data);
        if(data.stat == 'ok')
        {
            ok('Report submitted successfully!');
            document.location = data.url ;
        }
        else
            er(data.msg);
    });
});