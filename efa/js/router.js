var router = {
				contentPage : null,
				home : function(){
					
					this.contentPage = this.mountContent('app-efa')
					
				},
				admin : function(){
					this.contentPage = this.mountContent('app-admin')
					
				},
			
				handler : function(collection, id, action){
					//var _this = this;
					
					
					switch(collection){
						case 'admin':
						router.admin()
						break;
						default:
						router.home()
						break;
						
					}
				},
				mountContent : function(tag,options){
					
					this.contentPage && this.contentPage.unmount(true);
					
					riot.mount('div#main-content',tag,options);
				},
				
			}