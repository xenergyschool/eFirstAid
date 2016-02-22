<app-efa>
	<div id="wrap" class="wrap">
		<div class="splash fadeIn animated">
			<div class="splash-image zoomIn animated">
				<img src="images/logo-big.png" alt="logo">
			</div>
			<!-- /splash-img -->
			<div class="splash-btn zoomIn animated">
				<a class="btn btn-start" id="start-me" onclick="{getStarted}">Get Started</a>
			</div>
			<!-- /splash-btn -->
		</div>
		<!-- /splash -->
		<div show={showContent} class="content">
			<div class="header animated">
				<div class="brand">
					<img src="images/logo.png">
					<span>eFIRST-AID</span>
				</div>
			</div>
			<!-- /header -->
			<div class="chat-box animated">
				<ul class="list-unstyled"> 
					<li each={ value , key in conversations} class="{value.type} clearfix"> 
						<div class="whois">
							<span class="person">{value.from}</span>
							<span class="date">{value.created_time}</span>
						</div>
						<div   class="{ value.type == 'client'?'pull-left':'pull-right'}" >
							<p each={ v , k in value.messages} if={v.length > 0}  class="clearfix { value.type == 'client'?'pull-left':'pull-right'}" >
								{ v }
								<span if={ typeof value.emergency_type !== 'undefined'} class="btn-box">
									<button class="btn btn-steps btn-warning" onclick="{getMedia}" data-type="steps">STEPS</button>
									<button class="btn btn-video btn-danger" onclick="{getMedia}" data-type="video" >VIDEO</button>
									<button class="btn btn-faq btn-primary" onclick="{getMedia}" data-type="faq" >FAQ</button>
								</span>
							</p>
						</div>
						
					</li>
					<li if={isEfaTyping} class="efa clearfix"> 
						<div class="whois">
							<span class="person">EFA</span>
						</div>
						<p class="pull-right"> is typing....</p>
					</li>
					
					
					
				</ul>
			</div>
			<!-- /chat-box -->
			<div class="msg-box animated">
				<form onsubmit="{sendChat}">
					<input class="msg-me form-control" type="text" placeholder="Type your message" onkeyup="{setMessage}" value="{message}" required>
					<button class="btn btn-send" type="submit" aria-label="Send"><i class="fa fa-paper-plane"></i></button>
				</form>
			</div> 
			<!-- /msg-box -->
		</div>
		<!-- /content -->
	</div>
	<!-- /wrap -->
	
	<div show={infoBox} class="info-box animated {emergencyMedia}">
		<div class="heading">
			<h2 class="title">{emergencyMedia} for treating {title[emergencyType]}</h2>
			<a onclick="{closeMedia}" class="closeme">&times;</a>
		</div>
		<div if={emergencyMedia == 'video'} class="content-body">
			<div class="embed-responsive embed-responsive-16by9">
				<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/{media.video}"></iframe>
			</div>
			<div class="video-description">
				<h3> Lorem ipsum dolor sit amet, consectetur adipiscing elit.</h3>
				<p>Ut ac aliquam metus, quis pharetra mi. Quisque cursus nibh metus, nec aliquet urna tempus ac. Fusce urna purus, egestas at risus ac, aliquet tincidunt mi. Sed hendrerit risus enim, ut vestibulum quam sagittis non. Aliquam a nulla in turpis pellentesque faucibus. Fusce tincidunt tellus mauris, et commodo velit iaculis ac. In tristique pulvinar magna eu ornare. </p>
				
			</div>
		</div>
		<div if={emergencyMedia == 'steps'} class="content-body">
			
			<ul class="list-unstyled">
				<li each={v, k in media.steps}>
					<span class="step-no"> {k+1}</span>
					<h3>{v.title}</h3>
					<p>{v.description}</p>
				</li>
			</ul>
			
		</div>
		<div if={emergencyMedia == 'faq'} class="content-body">
			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
				<div  each={v, k in media.faq} class="panel panel-default">
					<div class="panel-heading" role="tab" id="heading{k}">
						<h4 class="panel-title">
							<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse{k}" aria-expanded="true" aria-controls="collapseOne">
								{v.question}
							</a>
						</h4>
					</div>
					<div id="collapse{k}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
						<div class="panel-body">
							{v.answer}
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	<!-- /info-box -->
	
	
	<script>
		var self = this
		self.message = ''
		self.conversationId = 'start'
		self.clientId = ''
		self.isEfaTyping = false
		self.conversations = []
		self.emergencyType = ''
		self.emergencyMedia = ''
		self.profile = []
		self.media = []
		self.title = {
			"allergies" : "Allergies",
			"bleeding" : "Bleeding",
			"asthmaattack" :" Asthma Attack",
			"brokenbone" : "Broken Bone",
			"burns" : "Burns",
			"choking":"Choking",
			"diabetes" : "Diabetes",
			"distress" : "Distress",
			"epilepsy":"Epilepsy",
			"headinjury":"Head Injury",
			"heartattack":"Heart Attack",
			"hypotermia":"Hypotermia",
			"meningitis":"Meningitis",
			"poisoning":"Poisoning",
			"sprains":"Sprains",
			"stroke":"Stroke",
			"unconsciousandbreathing":"Unconscious and Breathing",
			"unconsciousandnotbreathing":"Unconscious and Not Breathing",
			"unconsciousandnotbreathingaed":"Unconscious and Not Breathing when an AED is available"
			
		}
		
		
		self.on('mount',function(){
			self.trigger('send_chat')
			
			self.initScroll()
			
			$('.splash-btn').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
				
				$(".splash-btn")
				.removeClass("zoomIn")
				.addClass	("pulse")
				.addClass	("infinite");
			})
			
		})
		
		self.getStarted = function(){
			$(".splash-image, .splash-btn")
			.removeClass("zoomIn")
			.addClass("fadeOut");
			
			$(".splash")
			.removeClass("fadeIn")
			.addClass("splash-exit");
			
			self.showContent = true
			self.update()
			
			$(".header")
			.addClass("fadeInDown")
			.addClass("go");
			
			$(".msg-box")
			.addClass("fadeInUp")
			.addClass("go");
			
			$(".chat-box")
			.addClass("bounceInDown")
			.addClass("go");
			
			
			
		}
		
		self.getMedia = function(e){
			self.message = $(e.target).attr('data-type')
			self.trigger('send_chat')
			
		}
		
		self.setMessage = function(e){
			
			
			
			self.message = e.target.value
			self.update()
		}
		
		self.sendChat = function(e){
			e.preventDefault()
			if(self.message.trim().length > 0){
				
				self.conversations.push({ type : 'client',from : 'You', created_time: moment().format('MMM Do YYYY, h:mm a'), messages : [self.message]})
				self.trigger('send_chat')
				self.scrollDown()
			}
			
		}
		
		self.on('send_chat',function(){
			self.isEfaTyping = true
			self.update()
			self.scrollDown()
			
			var parameter = { conversation_id : self.conversationId , client_id : self.clientId, input : self.message , _csrf : csrfToken }
			$.post('/efa/conversation',parameter,function(response){
				self.conversationId = response.conversation_id
				self.clientId = response.client_id
				
				self.message = ''
				
				self.conversations.push(  { type : 'efa' , from : 'EFA', created_time: moment().format('MMM Do YYYY, h:mm a'), messages : response.response} )
				self.isEfaTyping = false
				self.update()
				$('input').focus()
				console.log(self.conversations)
				
				self.trigger('get_profile')
				
				self.scrollDown()
				
			})
			self.message = ''
			self.update()
		})
		
		
		self.on('get_profile',function(){
			var parameter = { client_id : self.clientId , _csrf : csrfToken }
			
			$.get('/efa/profile',parameter,function(response){
				self.profile = response.name_values
				var index = self.getIndexIfObjWithOwnAttr(self.profile,'name','emergency_type')
				console.log(self.profile)
				if(index > -1){
					
					if(self.profile[index].value !== self.emergencyType){
						self.emergencyType = self.profile[index].value
						self.conversations.push(  { type : 'efa' , emergency_type : self.emergencyType ,from : 'EFA', created_time: moment().format('MMM Do YYYY, h:mm a'), messages : ['Which information would you like to see?']} )
						self.update()
						self.scrollDown()
						self.closeMedia()
					}
					console.log(self.profile)
					}else{
					
					self.emergencyType = ''
					self.update()
					
				}
				
				var indexMedia = self.getIndexIfObjWithOwnAttr(self.profile,'name','emergency_media')
				
				if(indexMedia > -1){
					if(self.profile[indexMedia].value !== self.emergencyMedia){
						self.emergencyMedia = self.profile[indexMedia].value
						
						self.update()
						self.closeMedia()
						self.trigger('get_media')
						
					}
					
				}
				console.log(self.emergencyType)
			})
			
			
		})
		
		self.on('get_media',function(){
			var parameter = { emergency_type: self.emergencyType , _csrf : csrfToken }
			$.get('/efa/media',parameter,function(response){
				self.media = response
				console.log(self.media)
				
				$(".wrap")
				.removeClass("comeback")
				.addClass("goLeft");
				
				self.infoBox = true
				self.update()
				
				$(".info-box")
				.removeClass("bounceOutRight")
				.addClass("bounceInRight");
				$('.chat-box').getNiceScroll().resize();
				
				
			})
			
		})
		
		self.closeMedia = function(){
			
			$(".wrap")
			.removeClass("goLeft")
			.addClass("comeback");
			
			$(".info-box")
			.removeClass("bounceInRight")
			.addClass("bounceOutRight");
			self.infoBox = false
			self.update()
			$('.chat-box').getNiceScroll().resize();
			
		}
		
		$(document).on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend','.info-box,.wrap',function(){
			$('.chat-box').getNiceScroll().resize();
			
		})
		self.scrollDown = function(){
			
			$('.chat-box').animate({ scrollTop: $('.list-unstyled').height() }, 800);
		}
		self.initScroll = function() {
			$('.chat-box, .content-body').niceScroll({
				mousescrollstep: 100,
				cursorcolor: '#ccc',
				cursorborder: '',
				cursorwidth: 3,
				hidecursordelay: 100,
				autohidemode: 'scroll',
				horizrailenabled: false,
				preservenativescrolling: false,
				railpadding: {
					right: 0.5,
					top: 1.5,
					bottom: 1.5
				} 
			});
		}
		
		self.getIndexIfObjWithOwnAttr = function(array, attr, value) {
			for(var i = 0; i < array.length; i++) {
				if(array[i].hasOwnProperty(attr) && array[i][attr] === value) {
					return i;
				}
			}
			return -1;
		}
		
		
	</script>
	
</app-efa>