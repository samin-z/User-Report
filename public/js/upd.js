var config_object = {
		loader : '<div class="preview">'+
                                '<i class="file-icon glyphicon glyphicon-circle-arrow-up pull-right"></i>'+
                                   '<div class="progress">'+
'<div class="progress-bar progress-bar-striped progress-bar-danger active" role="progressbar" aria-valuenow="70"'+
                                 ' aria-valuemin="0" aria-valuemax="100" style="width:0%">0%</div>'+
                               ' </div>'+
                               '<br style="clear:both" /></div>',
		error:function(data){
			console.log(' ther was an error ');
		} ,
    };
	
var uploader_app = uploader_app || {} ;
var upload_object = {};

		$(document).on( "change" , ".standard-upload-files" ,  function(event) {
			
			event.preventDefault();  
			var standardUploadFiles = $(this).prop('files');
			
			var config = {
				   backend : $(this).parents('.file-drop-zone:first').attr('data-backend') ,
				  uploaderid  : $(this).parents('.file-drop-zone:first').attr('data-uploaderid') ,
				  progressBar :  $(this).parents('.upload-wrapper:first').find('.file-upload-preview') , 
				  maxup       : $(this).parents('.file-drop-zone:first').attr('data-mu')
				};
				console.log(config);

			upload_file( standardUploadFiles ,config  );
		});
	
$(document).ready(function(e) {
 
		
 		$(document).on( "dragover" , ".file-drop-zone" ,  function(event) {
			event.preventDefault();  
			event.stopPropagation();
		    $(this).addClass('file-hovered-zone');
		});
		
 		$(document).on( "dragleave" , ".file-drop-zone" ,  function(event) {
			event.preventDefault();  
			event.stopPropagation();
			$(this).removeClass('file-hovered-zone');
		});
		
  		$(document).on( "drop" , ".file-drop-zone" ,  function(event) {
			event.preventDefault();  
			event.stopPropagation();
            $(this).removeClass('file-hovered-zone');

			var config = {
				   backend : $(this).attr('data-backend') ,
				  uploaderid  : $(this).attr('data-uploaderid') ,
				  progressBar :  $(this).parents('.upload-wrapper:first').find('.file-upload-preview') , 
				  maxup       : $(this).attr('data-mu')
				};
			
			upload_file(event.originalEvent.dataTransfer.files , config );
		});
		
$(document).on('click' , '.delete-upload' , function(data){
	
	 
	 var code =  $(this).attr('data-id');
	 var type =  $(this).attr('data-type');
	 var p    = $(this).parents('.preview:first');
	 
	 console.log( code +' --- >  '+type );
	 
	 if(p.hasClass('inprog'))
	  return false;
	  
	  $(this).fadeOut();
	      
	       type =  typeof(type) == 'undefined'  ? false :  type ;
		  
		  console.log(type);
		
		  var new_upload_oobject = {} ;
		  $.each(upload_object , function(i,arr)
		  {

			  var index = $.inArray(code, arr);
			  if(index > - 1 )
			  {
			     arr.splice(index, 1);
				 type = i ;
			  }
			  new_upload_oobject[i] = arr ;
			  
		  });
		  
		  upload_object = new_upload_oobject;
	
	  if(!type)  { p.remove(); return false; }
	 
	  p.addClass('inprog');
	  $.post( $(this).parents('.file-drop-zone:first').data('backend')+'/dropfile/'+type , { code:code  , _token:$('input[name=_token]').val()} , function(data){
          
		  
		  
		  p.remove();

		  
	  });
	 
	 

});

});

function upload_file(files , config ){
	config_object.files = files ;
	jQuery.extend(config_object, config);
	uploader_app.uploader(config_object);
}
		
		
		
(function(o){
	
	var ajax , getFormData , setProgress ;
	
	ajax = function(data){
		
		var _token = $('input[name=_token]').val();
		 
		 
		o.options.progressBar.append(o.options.loader);
	   
	   var pwraper = o.options.progressBar.find('.preview:last');
	   var pbar        = pwraper.find('.progress-bar') ;
		
		var xhr = new XMLHttpRequest();
		
		xhr.addEventListener('readystatechange' , function(){
			if(this.readyState === 4 )
			{
				if(this.status === 200 )
				{
					var data = $.parseJSON(this.response);
					if(data.stat == 'ok')
					{
						   
						 pwraper.html(
						 
                                        '<div class="col-md-2">'+
                                        ' <a data-id="'+data.code+'"  data-type="ad"  class="delete-upload">'+
                                        '<i class="glyphicon glyphicon-remove"></i> </a>'+
                                        ' </div>       '+                                 
                                       ' <div class="col-md-8" style="text-align:right">'+
                                      '  <span class="attach-title"> '+data.file_name+'</span>'+
                                      '  <br  style="margin:4px 0px ; clear:both"/>'+
                                       ' '+data.size+' کیلوبایت '+
                                       '  </div><div class="col-md-2"><img src="'+data.prv+'" style="width:100%;height:60px"></div>'+
                                       '  <br style="clear:both">'
                                      );  
						   
						 
						   if( typeof(upload_object[o.options.uploaderid]) == 'undefined' )
						   upload_object[o.options.uploaderid] = new Array();
						   
						   upload_object[o.options.uploaderid].push(data.code);
						   
						   console.log('upload_object -> ' + upload_object);
					}
					else
					{
						var error_msg = '';
						if($.isArray(data.msg) || $.isPlainObject(data.msg))
						{
						$.each(data.msg,function(k,v){
							error_msg += '<br />' + v ;
						})
						}
						else
						error_msg = data.msg;
						pwraper.find('.file-icon').addClass('fail');
						pwraper.
						find('.progress').
						replaceWith(error_msg+
						   '<a class="pull-left delete-upload"><i class="glyphicon glyphicon-remove"></i> </a>');
					}
				}
				else
				o.options.error();
			}
		});
		xhr.upload.addEventListener('progress' , function(event){
			
			var percent ; 
			if(event.lengthComputable === true )
			{
				percent = Math.round((event.loaded / event.total ) * 100 );
				console.log(percent);
 			//	pbar.attr('class', 'progalue value-'+percent);
				pbar.html(percent+'%');
				pbar.css('width' , percent+'%');
			}

		});
		
		
		
		xhr.open( 'post' , o.options.backend+'/upload/'+o.options.uploaderid );
		xhr.setRequestHeader("X-CSRF-Token", _token);
		xhr.send(data);
  	};
	
	
	getFormData = function(source){

		
		$.each(source , function(i,v){
			
			var current = o.options.progressBar.find('.preview').length;
			
			if( typeof(upload_object[o.options.uploaderid]) != 'undefined' && 
			upload_object[o.options.uploaderid].length >= o.options.maxup)
			return false;
			
			
			if(  current  >= o.options.maxup ) return ;
			
			var data = new FormData();
			data.append('files' , v );
			ajax(data);
			
			
		});
 	};
	
	setProgress = function(data){
	};
	
	o.uploader = function(options){

		o.options = options ;
		 if(o.options.files !== undefined )
		{ 
			getFormData(o.options.files);
		}
	};
	
	
}(uploader_app));