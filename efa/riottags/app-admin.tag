<app-admin>
    <h1> Update EFA Core </h1>
    <hr>
    
    <div>
        <a class="btn btn-md btn-primary btn-upload" onclick="{browseCore}"> Upload New Core</a>
        <p class="text-danger">{uploadStatus}</p> 
    </div>
    
    <form id="form-upload" action="/admin/uploadcore" method="post" enctype="multipart/form-data">
			<input type="file" id="core-upload" class="file-input" form="form-upload" name="coreFile" onchange="{uploadCore}" style="opacity:0; height:0px;width:0px;" accept="application/xml">
	</form>
    <script>
        var self = this
        self.uploadStatus = ''
        self.uploadPercentage =''
        
        self.on('mount',function(){
        //console.log(csrfToken)
        
        })
        
        self.browseCore = function(){
        
        $('#core-upload').trigger('click')
        }
        
        self.uploadCore = function(){
        
        $('form#form-upload').ajaxSubmit({
			data : {'_csrf': csrfToken },
			beforeSubmit : self.beforeSubmitUpload,
			beforeSend: function() {
				
				var percentVal = '0%';
				self.uploadPercentage = percentVal
				self.update()
			},
			uploadProgress: function(event, position, total, percentComplete) {
				var percentVal = percentComplete + '%';
				self.uploadPercentage = percentVal
				self.update()
				
			},
			error: function() {
				self.uploadPercentage = ''
				self.uploadStatus = 'Something went wrong!'
				self.update()
			},
			dataType:  'json',
			success : function(data){
			//	self.uploadImageSuccess(data)
				////console.log(data)
			}
		});
        
        
        }
        
        
        self.beforeSubmitUpload = function() {
		//check whether browser fully supports all File API
		if (window.File && window.FileReader && window.FileList && window.Blob) {
			if (!$('#core-upload').val()) //check empty input filed
			{
				self.uploadStatus = 'You canceled upload dialog'
				self.update()
				return false
			}
			var fsize = $('#core-upload')[0].files[0].size; //get file size
			var ftype = $('#core-upload')[0].files[0].type; // get file type
			//allow only valid image file types
			switch (ftype) {
				case 'application/xml':
				case 'text/xml':
				break;
				default:
				self.uploadStatus = ftype + ' Unsupported file type!'
				self.update()
				return false
			}
			//Allowed file size is less than 1 MB (1048576)
			if (fsize > 10485760) {
				self.uploadStatus = fsize + ' Too big Image file! Please reduce the size of your photo using an image editor.'
				self.update()
				return false
			}
			
			self.uploadStatus = ''
		
			self.update()
			} else {
			//Output error to older browsers that do not support HTML5 File API
			self.uploadImageStatus = 'Please upgrade your browser, because your current browser lacks some new features we need!'
			self.update()
			return false;
		}
	}
        
        
    </script>


</app-admin>